//
//  UINavigationItem+EC.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "UINavigationItem+EC.h"
#import <objc/runtime.h>

@implementation UINavigationItem (EC)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(backBarButtonItem);//需要替换的方法
        SEL swizzledSelector = @selector(ut_backBarButtonItem);//替换后方法
        Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if (success) {
           success = class_replaceMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        }
        else{
            method_exchangeImplementations(class_getInstanceMethod(class, originalSelector), swizzleMethod);
        }
    });
}

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        SEL originalSelector = @selector(backBarButtonItem);//需要替换的方法
//        SEL swizzledSelector = @selector(ut_backBarButtonItem);//替换后方法
////    SEL originalSelector0 = @selector(setBackBarButtonItem:);//需要替换的方法
////    SEL swizzledSelector = @selector(ut_setBackBarButtonItem:);//替换后方法
//        Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
//
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
//        if (success) {
//            success = class_replaceMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
//        }
//        else{
//            method_exchangeImplementations(class_getInstanceMethod(class, originalSelector), swizzleMethod);
//        }
//    });
//    unsigned int cont;
//    Method *methods = class_copyMethodList([self class], &cont);
//    for (unsigned int i = 0; i < cont; i ++) {
//        Method method = methods[i];
//        SEL sel = method_getName(method);
//        NSLog(@"UINavigationItem所有方法 %@",NSStringFromSelector(sel));
//    }
//}

- (void)ut_setBackBarButtonItem:(UIBarButtonItem *)ut_backBarButtonItem{
    [self ut_setBackBarButtonItem:ut_backBarButtonItem];
}

#pragma mark - Method Swizzling
- (UIBarButtonItem *)ut_backBarButtonItem {
    UIBarButtonItem *barButtonName = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:NULL];
    [barButtonName setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:37.f], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [barButtonName setTintColor:[UIColor whiteColor]];
    return barButtonName;
    
}
@end
