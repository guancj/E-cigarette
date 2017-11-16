//
//  SelViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/23.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "SelViewModel.h"
#import "SearchViewModel.h"

@interface SelViewModel ()
@property (nonatomic, strong, readwrite) RACCommand *selCommand;
@end

@implementation SelViewModel


- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [super initWithService:service params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize{
    @weakify(self)
    self.selCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *butTag) {
        @strongify(self)
        SearchViewModel *searModel = [[SearchViewModel alloc] initWithService:self.service params:@{@"backImage":[UIImage new]}];
        [self.service pushViewModel:searModel animated:YES];
        return [RACSignal empty];
    }];
}
@end
