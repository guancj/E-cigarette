//
//  ResetViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/20.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ResetViewController.h"
#import "ResetViewModel.h"

@interface ResetViewController ()
@property (nonatomic, strong) ResetViewModel *viewModel;
@end

@implementation ResetViewController
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
    
    [[self.navigationItem rac_valuesAndChangesForKeyPath:@"backBarButtonItem" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"backBarButtonItem**  %@",x);
    }];
    
    UIBarButtonItem *barButtonName = [[UIBarButtonItem alloc] initWithTitle:@"12" style:UIBarButtonItemStylePlain target:self action:NULL];
    [barButtonName setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:37.f], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [barButtonName setTintColor:[UIColor whiteColor]];
//    self.navigationItem.backBarButtonItem = barButtonName;
    NSLog(@"fwef  =%@  ** %@",self.navigationItem.leftBarButtonItem,self.navigationItem.backBarButtonItem);
    
//    [[self.accountField rac_valuesAndChangesForKeyPath:@"placeholder" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
//        NSLog(@"backBarButtonItem**  %@",x);
//    }];
    
    _accountField.placeholder = ECLocalizedString(@"请输入邮箱", nil);
     [ _accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_resetBut setBackgroundImage:[UIImage ECimageWithColor:ECUIColorFromRGB(0x59AAFD, 1) size:CGSizeMake(ECMainScreen.size.width, 44)] forState:UIControlStateNormal];
     [_resetBut setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    [_resetBut setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    _resetBut.layer.cornerRadius = 6.0;
    _resetBut.layer.masksToBounds = YES;
    RAC(viewModel, account) = self.accountField.rac_textSignal;
    RAC(self.resetBut, enabled) = [self.viewModel.accountSignal map:^id(NSNumber *enable) {
        return @([enable boolValue]);
    }];
    
    @weakify(self)
    [[self.resetBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.resetCommand execute:nil];
    }];
    
    [[self.viewModel.resetCommand.executing skip:1] subscribeNext:^(NSNumber *excuting) {
        @strongify(self)
        if ([excuting boolValue]) {
            [self.view endEditing:YES];
            [MBProgressHUD showMessage:@""];
        }
    }];

}

- (void)dealloc{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
