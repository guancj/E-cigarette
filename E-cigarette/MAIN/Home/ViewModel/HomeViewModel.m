//
//  HomeViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/20.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "HomeViewModel.h"
#import "LoginViewModel.h"
#import "SelViewModel.h"
#import "GeneralViewModel.h"

@interface HomeViewModel ()
@property (nonatomic, strong, readwrite) RACCommand *homeCommands;
@end

@implementation HomeViewModel
- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [super initWithService:service params:params];
    if (self) {
        if (params) {
            self.titleView = params[@"titleView"];
            self.backImage = params[@"backImage"];
        }
    }
    return self;
}

- (void)initialize{
    @weakify(self)
    self.homeCommands = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *butTag) {
        NSLog(@"ffjeiwo %@",butTag);
        @strongify(self)
        switch ([butTag integerValue]) {
            case 101:{
                SelViewModel *selModel = [[SelViewModel alloc] initWithService:self.service params:nil];
                [self.service pushViewModel:selModel animated:YES];
            }
                break;
            case 102:{
                GeneralViewModel *generalModel = [[GeneralViewModel alloc] initWithService:self.service params:nil];
                [self.service pushViewModel:generalModel animated:YES];
            }
                break;
            case 103:
                
                break;
            case 104:
                
                break;
            case 105:
                
                break;
            case 106:
                
                break;
            case 107:
                
                break;
            case 108:{
                [BmobUser logout];
                ECUser *user = [[ECUser alloc] init];
                [[ECStoredInfo shareStored] saveUser:user];
                NSDictionary *dic = @{@"backImage":[UIImage new]};
                LoginViewModel *loginMode = [[LoginViewModel alloc] initWithService:self.service params:dic];
                [self.service resetRootViewModel:loginMode];
            }
                break;
            default:
                break;
        }
        return [RACSignal empty];
    }];
}
@end
