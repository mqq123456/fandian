//
//  RootGroupTableViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/22.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"

@interface RootGroupTableViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) UIActivityIndicatorView *activity;

@end
