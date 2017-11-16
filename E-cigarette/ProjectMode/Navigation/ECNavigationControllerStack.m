//
//  ECNavigationControllerStack.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECNavigationControllerStack.h"

@interface ECNavigationControllerStack()
@property (nonatomic, strong, readwrite) NSMutableArray *navigationControllers;
@end

@implementation ECNavigationControllerStack

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ECNavigationControllerStack *navigationControllerStack = [super allocWithZone:zone];
    @weakify(navigationControllerStack)
    [[navigationControllerStack rac_signalForSelector:@selector(initWithService:)] subscribeNext:^(id x) {
        @strongify(navigationControllerStack)
        [navigationControllerStack regisNavigationHooks];
    }];
    return navigationControllerStack;
}

- (instancetype)initWithService:(id<UIViewModeService>)service{
    self = [super init];
    if (self) {
        _service = service;
        _navigationControllers = [NSMutableArray array];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController{
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController{
    UINavigationController *navigationController = [self.navigationControllers lastObject];
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController{
    return self.navigationControllers.lastObject;
}

- (void)regisNavigationHooks{
    @weakify(self)
    [[(NSObject *)self.service rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple *tuple) {
       @strongify(self)
        UIViewController *viewController = (UIViewController *)[[ECRouter sharedInstance] viewControllerForViewMode:tuple.first];
        [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
    }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        UIViewController *viewController = (UIViewController *)[[ECRouter sharedInstance] viewControllerForViewMode:tuple.first];
        UINavigationController *presentingViewController = self.navigationControllers.lastObject;
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[ECNavViewController alloc] initWithRootViewController:viewController];
        }
        [self pushNavigationController:(UINavigationController *)viewController];
        [presentingViewController presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [self popNavigationController];
        [self.navigationControllers.lastObject dismissViewModelAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        UIViewController *viewController = (UIViewController *)[[ECRouter sharedInstance] viewControllerForViewMode:tuple.first];
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[ECNavViewController alloc] initWithRootViewController:viewController];
        }
        [self.navigationControllers removeAllObjects];
        ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = viewController;
    }];
}
@end
