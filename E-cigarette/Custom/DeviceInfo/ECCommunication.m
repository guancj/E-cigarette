//
//  ECCommunication.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/28.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECCommunication.h"
#import "ECDeviceConnect.h"

@interface ECCommunication ()
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *writeChar;
@property (nonatomic, strong) NSMutableArray *sendList;
@end

@implementation ECCommunication

+ (instancetype)shareCommunication{
    static ECCommunication *commun = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commun = [[self alloc] init];
        [commun initialize];
    });
    return commun;
}

- (NSMutableArray *)sendList{
    if (!_sendList) {
        _sendList = [NSMutableArray array];
    }
    return _sendList;
}

- (void)initialize{
    RAC(self,peripheral) = RACObserve([ECDeviceConnect shareBlueTool], peripheral);
    RAC(self,writeChar) = RACObserve([ECDeviceConnect shareBlueTool], writeCharacteristic);
}

- (void)sendUtfData:(NSData *)data commandState:(command)state{
    Byte result[11] = {0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30};
    result[0] = 0x02;
    result[1] = state&0xff;
    result[9] = 0x0d;
    result[10] = 0x0a;
    Byte *byteD = (Byte *)[data bytes];
    memcpy(&result[2 + (6-data.length)], byteD, data.length);
    int byteAll = 0;
    for (int i = 0; i < 11; i ++) {
        byteAll = byteAll + result[i];
    }
    result[8] = (Byte)((byteAll>>0)&0xff);
    NSData *sendData = [NSData dataWithBytes:result length:11];
    NSLog(@"commandState %@   *",sendData);
    if (_peripheral && _writeChar && _peripheral.state == CBPeripheralStateConnected) {
        [_peripheral writeValue:sendData forCharacteristic:_writeChar type:CBCharacteristicWriteWithResponse];
//        [self.sendList addObject:sendData];
//        Byte buf[1] = {0x01};
//        Byte results[14];
//        [self getSpliceCmd:0x05 Key:0x06 bytes1:buf len:1 results:results];//关闭同步
//        NSData *sendData = [NSData dataWithBytes:results length:14];
//        NSLog(@"commandState关闭同步 %@   *",sendData);
//         [_peripheral writeValue:sendData forCharacteristic:_writeChar type:CBCharacteristicWriteWithResponse];
    }
}

- (void)getSpliceCmd:(Byte)cmd Key:(Byte)key bytes1:(Byte [])bytes1 len:(int)len results:(Byte [])results
{
    int serialNum = 2;
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"serialNUN" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"serialNUN" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",serialNum],@"SERIANUM", nil]]];
    results[0]=0xAB;
    results[1]=0x00;
    //版本号、Ack应答状态
    results[2]=(Byte)(((len+5)>>8)&0xff);
    results[3]=(Byte)(((len+5)>>0)&0xff);
    //序列号
    results[6] =(Byte)((serialNum>>8)&0xff);
    results[7] =(Byte)((serialNum>>0)&0xff);
    //命令码
    results[8]=cmd;
    //命名码标示
    results[9] =0x00;
    //key值
    results[10]=key;
    serialNum++;
    //命令内容的长度：value
    results[11] =(Byte)((len>>8)&0xff);
    results[12] =(Byte)((len>>0)&0xff);
    
    [self copyValue:bytes1 len:len dataBytes:results len1:13];
    
    //    [self getCRC16:results];
}

-(void)copyValue:(Byte[])bytes len:(Byte)len dataBytes:(Byte[])dataBytes len1:(int)len1
{
    for (int i=0; i<len; i++) {
        NSLog(@"%x",bytes[i]);
        dataBytes[len1+i]=bytes[i];
        NSLog(@"%@",[NSData dataWithBytes:dataBytes length:len1 + i]);
    }
}
@end
