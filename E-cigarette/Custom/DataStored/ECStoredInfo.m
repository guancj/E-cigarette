//
//  ECStoredInfo.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECStoredInfo.h"
#import "ECUser.h"

#define ECAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ECUser.data"]
@implementation ECStoredInfo

+ (instancetype)shareStored{
    static ECStoredInfo *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

- (void)saveUser:(ECUser *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:ECAccountFile];
}

- (ECUser *)user{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:ECAccountFile];
}
@end
