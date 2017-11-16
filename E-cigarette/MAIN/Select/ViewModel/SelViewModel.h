//
//  SelViewModel.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/23.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewModel.h"

@interface SelViewModel : ECViewModel
@property (nonatomic, strong, readonly) RACCommand *selCommand;

@end
