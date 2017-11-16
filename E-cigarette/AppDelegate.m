//
//  AppDelegate.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/14.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewModelServiceImpl.h"
#import "ECFirstViewController.h"
#import "FirstLunViewMode.h"
#import "ECNavigationControllerStack.h"
#import "ECLoginViewController.h"
#import "LoginViewModel.h"
#import "HomeViewModel.h"
#import "HomeViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIViewModelServiceImpl *service;
@property (nonatomic, strong) id<ECViewModelProtocol> viewModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bmob registerWithAppKey:@"205b9c5c2836c849625dab18dc4316b6"];
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    //    [bquery whereKeyExists:@"username"];
    [bquery whereKey:@"username" equalTo:@"zhoutw@163.com0"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"array %@, error %@",array,error);
        
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.service = [UIViewModelServiceImpl new];
    self.navigationControllerStack = [[ECNavigationControllerStack alloc] initWithService:self.service];
    UIViewController *viewController = [self createRootViewContrller];
    ECNavViewController *navigationController = [[ECNavViewController alloc] initWithRootViewController:viewController];
    [self.navigationControllerStack
     pushNavigationController:navigationController];
    self.window.rootViewController = navigationController;
    [[ECDeviceConnect shareBlueTool].reunitonCommand execute:@(10)];
    if (![ECDefaultionfos ECgetValueforKey:FirstLun]) {
        [ECDefaultionfos ECputKey:FirstLun andValue:FirstLun];
        [ECDefaultionfos ECputKey:Puffs andValue:@(300)];
        [ECDefaultionfos ECputKey:cyclePuffs andValue:@(15)];
        [ECDefaultionfos ECputKey:workTime andValue:@(5)];
        [ECDefaultionfos ECputKey:Temp andValue:@(225)];
    }
    return YES;
}

- (UIViewController *)createRootViewContrller{

    if ([[ECStoredInfo shareStored] user].userAcc && ![[[ECStoredInfo shareStored] user].userAcc isEqualToString:@""]) {
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ECMainScreen.size.width, 44)];
        navView.backgroundColor = ECMediumSkyBlueColor;
        UILabel *lab = [[UILabel alloc] init];
        [navView addSubview:lab];
        lab.text = @"&";
        lab.textColor = [UIColor whiteColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(navView);
        }];
        self.viewModel = [[HomeViewModel alloc] initWithService:self.service params:@{@"titleView":[ECStringVerify createTitleViewView],@"backImage":[UIImage ECimageWithColor:ECMediumSkyBlueColor size:CGSizeMake(ECMainScreen.size.width, 44)]}];
        return [[HomeViewController alloc] initWithViewModel:self.viewModel];
    }else{
        NSDictionary *dic = @{@"backImage":[UIImage new]};
        self.viewModel = [[LoginViewModel alloc] initWithService:self.service params:dic];
        return [[ECLoginViewController alloc] initWithViewModel:self.viewModel];
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
