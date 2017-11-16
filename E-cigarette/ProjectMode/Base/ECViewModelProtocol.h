//
//  ECViewModelProtocol.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//
#ifndef ECViewModelProtocol_h
#define ECViewModelProtocol_h

#import <Foundation/Foundation.h>
#import "UIViewModeService.h"
#import "ReactiveCocoa.h"

@protocol ECViewModelProtocol <NSObject>

- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params;

@property (strong, nonatomic, readonly) id<UIViewModeService> service;

@property (strong, nonatomic, readonly) id params;

@optional

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UIImage *backImage;

@property (strong, nonatomic, readonly) RACSubject *errors;

- (void)initialize;

@end

#endif
