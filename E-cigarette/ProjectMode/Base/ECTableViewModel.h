//
//  ECTableViewModel.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewModel.h"

@interface ECTableViewModel : ECViewModel
@property (strong, nonatomic) NSArray *dataSource;

@property (strong, nonatomic) NSArray *sectionIndexTitles;
@end
