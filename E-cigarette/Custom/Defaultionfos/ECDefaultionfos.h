//
//  ECDefaultionfos.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/17.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const FirstLun;
UIKIT_EXTERN NSString *const NavHeight;
UIKIT_EXTERN NSString *const DeviceUUID;
UIKIT_EXTERN NSString *const Puffs;
UIKIT_EXTERN NSString *const PuffsDay;
UIKIT_EXTERN NSString *const cyclePuffs;
UIKIT_EXTERN NSString *const workTime;
UIKIT_EXTERN NSString *const Temp;

UIKIT_EXTERN NSString *const Voltage;
UIKIT_EXTERN NSString *const Recharge;
UIKIT_EXTERN NSString *const RechargeT;
UIKIT_EXTERN NSString *const Shake;

@interface ECDefaultionfos : NSObject
+ (void)ECputKey:(NSString *)key andValue:(NSObject *)value;
+ (void)ECputInt:(NSString *)key andValue:(int)value;
+ (id)ECgetValueforKey:(NSString *)key;
+ (int)ECgetIntValueforKey:(NSString *)key;
+ (void)ECremoveValueForKey:(NSString *)key;
@end
