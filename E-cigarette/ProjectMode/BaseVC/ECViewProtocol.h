//
//  ECViewProtocol.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ECViewModelProtocol;

@protocol ECViewProtocol <NSObject>

@required

- (instancetype)initWithViewModel:(id<ECViewModelProtocol>)viewModel;

@property (nonatomic, strong, readonly) id<ECViewModelProtocol> viewModel;

@optional
- (void)binViewModel;
@end
