//
//  ECRouter.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECRouter.h"
#import "ECViewModelProtocol.h"
#import "ECViewModel.h"

@interface ECRouter ()

@property (nonatomic, strong) NSDictionary *viewModelViewMappings;

@end

@implementation ECRouter

+ (instancetype)sharedInstance{
    static ECRouter *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (ECViewController *)viewControllerForViewMode:(ECViewModel *)viewModel{
    NSString *viewController = [self.viewModelViewMappings valueForKey:NSStringFromClass(((NSObject *)viewModel).class)];
    NSParameterAssert([NSClassFromString(viewController) conformsToProtocol:@protocol(ECViewProtocol)]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings{
    return @{@"FirstLunMode":@"ViewController",@"SignViewModel":@"ECSignViewController",@"ResetViewModel":@"ResetViewController",@"HomeViewModel":@"HomeViewController",@"LoginViewModel":@"ECLoginViewController",@"SelViewModel":@"ECSelectViewController",@"SearchViewModel":@"ECSearchViewController",@"GeneralViewModel":@"ECGeneralViewController"};
}
@end
