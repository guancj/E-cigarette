//
//  SearchViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/23.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "SearchViewModel.h"

@interface SearchViewModel ()
@property (nonatomic, strong, readwrite) RACCommand *searchCommand;
@end

@implementation SearchViewModel
- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
    self = [super initWithService:service params:params];
    if (self) {
        if (params) {
             self.backImage = params[@"backImage"];
        }
    }
    return self;
}

- (void)initialize{
//    _searchDeviceModel = [ECDeviceConnect shareBlueTool];
    self.searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *butTag) {
        [[[ECDeviceConnect shareBlueTool] serchCommand] execute:butTag];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{

            }];
        }];
    }];
    [ECDefaultionfos ECremoveValueForKey:DeviceUUID];
    [ECDeviceConnect shareBlueTool].peripheral = nil;
    [[ECDeviceConnect shareBlueTool].connectCommand execute:@(0)];
    [ECDeviceConnect shareBlueTool].searchNames = @[@"BLE to UART_2",@"B2",@"SM07"];

}

- (RACSignal *)searchDevice{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
}
@end
