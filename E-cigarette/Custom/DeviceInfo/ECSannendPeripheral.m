//
//  ECSannendPeripheral.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/26.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECSannendPeripheral.h"

@implementation ECSannendPeripheral
@synthesize peripheral;
@synthesize RSSI;

+ (ECSannendPeripheral*) initWithPeripheral:(CBPeripheral*)peripheral rssi:(int)RSSI UUID:(NSString *)uuid{
    ECSannendPeripheral* value = [ECSannendPeripheral alloc];
    value.peripheral = peripheral;
    value.RSSI = RSSI;
    value.UUIDstring = peripheral.identifier.UUIDString;
    return value;
}

-(NSString*) name{
    NSString* name = [peripheral name];
    if (name == nil){
        return @"No name";
    }
    return name;
}

-(BOOL)isEqual:(id)object{
    ECSannendPeripheral* other = (ECSannendPeripheral*) object;
    return peripheral == other.peripheral;
}
@end
