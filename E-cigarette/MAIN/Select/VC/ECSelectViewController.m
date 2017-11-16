//
//  ECSelectViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/23.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECSelectViewController.h"
#import "SelViewModel.h"

@interface ECSelectViewController ()
@property (nonatomic, strong) SelViewModel *viewModel;
@end

@implementation ECSelectViewController
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)binViewModel{
    [super binViewModel];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewModel.backImage = [UIImage ECimageWithColor:ECMediumSkyBlueColor size:CGSizeMake(ECMainScreen.size.width, 44)];
}

- (void)createUI{
    self.navigationItem.titleView = [ECStringVerify createTitleViewView];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)view;
            but.titleLabel.numberOfLines = 2;
            but.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
}

- (IBAction)tapSelectState:(UIButton *)sender {
    [self.viewModel.selCommand execute:@(sender.tag)];
}

@end
