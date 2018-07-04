//
//  FDGrowingViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDGrowingViewController.h"
#import "FDGrowingCell.h"
#import "GrowUpDetailModel.h"

#import "HttpUserGrowupPoint.h"
@interface FDGrowingViewController ()

@end

@implementation FDGrowingViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"pv_growthvalue"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[FDUtils addNavBarView]];
    
    self.tableView.backgroundColor = Background_Color;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addTitleViewWithTitle:@"成长值"];
    
    self.page = 1;
    
    self.haveMJRefresh = YES;
    
    FDGrowingHeadView *tableViewHeader = [[[NSBundle mainBundle] loadNibNamed:@"FDGrowingHeadView" owner:nil options:nil]lastObject];
    
    tableViewHeader.height = 417*ScreenW/750;
    if (IPhone6Plus || IPhone6) {
        tableViewHeader.growing_num.font = [UIFont systemFontOfSize:30];
        tableViewHeader.growing_hint.font = [UIFont systemFontOfSize:21];
        tableViewHeader.numY.constant = -22;
    }else{
        
        tableViewHeader.growing_num.font = [UIFont systemFontOfSize:27];
        tableViewHeader.growing_hint.font = [UIFont systemFontOfSize:20];
        tableViewHeader.numY.constant = -18;
    }
    
    self.tableView.tableHeaderView = tableViewHeader;
    self.tableViewHeader = tableViewHeader;
    
    [self loadGrowingPointFirst];
    
    self.tableView.footer.hidden = YES;
    
}

- (void)MJRefreshTop{
    
    HttpUserGrowupPoint *tool = [HttpUserGrowupPoint sharedInstance];
    [tool MJRefreshTopPage:1 controller:self];
}
- (void)MJRefreshMore{
    HttpUserGrowupPoint *tool = [HttpUserGrowupPoint sharedInstance];
    [tool MJRefreshMorePage:1 controller:self];
}

#pragma  mark - 第一次进入加载数据
- (void)loadGrowingPointFirst{
    HttpUserGrowupPoint *tool = [HttpUserGrowupPoint sharedInstance];
    [tool loadFristPage:1 controller:self];
}
#pragma mark - UITableViewDelegate Datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDGrowingCell *cell = [FDGrowingCell cellWithTableView:tableView];
    GrowUpDetailModel *model = self.datyArray[indexPath.row];
    
    cell.merchant.text = model.merchant_name;
    cell.detail.text = model.content;
    cell.time.text = model.order_date;
    cell.growingNum.text = [NSString stringWithFormat:@"+%@", model.income];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datyArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headerView.backgroundColor = Background_Color;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 9, ScreenW, 40)];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    UIButton *historyBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    [historyBtn setTitle:@"成长值明细" forState:UIControlStateNormal];
    [historyBtn setTitleColor:FDColor(51, 51, 51, 1) forState:UIControlStateNormal];
    historyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [headerView addSubview:whiteView];
    [whiteView addSubview:historyBtn];
    headerView.backgroundColor = Background_Color;
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
