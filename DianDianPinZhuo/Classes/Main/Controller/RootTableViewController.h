//
//  RootTableViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/22.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"
#import "HQHttpTool.h"
#import "RequestModel.h"
#import "MJRefresh.h"
#import "XBNullView.h"

@interface RootTableViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic ,strong) UITableView *tableView;
/** activity */
@property (nonatomic ,strong) UIActivityIndicatorView *activity;
/** 数组 */
@property (nonatomic ,strong) NSMutableArray *datyArray;
/** 分页 */
@property (nonatomic ,assign) int page;
/** 是否有MJRefresh */
@property (nonatomic ,assign) BOOL haveMJRefresh;
/** 空试图 */
@property(nonatomic,strong)XBNullView *nullView;
/** 加载空试图 */
- (void)reloadDataNULL:(NSString *)placehold imageName:(NSString *)imageStr;
/** 下拉刷新 */
- (void)MJRefreshTop;
/** 加载更多 */
- (void)MJRefreshMore;

-(void)setupDownRefresh;

@end
