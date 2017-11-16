//
//  ECViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewController.h"
#import "ECViewModel.h"

@interface ECViewController ()
@property (nonatomic, strong) ECViewModel *viewModel;
@end

@implementation ECViewController


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ECViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController binViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(id<ECViewModelProtocol>)viewModel{
    self = [self init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)binViewModel{
    RAC(self, title) = RACObserve(self.viewModel, title);
    UIView *titleView = self.navigationItem.titleView;
    RAC(self.navigationItem, titleView) = [RACObserve(self.viewModel, titleView) map:^id(id value) {
        return titleView;
    }];
    @weakify(self)
    [RACObserve(self.viewModel, backImage) subscribeNext:^(UIImage *backImage) {
        @strongify(self)
        if (backImage) {
            [self.navigationController.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
        }
    }];

    [RACObserve(self.viewModel, titleView) subscribeNext:^(UIView *titleView) {
        @strongify(self)
        if (titleView) {
            self.navigationItem.titleView = titleView;
        }
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }];
//    RAC(self.navigationController.navigationBar, backIndicatorImage) = RACObserve(self.viewModel, backImage);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    NSLog(@"base dealloc");
    [[ECDeviceConnect shareBlueTool] deallocSignal];
}

@end
