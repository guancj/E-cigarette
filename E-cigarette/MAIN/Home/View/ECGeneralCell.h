//
//  ECGeneralCell.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralModel.h"

@interface ECGeneralCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *headLab, *leftLab, *cenLab, *rightLab, *accLab;
@property (nonatomic, weak) IBOutlet UISwitch *vibrationSwit;
@property (nonatomic, weak) IBOutlet UIView *leftView, *rightView, *cenView;
- (void)cellReloadData:(GeneralModel *)object;
@end
