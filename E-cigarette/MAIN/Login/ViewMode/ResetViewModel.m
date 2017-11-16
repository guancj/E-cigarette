//
//  ResetViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/20.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ResetViewModel.h"

@interface ResetViewModel ()
@property (nonatomic, strong, readwrite) RACSignal *accountSignal;
@property (nonatomic, strong, readwrite) RACCommand *resetCommand;
@end

@implementation ResetViewModel
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
        return @(![account isEqualToString:@""] && [ECStringVerify isValidateEmail:account]);
    }];
    @weakify(self)
    self.resetCommand = [[RACCommand alloc] initWithEnabled:self.accountSignal signalBlock:^RACSignal *(id input) {
        @strongify(self)
        NSLog(@"input %@",input);
        return [self resetingAccount:self.account];
    }];
    
    [self.resetCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"success"]) {
            [MBProgressHUD hideHUD];
            [self.service popViewModelAnimated:YES];
        }
        else{
            [MBProgressHUD showError:result ? result: ECLocalizedString(@"重置失败", nil)];
        }
    }];
}

- (RACSignal *)resetingAccount:(NSString *)acc{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [BmobUser requestPasswordResetInBackgroundWithEmail:acc block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [subscriber sendNext:@"success"];
            }
            else{
                [subscriber sendNext:error.localizedDescription];
            }
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
