//
//  ECNavViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/16.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECNavViewController.h"

@interface ECNavViewController ()

@end

@implementation ECNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGRect rectNav = self.navigationBar.frame;
    [ECDefaultionfos ECputKey:NavHeight andValue:@(rectNav.size.height)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage ECimageWithColor:ECMediumSkyBlueColor size:CGSizeMake(ECMainScreen.size.width, rectNav.size.height)] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [ECStringVerify createTitleViewView];
    
    [[self.navigationItem rac_valuesAndChangesForKeyPath:@"leftBarButtonItem" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"backBarButtonItem**  %@",x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
