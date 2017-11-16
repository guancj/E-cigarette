//
//  ECGeneralCell.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECGeneralCell.h"

@implementation ECGeneralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self)
    [RACObserve(self.vibrationSwit, hidden) subscribeNext:^(id x) {
        @strongify(self)
        self.cenLab.hidden = ![x boolValue];
    }];
    
    [RACObserve(self.cenView, hidden) subscribeNext:^(id x) {
        @strongify(self)
        self.leftView.hidden = ![x boolValue];
         self.rightView.hidden = ![x boolValue];
    }];
}

- (void)cellReloadData:(GeneralModel *)object{
    self.headLab.text = object.headStr;
    self.leftLab.text = object.leftStr;
    self.cenLab.text = object.cenStr;
    self.rightLab.text = object.rightStr;
    self.accLab.text = object.footStr;
    self.vibrationSwit.on = object.isOpen.boolValue;
    if (!object.footStr || [object.footStr isEqualToString:@""]) {
        self.cenView.hidden = YES;
    }else{
        self.cenView.hidden = NO;
    }
    if ([[object isOpen] intValue] < 0) {
        self.vibrationSwit.hidden = YES;
    }else{
        self.vibrationSwit.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
