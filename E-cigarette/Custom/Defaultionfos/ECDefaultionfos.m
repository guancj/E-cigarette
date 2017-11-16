//
//  ECDefaultionfos.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/17.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECDefaultionfos.h"

NSString *const FirstLun = @"FirstLun";
NSString *const NavHeight = @"NavHeight";
NSString *const DeviceUUID = @"DeviceUUID";
NSString *const Puffs = @"Puffs";
NSString *const PuffsDay = @"PuffsDay";
NSString *const cyclePuffs = @"cyclePuffs";
NSString *const workTime = @"workTime";
NSString *const Temp = @"Temp";

NSString *const Voltage = @"Voltage";
NSString *const Recharge = @"Recharge";
NSString *const RechargeT = @"RechargeT";
NSString *const Shake = @"shake";

@implementation ECDefaultionfos
+ (void)ECputKey:(NSString *)key andValue:(NSObject *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+ (void)ECputInt:(NSString *)key andValue:(int)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}


+ (id)ECgetValueforKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id result = [defaults objectForKey:key];
    if(!result){
        result = nil;
    }
    return result;
}

+ (int)ECgetIntValueforKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int result = (int)[defaults integerForKey:key];
    return result;
}

+ (void)ECremoveValueForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
}
@end
