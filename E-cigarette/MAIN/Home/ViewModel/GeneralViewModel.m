//
//  GeneralViewModel.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "GeneralViewModel.h"
#import "GeneralModel.h"

@interface GeneralViewModel ()
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation GeneralViewModel

//- (instancetype)initWithService:(id<UIViewModeService>)service params:(id)params{
//    self = [super initWithService:service params:params];
//    if (self) {
//        if (params) {
//            self.backImage = params[@"backImage"];
//        }
//    }
//    return self;
//}

- (void)initialize{
    self.dataList = @[@[ECLocalizedString(@"单循环时间", nil),ECLocalizedString(@"单循环时间", nil)]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GeneralList.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    self.dataList = @[[GeneralModel mj_objectArrayWithKeyValuesArray:array]];
    NSArray *genArr = @[[ECDefaultionfos ECgetValueforKey:workTime],[ECDefaultionfos ECgetValueforKey:Voltage] ? [ECDefaultionfos ECgetValueforKey:Voltage]:@"",[ECDefaultionfos ECgetValueforKey:Recharge] ? [ECDefaultionfos ECgetValueforKey:Recharge]:@(0),[ECDefaultionfos ECgetValueforKey:RechargeT] ? [ECDefaultionfos ECgetValueforKey:RechargeT]:@"",[ECDefaultionfos ECgetValueforKey:Temp],[ECDefaultionfos ECgetValueforKey:Puffs] ? [ECDefaultionfos ECgetValueforKey:Puffs]:@(0),@([ECDefaultionfos ECgetIntValueforKey:Shake])];
   __block int i = 0;
    [((NSArray *)[self.dataList firstObject]).rac_sequence.signal subscribeNext:^(id x) {
        if (i < genArr.count) {
            GeneralModel *model = (GeneralModel *)x;
            model.cenStr = [NSString stringWithFormat:@"%@",genArr[i] ? genArr[i]:@""];
            if (i == genArr.count - 1) {
                model.isOpen = genArr[i] ? genArr[i]:@(0);
            }
        }
        i ++;
    }];
    RAC(self, dataSource) = [[RACObserve(self, dataList) distinctUntilChanged] deliverOnMainThread];
}

@end
