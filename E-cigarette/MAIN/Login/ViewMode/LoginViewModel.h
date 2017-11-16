//
//  LoginViewModel.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/18.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewModel.h"

@interface LoginViewModel : ECViewModel
@property (nonatomic, strong) NSString *accountName, *password;
@property (nonatomic, strong, readonly) RACSignal *accountValidSignal, *passwordSignal, *loginValidSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand, *resignCommand;
@property (nonatomic, strong, readonly) RACCommand *searchCommand;
@end
