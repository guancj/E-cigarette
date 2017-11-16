//
//  ECNavigationControllerStack.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECNavViewController.h"
#import "UIViewModeService.h"
#import "ECRouter.h"
#import "AppDelegate.h"

@interface ECNavigationControllerStack : NSObject
@property (nonatomic, strong, readonly) id<UIViewModeService> service;
- (instancetype)initWithService:(id<UIViewModeService>) service;
- (void)pushNavigationController:(UINavigationController *)navigationController;
- (UINavigationController *)popNavigationController;
- (UINavigationController *)topNavigationController;
@end
