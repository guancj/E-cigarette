//
//  ECStringVerify.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECStringVerify : NSObject
+ (BOOL)isValidateEmail:(NSString *)email;
+ (CGRect)getSize:(NSString *)str strDic:(NSDictionary *)dic;
+ (UIView *)createTitleViewView;
@end
