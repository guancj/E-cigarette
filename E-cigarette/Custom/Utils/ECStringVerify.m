//
//  ECStringVerify.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECStringVerify.h"

@implementation ECStringVerify
+ (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (CGRect)getSize:(NSString *)str strDic:(NSDictionary *)dic{
    CGRect labelSize = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return labelSize;
}

+ (UIView *)createTitleViewView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ECMainScreen.size.width * 2/3.5, 44)];
//    navView.backgroundColor = ECMediumSkyBlueColor;
//    navView.backgroundColor = [UIColor greenColor];
    UILabel *lab = [[UILabel alloc] init];
    [navView addSubview:lab];
    lab.text = @"&";
    lab.textColor = [UIColor whiteColor];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(navView);
    }];
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_3"]];
     [navView addSubview:leftImage];
    [leftImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab.mas_left).mas_offset(-8);
        make.centerY.mas_equalTo(lab.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_1"]];
     [navView addSubview:rightImage];
    [rightImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(lab.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    return navView;
}
@end
