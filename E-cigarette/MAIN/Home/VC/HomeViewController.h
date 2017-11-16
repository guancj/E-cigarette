//
//  HomeViewController.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/20.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewController.h"

@interface HomeViewController : ECViewController
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UIButton *selBut, *generalBut, *setBut, *appraiseBut, *remindBut, *remarkBut, *asBut, *logoutBut;
@end
