//
//  LoginViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "LoginViewModel.h"
#import "HomeViewModel.h"

@interface LoginViewModel ()
@property (nonatomic, strong, readwrite) RACSignal *accountValidSignal, *passwordSignal, *loginValidSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand, *resignCommand;
@property (nonatomic, strong, readwrite) RACCommand *searchCommand;
@end

@implementation LoginViewModel

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
    if (!self.accountValidSignal) {
        self.accountValidSignal = [RACObserve(self, accountName) map:^id(NSString *accountName) {
            if ([accountName isEqualToString:@""]) {
                return @0;
            }
            else{
                return @([ECStringVerify isValidateEmail:accountName]);
            }
        }];
    }
    if (!self.passwordSignal) {
        self.passwordSignal = [RACObserve(self, password) map:^id(NSString *password) {
            return @(password.length > 0);
        }];
    }
    
    if (!self.loginValidSignal) {
        self.loginValidSignal = [RACSignal combineLatest:@[self.accountValidSignal, self.passwordSignal] reduce:^id(NSNumber *loginnameValid, NSNumber *passwordValid){
            return @([loginnameValid boolValue] && [passwordValid boolValue]);
        }];
    }
    
    @weakify(self)
    self.loginCommand = [[RACCommand alloc] initWithEnabled:self.loginValidSignal signalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self loginWithAccount:self.accountName pssword:self.password];
    }];
    
//    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *signal) {
//         NSLog(@"fwefewf= %@",signal);
//        [[signal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//             NSLog(@"rac_willDeallocSignal= %@",x);
//        }];
//    }];
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        @strongify(self)
        if (![result isEqualToString:@"success"]) {
            [MBProgressHUD showError:result? result:ECLocalizedString(@"登录失败", nil)];
        }
        else{
            [MBProgressHUD hideHUD];
            HomeViewModel *homeModel = [[HomeViewModel alloc] initWithService:self.service params:@{@"titleView":[ECStringVerify createTitleViewView],@"backImage":[UIImage new]}];
            [self.service resetRootViewModel:homeModel];
        }
    }];
    
    [self setcommand];
//    [self.loginCommand.errors subscribeNext:^(id x) {
//        NSLog(@"fwe  %@",x);
//    }];
}

- (void)setcommand {
    //1创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //命令内部传递的参数
        NSLog(@"input===%@",input);
        //2.返回一个信号,可以返回一个空信号 [RACSignal empty];
        return [RACSignal createSignal:^RACDisposable *(id subscriber) {
            NSLog(@"发送数据");
            //发送信号
            [subscriber sendNext:@"22"];
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            return nil;
            
        }];
    }];
    //强引用
    _searchCommand = command;
    //拿到返回信号方式二:
    //command.executionSignals信号中的信号 switchToLatest转化为信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@拿到信号的方式二%@",command.executionSignals.switchToLatest,x);
    }];
    //拿到返回信号方式一:
    RACSignal *signal =  [command execute:@"11"];
    [signal subscribeNext:^(id x) {
        NSLog(@"拿到信号的方式一%@",x);
        
    }];
    //3.执行命令
    [command execute:@"11"];
    //监听命令是否执行完毕
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"命令正在执行");
        }
        else {
            NSLog(@"命令完成/没有执行");
        }
    }];
}

- (RACSignal *)loginWithAccount:(NSString *)account pssword:(NSString *)pass{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [BmobUser loginInbackgroundWithAccount:account andPassword:pass block:^(BmobUser *user, NSError *error) {
            if (!error) {
                ECUser *myUser = [[ECUser alloc] init];
                myUser.userAcc = account;
                myUser.userPs = pass;
                [[ECStoredInfo shareStored] saveUser:myUser];
                [subscriber sendNext:@"success"];
            }
            else{
                [subscriber sendNext:error.localizedDescription];
            }
//            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}


@end
