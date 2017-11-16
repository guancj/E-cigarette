//
//  ECSignViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECSignViewController.h"
#import "SignViewModel.h"

@interface ECSignViewController ()
@property (nonatomic, strong) SignViewModel *viewModel;
@end

@implementation ECSignViewController
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)binViewModel{
    [super binViewModel];
    
    UIButton *eyesBut = [UIButton buttonWithType:UIButtonTypeCustom];
    eyesBut.frame = CGRectMake(0, 0, 40, 30);
    [eyesBut setImage:[UIImage imageNamed:@"icon_View"] forState:UIControlStateNormal];
    [eyesBut setImage:[UIImage imageNamed:@"icon_view_pre"] forState:UIControlStateSelected];
    UIButton *eyesBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
    eyesBut1.frame = CGRectMake(0, 0, 40, 30);
    [eyesBut1 setImage:[UIImage imageNamed:@"icon_View"] forState:UIControlStateNormal];
    [eyesBut1 setImage:[UIImage imageNamed:@"icon_view_pre"] forState:UIControlStateSelected];
    _passField.rightView = eyesBut;
    _passField.rightViewMode = UITextFieldViewModeAlways;
    _passFieldT.rightView = eyesBut1;
    _passFieldT.rightViewMode = UITextFieldViewModeAlways;
    
    _accountField.placeholder = ECLocalizedString(@"请输入邮箱", nil);
    _passField.placeholder = ECLocalizedString(@"请输入密码", nil);
    _passFieldT.placeholder = ECLocalizedString(@"请再次输入密码", nil);
    [ _accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ _passField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ _passFieldT setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_signBut setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    [_signBut setBackgroundImage:[UIImage ECimageWithColor:ECUIColorFromRGB(0x59AAFD, 1) size:CGSizeMake(ECMainScreen.size.width, 44)] forState:UIControlStateNormal];
    [_signBut setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    _signBut.layer.cornerRadius = 6.0;
    _signBut.layer.masksToBounds = YES;
    @weakify(self)
    [[eyesBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            but.selected = !but.selected;
            self.passField.secureTextEntry = !but.selected;
        });
    }];
    

    [[eyesBut1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            but.selected = !but.selected;
            self.passFieldT.secureTextEntry = !but.selected;
        });
    }];
    
    RAC(viewModel, account) = self.accountField.rac_textSignal;
    RAC(viewModel, password) = self.passField.rac_textSignal;
    RAC(viewModel, passwordT) = self.passFieldT.rac_textSignal;
    
    RAC(self.signBut, enabled) = [viewModel.signValidSignal map:^id(NSNumber *enabled) {
        return @([enabled boolValue]);
    }];
    
    [viewModel.signCommand.executing subscribeNext:^(NSNumber *executing) {
        if ([executing boolValue]) {
            [MBProgressHUD showMessage:@""];
        }
        else{
//            [MBProgressHUD hideHUD];
        }
    }];
    
    [[self.signBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self)
        [self.viewModel.signCommand execute:nil];
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
