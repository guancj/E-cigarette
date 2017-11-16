//
//  FirstLunViewMode.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/17.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "FirstLunViewMode.h"

@interface FirstLunViewMode ()
@property (strong, nonatomic, readwrite) RACCommand *pushCommand;
@end

@implementation FirstLunViewMode

- (void)initialize{
    if (!self.pushCommand) {
        self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *tag) {
            NSLog(@"tag %@",tag);
            return [RACSignal empty];
        }];
    }
}

- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [super initWithService:service params:params];
    if (self) {
        if (params) {
            self.title = params[@"title"];
            self.backImage = params[@"backImage"];
        }
    }
    return self;
}
@end
