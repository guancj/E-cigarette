//
//  ECTableViewViewController.m
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECTableViewViewController.h"
#import "ECTableViewModel.h"

@interface ECTableViewViewController ()
@property (strong, nonatomic, readonly) ECTableViewModel *viewModel;
@end

@implementation ECTableViewViewController
@synthesize viewModel;

- (instancetype)initWithViewModel:(id<ECViewModelProtocol>)viewModel{
    self = [super initWithViewModel:viewModel];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)binViewModel{
    [super binViewModel];
    @weakify(self)
    [[[RACObserve(self.viewModel, dataSource) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setView:(UIView *)view{
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) {
        self.tableView = (UITableView *)view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeneReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    
}

#pragma mark -- delegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

//返回索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.viewModel.sectionIndexTitles.count != 0) {
        return [self.viewModel.sectionIndexTitles.rac_sequence startWith:UITableViewIndexSearch].array;
    }
    return self.viewModel.sectionIndexTitles;
}
//返回索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section >= self.viewModel.sectionIndexTitles.count) {
        return nil;
    }
    return  self.viewModel.sectionIndexTitles[section];
}
//点击某一组的索引文字时，返回期望跳转的组的下标
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return index - 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSArray*)self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView dequeneReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    //    id object = nil;
    [self configureCell:cell atIndexPath:indexPath withObject:object];
    return cell;
}


#pragma mark -- dealloc
- (void)dealloc{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}
@end
