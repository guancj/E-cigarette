//
//  ECFirstViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/17.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECFirstViewController.h"
#import "FirstLunViewMode.h"

@interface ECFirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bauwayBut, *fyhitBut, *ciggoBut, *vaporBut, *vapeBut;
@property (nonatomic, strong) FirstLunViewMode *viewModel;
@end

@implementation ECFirstViewController
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)binViewModel{
    [[self.bauwayBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        [self.viewModel.pushCommand execute:@(but.tag)];
    }];
    [[self.fyhitBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        [self.viewModel.pushCommand execute:@(but.tag)];
    }];
    [[self.ciggoBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        [self.viewModel.pushCommand execute:@(but.tag)];
    }];
    [[self.vaporBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        [self.viewModel.pushCommand execute:@(but.tag)];
    }];
    [[self.vapeBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *but) {
        [self.viewModel.pushCommand execute:@(but.tag)];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
