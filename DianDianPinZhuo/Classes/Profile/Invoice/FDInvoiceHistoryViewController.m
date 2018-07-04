//
//  FDInvoiceHistoryViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInvoiceHistoryViewController.h"
#import "HttpInvoiceHistory.h"
#import "FDInvoiceHistoryCell.h"
#import "InvoicesModel.h"

@interface FDInvoiceHistoryViewController ()

@end

@implementation FDInvoiceHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.haveMJRefresh = YES;
    [self addTitleViewWithTitle:@"开票历史"];
    self.tableView.backgroundColor = Background_Color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 15)];
    
    headerView.backgroundColor = Background_Color;
    
    self.tableView.tableHeaderView = headerView;
    
    [self loadInvoiceDataFrist];

    self.tableView.footer.hidden = YES;
    
}

- (void)MJRefreshTop{
    HttpInvoiceHistory *history = [HttpInvoiceHistory sharedInstance];
    [history MJRefreshTopController:self];
}
- (void)MJRefreshMore{
    HttpInvoiceHistory *history = [HttpInvoiceHistory sharedInstance];
    [history MJRefreshMoreController:self];
}
#pragma  mark - 第一次加载数据
- (void)loadInvoiceDataFrist{
    HttpInvoiceHistory *history = [HttpInvoiceHistory sharedInstance];
    [history loadFristController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDInvoiceHistoryCell *cell = [FDInvoiceHistoryCell cellWithTableView:tableView];
    InvoicesModel *model = self.datyArray[indexPath.row];
    cell.timeLabel.text = model.create_time;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元",model.amount];
    if ([model.state intValue]==0) {
        cell.stateLabel.text = @"待开票";
    }else{
        cell.stateLabel.text = @"已开票";
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;

}


@end
