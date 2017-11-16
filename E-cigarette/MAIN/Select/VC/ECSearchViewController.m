//
//  ECSearchViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/23.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECSearchViewController.h"
#import "SearchViewModel.h"


@interface ECSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SearchViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *deviceTab;

@end

@implementation ECSearchViewController
@synthesize viewModel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewModel.backImage = [UIImage new];
}

- (void)binViewModel{
    [super binViewModel];
    [self createUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)createUI{
    [_tryBut setTitle:ECLocalizedString(@"重试", nil) forState:UIControlStateNormal];
    CGSize size = [ECStringVerify getSize:_tryBut.titleLabel.text strDic:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].size;
    [_tryBut mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width + 30);
    }];
    
    @weakify(self)
//    RAC(self.tryBut,backgroundColor) = [[viewModel.searchCommand.executing skip:1] map:^id(id value) {
//        NSLog(@"viewModel.searchCommand. %@",value);
//        return (![value boolValue]) ? ECMediumSkyBlueColor:[UIColor greenColor];
//    }];
    [self.viewModel.searchCommand execute:@(13)];
    [[self.tryBut rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.searchCommand execute:@(13)];
        
    }];
    
    [RACObserve([ECDeviceConnect shareBlueTool],peripherals) subscribeNext:^(NSMutableArray *periperals) {
        NSLog(@"periperals**** %@",periperals);
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.deviceTab reloadData];
        });
    }];
    
    RACDisposable *dispos =  [[ECDeviceConnect shareBlueTool].errorSubject subscribeNext:^(NSError *error) {
        NSLog(@"ceConnect shareBlueTool].errorSubject %@",error);
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            if (error.code == 1005) {
                [MBProgressHUD showSuccess:error.localizedDescription];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.viewModel.service popViewModelAnimated:YES];
                });
            }
        });
    }];
    NSLog(@"dispos %@",dispos);
    _deviceTab.delegate = self;
    _deviceTab.dataSource = self;
    _deviceTab.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ECDeviceConnect shareBlueTool].peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *deviceIdent = @"DEVICECELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deviceIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:deviceIdent];
    }
    cell.textLabel.text = [[ECDeviceConnect shareBlueTool].peripherals[indexPath.row] name];
    cell.detailTextLabel.text = [[[ECDeviceConnect shareBlueTool].peripherals[indexPath.row] peripheral] identifier].UUIDString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MBProgressHUD showMessage:@""];
    [ECDeviceConnect shareBlueTool].peripheral = [[ECDeviceConnect shareBlueTool].peripherals[indexPath.row] peripheral];
    [[ECDeviceConnect shareBlueTool].connectCommand execute:@(12)];
}

- (void)dealloc{
    NSLog(@"dealloc");
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
