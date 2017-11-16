//
//  ECLoginViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/17.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECLoginViewController.h"
#import "LoginViewModel.h"
#import "ResetViewModel.h"
#import "HomeViewModel.h"

@interface ECLoginViewController ()
@property (nonatomic, weak) IBOutlet UITextField *emailField, *passField;
@property (nonatomic, weak) IBOutlet UIButton *loginBut, *resignBut, *findPassBut;
@property (nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation ECLoginViewController
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
    [self createUI];
}

- (void)createUI{
    _emailField.placeholder = ECLocalizedString(@"请输入邮箱", nil);
    [_emailField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passField.placeholder = ECLocalizedString(@"请输入密码", nil);
    UIButton *eyesBut = [UIButton buttonWithType:UIButtonTypeCustom];
    eyesBut.frame = CGRectMake(0, 0, 40, 30);
    [eyesBut setImage:[UIImage imageNamed:@"icon_View"] forState:UIControlStateNormal];
    [eyesBut setImage:[UIImage imageNamed:@"icon_view_pre"] forState:UIControlStateSelected];
    @weakify(self)
    [[eyesBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            but.selected = !but.selected;
            self.passField.secureTextEntry = !but.selected;
        });
    }];
    
    _passField.rightView = eyesBut;
    _passField.rightViewMode = UITextFieldViewModeAlways;
    
    [_resignBut setTitle:ECLocalizedString(@"注册", nil) forState:UIControlStateNormal];
    [_loginBut setTitle:ECLocalizedString(@"登入", nil) forState:UIControlStateNormal];
    [_findPassBut setTitle:ECLocalizedString(@"忘记密码?", nil) forState:UIControlStateNormal];
    
    [_loginBut setBackgroundImage:[UIImage ECimageWithColor:ECUIColorFromRGB(0x59AAFD, 1) size:CGSizeMake(ECMainScreen.size.width, 44)] forState:UIControlStateNormal];
    [_loginBut setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    [_loginBut setBackgroundImage:[UIImage ECimageWithColor:ECUIColorFromRGB(0x59AAFD, 0.5) size:CGSizeMake(ECMainScreen.size.width, 44)] forState:UIControlStateDisabled];
    _loginBut.layer.cornerRadius = 6.0;
    _loginBut.layer.masksToBounds = YES;
    _resignBut.layer.borderWidth = 1.0;
    _resignBut.layer.borderColor = [ECMediumSkyBlueColor CGColor];
    
    RAC(viewModel, accountName) = self.emailField.rac_textSignal;
    RAC(viewModel, password) = self.passField.rac_textSignal;
    
    RAC(self.loginBut, enabled) = [viewModel.loginValidSignal map:^id(NSNumber *enabled) {
          return @([enabled boolValue]);
    }];
    
    [[self.loginBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [viewModel.loginCommand execute:nil];
        [viewModel.searchCommand execute: nil];
    }];
    
    
    [viewModel.loginCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        NSLog(@"executing %@",executing);
        [self.view endEditing:YES];
        if ([executing boolValue]) {
            [MBProgressHUD showMessage:@""];
        }
        else{
           
        }
    }];
    
    [viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"executionSignals  %@",x);
    }];
    
    [viewModel.searchCommand.executing subscribeNext:^(id x) {
        NSLog(@"searchCommand.executing %@",x);
    }];
    
    [viewModel.searchCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"searchCommand.executionSignals %@",x);
    }];
    
    
    [[_resignBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        SignViewModel *signViewModel = [[SignViewModel alloc] initWithService:self.viewModel.service params:@{@"backImage":[UIImage new]}];
//        LoginViewModel *mode = [[LoginViewModel alloc] initWithService:self.viewModel.service params:nil];
        [self.viewModel.service pushViewModel:signViewModel animated:YES];
    }];
    
    [[_findPassBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
        ResetViewModel *resetModel = [[ResetViewModel alloc] initWithService:viewModel.service params:@{@"backImage":[UIImage new]}];
        [viewModel.service pushViewModel:resetModel animated:YES];
    
    }];
    
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
