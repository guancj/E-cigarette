//
//  SignViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "SignViewModel.h"
#import "HomeViewModel.h"

@interface SignViewModel ()
@property (nonatomic, strong, readwrite) RACSignal *accountSignal, *passwordSignal, *passwordSignalT, *signValidSignal;
@property (nonatomic, strong, readwrite) RACCommand *signCommand;
@end

@implementation SignViewModel
- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [super initWithService:service params:params];
    if (self) {
        if (params) {
            self.backImage = params[@"backImage"];
        }
    }
    return self;
}

- (void)initialize{
    self.accountSignal = [RACObserve(self, account) map:^id(NSString *account) {
        if ([account isEqualToString:@""]) {
            return @(0);
        }
        else{
            return @([ECStringVerify isValidateEmail:account]);
        }
    }];
    self.passwordSignal = [RACObserve(self, passwordT) map:^id(NSString *pass) {
        return @(pass.length > 0);
    }];
    self.passwordSignalT = [RACObserve(self, passwordT) map:^id(NSString *pass) {
        return @(pass.length > 0);
    }];
    
    self.signValidSignal = [RACSignal combineLatest:@[self.accountSignal,self.passwordSignal,self.passwordSignalT] reduce:^id(NSNumber *loginnameValid, NSNumber *passwordValid, NSNumber *passwordValidT){
        return @([loginnameValid boolValue] && [passwordValid boolValue] && [passwordValidT boolValue]);
    }];
    @weakify(self)
    if (!self.signCommand) {
        self.signCommand = [[RACCommand alloc] initWithEnabled:self.signValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self signAccount];
        }];
    }
    [self.signCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"success"]) {
            [MBProgressHUD hideHUD];
            HomeViewModel *homeModel = [[HomeViewModel alloc] initWithService:self.service params:@{@"titleView":[ECStringVerify createTitleViewView],@"backImage":[UIImage new]}];
            [self.service resetRootViewModel:homeModel];
        }
        else if ([result isEqualToString:@"passFail"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:ECLocalizedString(@"新密码不一致，请重新输入", nil)];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:result? result:ECLocalizedString(@"注册失败", nil)];
            });
        }
    }];
//    [[self.signCommand.executing skip:1] subscribeNext:^(id x) {
//        NSLog(@"fefe %@",x);
//    }];
}

- (RACSignal *)signAccount{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
          @strongify(self)
        if (![self.password isEqualToString:self.passwordT]) {
            [subscriber sendNext:@"passFail"];
             [subscriber sendCompleted];
        }
        else{
            BmobUser *user = [[BmobUser alloc] init];
            user.username = self.account;
            user.email = self.account;
            user.password = self.password;
            [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    ECUser *myUser = [[ECUser alloc] init];
                    myUser.userAcc = self.account;
                    myUser.userPs = self.password;
                    [[ECStoredInfo shareStored] saveUser:myUser];
                    [subscriber sendNext:@"success"];
                }
                else{
                    [subscriber sendNext:error.localizedDescription];
                }
                [subscriber sendCompleted];
            }];
        }
        return nil;
    }];
}
@end
