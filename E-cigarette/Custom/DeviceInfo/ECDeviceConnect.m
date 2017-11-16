//
//  ECDeviceConnect.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/24.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECDeviceConnect.h"

@interface ECDeviceConnect ()
@property (nonatomic, strong, readwrite) RACCommand *serchCommand, *connectCommand, *reunitonCommand;
@property (nonatomic, strong, readwrite) RACReplaySubject *errorSubject, *searchSubject;;
@property (nonatomic, strong, readwrite) RACSignal *peripheralsSubject;
@property (nonatomic, strong, readwrite) RACDisposable *reunionDisposable;
@property (nonatomic, strong) NSTimer *searchTimer, *reunitonTimer;
@end

@implementation ECDeviceConnect

+ (instancetype)shareBlueTool{
    static ECDeviceConnect *connect = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connect = [[self alloc] init];
        [connect initialize];
    });
    return connect;
}

- (void)initialize{
    @weakify(self)
    self.serchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *searchT) {
        @strongify(self)
        if ([searchT intValue] == 0) {
            if (self.searchTimer) {
                [self.searchTimer invalidate];
                self.searchTimer = nil;
            }
            [self.cenManger stopScan];
        }
        else{
            if (!self.cenManger) {
                self.cenManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_queue_create("ecdispatch", DISPATCH_QUEUE_CONCURRENT) options:@{CBCentralManagerOptionShowPowerAlertKey:@NO}];
            }else{
                [self searchReunitonPeripheral:nil];
            }
            if (self.searchTimer) {
                [self.searchTimer invalidate];
                self.searchTimer = nil;
            }
        }
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            if (!self.searchTimer && [searchT intValue] > 0 && self.peripheral.state != CBPeripheralStateConnected) {
                self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:[searchT intValue] target:self selector:@selector(searchTimeOut) userInfo:subscriber repeats:NO];
                [[NSRunLoop currentRunLoop] addTimer:self.searchTimer forMode:NSRunLoopCommonModes];
            }
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }];
    
    self.connectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *connectT) {
        @strongify(self)
        if (self.searchTimer) {
            [self.searchTimer invalidate];
            self.searchTimer = nil;
        }
        [self.cenManger stopScan];
        if ([connectT intValue] == 0) {
            if (self.peripheral) {
                [self.cenManger cancelPeripheralConnection:self.peripheral];
            }
            self.peripheral = nil;
        }
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            if (!self.searchTimer && [connectT intValue] > 0) {
                [self connectPeripheral:self.peripheral];
                self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:[connectT intValue] target:self selector:@selector(connectTimeOut) userInfo:subscriber repeats:NO];
                [[NSRunLoop currentRunLoop] addTimer:self.searchTimer forMode:NSRunLoopCommonModes];
            }
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    self.reunitonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *reuniton) {
        @strongify(self)
        [self reunitonPeripheral:reuniton];
        return [RACSignal empty];
    }];
    
    _searchSubject = [RACReplaySubject subject];
}

//- (CBCentralManager *)cenManger{
//    if (!_cenManger) {
//        _cenManger = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_queue_create("ecdispatch", DISPATCH_QUEUE_CONCURRENT) options:@{CBCentralManagerOptionShowPowerAlertKey:@NO}];
//    }
//    return _cenManger;
//}

- (RACReplaySubject *)errorSubject{
    if (!_errorSubject) {
        _errorSubject = [RACReplaySubject subject];
    }
    return _errorSubject;
}

