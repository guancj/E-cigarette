//
//  ECSannendPeripheral.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/26.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ECSannendPeripheral : NSObject
@property (strong, nonatomic) CBPeripheral* peripheral;
@property (strong, nonatomic) NSString* UUIDstring;
@property (assign, nonatomic) int RSSI;

+ (ECSannendPeripheral*) initWithPeripheral:(CBPeripheral*)peripheral rssi:(int)RSSI UUID:(NSString *)uuid;
- (NSString*) name;
@end
