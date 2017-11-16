//
//  ECDeviceConnect.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/24.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <ReactiveCocoa/RACDynamicSignal.h>
#import "ECSannendPeripheral.h"

typedef NS_ENUM(NSInteger, ECError){
    ECErrorUnkonwn                             = 1001,
    ECErrorSearchTimeOut                       ,
    ECErrorPoweredOff                          ,
    ECErrorConnectTimeOut                      ,
    ECErrorConnectFinish                       ,
};

@class ECSannendPeripheral;

@interface ECDeviceConnect : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong, readonly) RACCommand *serchCommand, *connectCommand, *reunitonCommand;

@property (nonatomic, strong, readonly) RACReplaySubject *errorSubject;

@property (nonatomic, strong, readonly) RACReplaySubject *searchSubject;

@property (nonatomic, strong, readonly) RACSignal *peripheralsSubject;

@property (nonatomic, strong, readonly) RACDisposable *reunionDisposable;

@property (nonatomic, strong) CBCentralManager *cenManger;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSArray *searchNames;

@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@property (nonatomic, strong) NSMutableArray <ECSannendPeripheral *>*peripherals;

+ (instancetype)shareBlueTool;

- (void)deallocSignal;
@end
