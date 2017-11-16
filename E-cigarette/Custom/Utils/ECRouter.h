//
//  ECRouter.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECViewController.h"
#import "ECViewModel.h"

@interface ECRouter : NSObject
+ (instancetype)sharedInstance;

- (ECViewController *)viewControllerForViewMode:(ECViewModel *)viewModel;
@end
