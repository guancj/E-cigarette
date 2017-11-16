//
//  ECStoredInfo.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ECUser;

@interface ECStoredInfo : NSObject
+ (instancetype)shareStored;
- (void)saveUser:(ECUser *)user;
- (ECUser *)user;
@end
