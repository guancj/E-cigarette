//
//  ECGeneralViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECGeneralViewController.h"
#import "GeneralViewModel.h"
#import "ECGeneralCell.h"

@interface ECGeneralViewController ()
@property (nonatomic, strong) GeneralViewModel *viewModel;
@end

@implementation ECGeneralViewController
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
    [super binViewModel];
    [self createUI];
}

- (void)createUI{
    self.navigationItem.titleView = [ECStringVerify createTitleViewView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ECGeneralCell" bundle:nil] forCellReuseIdentifier:@"DETAILCELL"];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeneReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    ECGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DETAILCELL"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ECMainScreen.size.width, 44)];
    return view;
}

// 配置cell中的显示内容
- (void)configureCell:(ECGeneralCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
//    NSLog(@"fjeiowijoig %@",object);
    [cell cellReloadData:object];
    
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
