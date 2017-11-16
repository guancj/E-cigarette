//
//  ECUser.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECUser.h"

@implementation ECUser
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _userId = [aDecoder decodeObjectForKey:@"userId"];
        _userAcc = [aDecoder decodeObjectForKey:@"userAcc"];
        _userPs = [aDecoder decodeObjectForKey:@"userPs"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_userAcc forKey:@"userAcc"];
    [aCoder encodeObject:_userPs forKey:@"userPs"];
}
@end