- (NSMutableArray <ECSannendPeripheral *>*)peripherals{
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (void)searchTimeOut{
    [self.searchTimer invalidate];
    self.searchTimer = nil;
    [self.cenManger stopScan];
    [_errorSubject sendNext:[self callBackBLEErrorWithCode:ECErrorSearchTimeOut]];
}

- (void)connectTimeOut{
    [self.cenManger stopScan];
    [self.searchTimer invalidate];
    self.searchTimer = nil;
    [_errorSubject sendNext:[self callBackBLEErrorWithCode:ECErrorConnectTimeOut]];
}

- (void)connectPeripheral:(CBPeripheral *)p{
    if (p) {
        self.peripheral = p;
        self.peripheral.delegate = self;
        [self.cenManger connectPeripheral:self.peripheral options:nil];
    }
}

- (void)reunitonPeripheral:(NSNumber *)reuniton{
    if ([reuniton boolValue]) {
        if ([ECDefaultionfos ECgetValueforKey:DeviceUUID]) {
            if (!self.cenManger) {
                [self.serchCommand execute:@(12)];
            }
            if (!self.reunionDisposable) {
                @weakify(self)
//                self.reunionDisposable = [[RACSignal interval:[reuniton intValue] onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//                    NSLog(@"RACSignal interval %@",x);
                    @strongify(self)
//                    [self searchReunitonPeripheral:nil];
//                }];
            }
        }
    }else{
        [self.reunionDisposable dispose];
        self.reunionDisposable = nil;
    }
}

- (void)searchReunitonPeripheral:(NSNumber *)retniton{
    if (!self.peripheral || [self.peripheral state] != CBPeripheralStateConnected) {
        NSArray *savePer = [self.cenManger retrievePeripheralsWithIdentifiers:@[[[NSUUID alloc] initWithUUIDString:[ECDefaultionfos ECgetValueforKey:DeviceUUID]]]];
        if (savePer.count > 0) {
            [self connectPeripheral:[savePer firstObject]];
        }else{
            [self.peripherals removeAllObjects];
            [self.cenManger scanForPeripheralsWithServices:nil options:nil];
        }
    }
}

#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            [_errorSubject sendNext:[self callBackBLEErrorWithCode:ECErrorPoweredOff]];
            break;
        case CBCentralManagerStatePoweredOn:
            [self searchReunitonPeripheral:nil];
            //            [self.peripherals removeAllObjects];
            //            [self.cenManger scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
//    NSLog(@"didDiscoverPeripheral %@",peripheral);
    if ([[ECDefaultionfos ECgetValueforKey:DeviceUUID] isEqualToString:peripheral.identifier.UUIDString]) {
        [self connectPeripheral:peripheral];
    }
    if ([self.searchNames containsObject:peripheral.name] && RSSI.intValue < 0) {
        ECSannendPeripheral *sanPer = [ECSannendPeripheral initWithPeripheral:peripheral rssi:RSSI.intValue UUID:peripheral.identifier.UUIDString];
        if (![self.peripherals containsObject:sanPer]) {
            [self.peripherals addObject:sanPer];
        } else{
            sanPer = [self.peripherals objectAtIndex:[self.peripherals indexOfObject:sanPer]];
            sanPer.RSSI = RSSI.intValue;
        }
        NSArray *sortedArr = [self.peripherals sortedArrayUsingComparator:^NSComparisonResult(ECSannendPeripheral *obj1, ECSannendPeripheral *obj2) {
            if (obj1.RSSI > obj2.RSSI){
                return NSOrderedAscending;
            }
            if (obj1.RSSI  < obj2.RSSI ){
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        self.peripherals = [sortedArr mutableCopy];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [self.peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *s in peripheral.services) {
        if ([s.UUID.UUIDString isEqualToString:@"FFF0"] || [s.UUID.UUIDString isEqualToString:@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"]) {
        NSLog(@"s.UUID.UUIDStrin %@",s.UUID.UUIDString);
            [peripheral discoverCharacteristics:nil forService:s];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"发现到特定蓝牙特征时调用");
    for (CBCharacteristic * characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF1"] || [characteristic.UUID.UUIDString isEqualToString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//             [peripheral readValueForCharacteristic:characteristic];
        }
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF2"] || [characteristic.UUID.UUIDString isEqualToString:@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"]) {
            self.writeCharacteristic = characteristic;
            [ECDefaultionfos ECputKey:DeviceUUID andValue:peripheral.identifier.UUIDString];
            [self.searchTimer invalidate];
            self.searchTimer = nil;
            [self.cenManger stopScan];
            [self.errorSubject sendNext:[self callBackBLEErrorWithCode:ECErrorConnectFinish]];
        }
        [peripheral readValueForCharacteristic:characteristic];
    }
}

-(void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"************************didUpdateValueForCharacteristic %@",characteristic.value);
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    NSLog(@"*************************didWriteValueForCharacteristic  %@",error);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败 %@",error);
    [self.errorSubject sendNext:error];
    if (self.peripheral && [ECDefaultionfos ECgetValueforKey:DeviceUUID] && ![[ECDefaultionfos ECgetValueforKey:DeviceUUID] isEqualToString:@""]) {
        [self connectPeripheral:peripheral];
    }
}

- (void)deallocSignal{
    _errorSubject = nil;
}

- (NSError *)callBackBLEErrorWithCode:(ECError)code{
    NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:code userInfo:GetErrorStatus(code)];
    NSLog(@"callBackBLEErrorWithCode %@",error);
    return error;
}

NSDictionary *GetErrorStatus(ECError code){
    switch (code) {
        case ECErrorUnkonwn:
            return [NSDictionary dictionaryWithObjectsAndKeys:ECLocalizedString(@"未知原因", nil), NSLocalizedDescriptionKey,ECLocalizedString(@"原因：未知", nil),NSLocalizedFailureReasonErrorKey,nil];
            break;
        case ECErrorSearchTimeOut:
            return [NSDictionary dictionaryWithObjectsAndKeys:ECLocalizedString(@"搜索超时", nil), NSLocalizedDescriptionKey,ECLocalizedString(@"原因：搜索超时", nil),NSLocalizedFailureReasonErrorKey,nil];
            break;
        case ECErrorPoweredOff:
            return [NSDictionary dictionaryWithObjectsAndKeys:ECLocalizedString(@"蓝牙未打开", nil), NSLocalizedDescriptionKey,ECLocalizedString(@"原因：蓝牙未打开", nil),NSLocalizedFailureReasonErrorKey,nil];
            break;
        case ECErrorConnectTimeOut:
            return [NSDictionary dictionaryWithObjectsAndKeys:ECLocalizedString(@"连接超时", nil), NSLocalizedDescriptionKey,ECLocalizedString(@"原因：连接超时", nil),NSLocalizedFailureReasonErrorKey,nil];
            break;
        case ECErrorConnectFinish:
            return [NSDictionary dictionaryWithObjectsAndKeys:ECLocalizedString(@"连接成功", nil), NSLocalizedDescriptionKey,ECLocalizedString(@"原因：连接成功", nil),NSLocalizedFailureReasonErrorKey,nil];
            break;
        default:
            return nil;
            break;
    }
}
@end
