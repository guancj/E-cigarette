//
//  ECUser.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECUser : NSObject<NSCoding>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userAcc;
@property (nonatomic, copy) NSString *userPs;
@end
