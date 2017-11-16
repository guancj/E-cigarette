//
//  ECViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewModel.h"

@interface ECViewModel ()

@property (strong, nonatomic, readwrite) id<UIViewModeService> service;
@property (strong, nonatomic, readwrite) id params;
@end

@implementation ECViewModel
@synthesize service = _service;
@synthesize params = _params;
@synthesize title = _title;
@synthesize titleView = _titleView;
@synthesize errors = _errors;
@synthesize backImage = _backImage;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ECViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel rac_signalForSelector:@selector(initWithService:params:)] subscribeNext:^(id x) {
        @strongify(viewModel)
        [viewModel initialize];
    }];
    return viewModel;
}

- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [self init];
    if (self) {
        self.service = service;
        self.params = params;
    }
    return self;
}

- (void)initialize{
    
}
@end
