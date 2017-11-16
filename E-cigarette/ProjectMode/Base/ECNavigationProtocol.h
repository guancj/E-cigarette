//
//  ECNavigationProtocol.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//
#ifndef ECNavigationProtocol_h
#define ECNavigationProtocol_h

#import <Foundation/Foundation.h>

typedef void(^VoidBlock)(void);

@protocol ECViewModelProtocol;

@protocol ECNavigationProtocol <NSObject>

- (void)pushViewModel:(id<ECViewModelProtocol>)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(id<ECViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

- (void)resetRootViewModel:(id<ECViewModelProtocol>)viewModel;


@end

#endif /* ECNavigationProtocol_h */
