//
//  UIImage+EC.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "UIImage+EC.h"

@implementation UIImage (EC)
+ (UIImage *)ECimageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
