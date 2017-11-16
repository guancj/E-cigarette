//
//  ECTableViewViewController.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/27.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import "ECViewController.h"

@interface ECTableViewViewController : ECViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeneReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
