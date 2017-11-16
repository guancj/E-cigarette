//
//  SignViewModel.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/19.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewModel.h"

@interface SignViewModel : ECViewModel
@property (nonatomic, strong) NSString *account, *password, *passwordT;
@property (nonatomic, strong, readonly) RACSignal *accountSignal, *passwordSignal, *passwordSignalT, *signValidSignal;
;
@property (nonatomic, strong, readonly) RACCommand *signCommand;
@end
