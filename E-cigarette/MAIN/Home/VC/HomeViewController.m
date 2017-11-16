//
//  HomeViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/20.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "ECCommunication.h"

@interface HomeViewController ()
@property (nonatomic, strong) HomeViewModel *viewModel;
@end

@implementation HomeViewController
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
    _versionLab.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [_selBut setTitle:ECLocalizedString(@"产品选择", nil) forState:UIControlStateNormal];
    [_generalBut setTitle:ECLocalizedString(@"通用指数", nil) forState:UIControlStateNormal];
    [_setBut setTitle:ECLocalizedString(@"设定", nil) forState:UIControlStateNormal];
    [_appraiseBut setTitle:ECLocalizedString(@"评价", nil) forState:UIControlStateNormal];
    [_remindBut setTitle:ECLocalizedString(@"提醒", nil) forState:UIControlStateNormal];
    [_remarkBut setTitle:ECLocalizedString(@"备注", nil) forState:UIControlStateNormal];
    [_asBut setTitle:ECLocalizedString(@"关注我们", nil) forState:UIControlStateNormal];
    [_logoutBut setTitle:ECLocalizedString(@"注销登录", nil) forState:UIControlStateNormal];
    [viewModel.homeCommands.executing subscribeNext:^(id x) {
        NSLog(@"executing %@",x);
    }];
    
}
- (IBAction)tapButSign:(UIButton *)sender {
     [[ECCommunication shareCommunication] sendUtfData:[@"35" dataUsingEncoding:NSUTF8StringEncoding] commandState:COMMAND_TEMP_UP];
    if (sender.tag == 108) {
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:ECLocalizedString(@"是否确认退出登录", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:ECLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        [aler addAction:cancelAct];
        UIAlertAction *confimAct = [UIAlertAction  actionWithTitle:ECLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [viewModel.homeCommands execute:@(sender.tag)];
        }];
        [aler addAction:confimAct];
        [self presentViewController:aler animated:YES completion:nil];
    }
    else{
         [viewModel.homeCommands execute:@(sender.tag)];
    }
}


@end
