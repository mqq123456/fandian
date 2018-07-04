//
//  FDIntegralViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDIntegralViewController.h"
#import "FDScoreCell.h"
#import "FDOccupationCell.h"
#import "HttpUserIntegralPoint.h"
#import "DetailsIncome.h"
#import "DetailsDefray.h"
#import "FDUtils.h"
@interface FDIntegralViewController()

{
    NSInteger incomeOrOutCome;
    UIButton *inBtn;
    UIButton *outBtn;
    UIImageView *leftArrowImage;
    UIImageView *rightArrowImage;
    BOOL leftImabgHide;
    BOOL rightImabgHide;

}
@end

@implementation FDIntegralViewController
- (void)viewDidLoad {
    leftImabgHide = NO;
    rightImabgHide = YES;
    [super viewDidLoad];
    incomeOrOutCome = 1;
    [self.view addSubview:[FDUtils addNavBarView]];
    self.tableView.backgroundColor = Background_Color;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addTitleViewWithTitle:@"积分"];
    
    self.page = 1;
    
    self.haveMJRefresh = YES;
    
    FDGrowingHeadView *tableViewHeader = [[[NSBundle mainBundle] loadNibNamed:@"FDGrowingHeadView" owner:nil options:nil]lastObject];
    
    tableViewHeader.height = 417*ScreenW/750;
    tableViewHeader.bgImage.image = [UIImage imageNamed:@"top_img_xyjf"];
    if (IPhone6Plus || IPhone6) {
        tableViewHeader.growing_num.font = [UIFont systemFontOfSize:30];
        tableViewHeader.growing_hint.font = [UIFont systemFontOfSize:21];
        tableViewHeader.numY.constant = -22;
    }else{
        
        tableViewHeader.growing_num.font = [UIFont systemFontOfSize:27];
        tableViewHeader.growing_hint.font = [UIFont systemFontOfSize:20];
        tableViewHeader.numY.constant = -18;
    }
    tableViewHeader.growing_hint.text = @"";
    self.tableView.tableHeaderView = tableViewHeader;
    self.tableViewHeader = tableViewHeader;
    
    [self loadGrowingPointFirst];
    
    self.tableView.footer.hidden = YES;
    
}

- (void)loadFristPage{
    
    HttpUserIntegralPoint *tool = [HttpUserIntegralPoint sharedInstance];
    [tool loadFristPage:1 controller:self income:incomeOrOutCome];
}
- (void)MJRefreshTop{
    HttpUserIntegralPoint *tool = [HttpUserIntegralPoint sharedInstance];
    [tool MJRefreshTopPage:1 controller:self income:incomeOrOutCome];
}
- (void)MJRefreshMore{
    HttpUserIntegralPoint *tool = [HttpUserIntegralPoint sharedInstance];
    [tool MJRefreshMorePage:1 controller:self income:incomeOrOutCome];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
#pragma  mark - 第一次进入加载数据
- (void)loadGrowingPointFirst{
    HttpUserIntegralPoint *tool = [HttpUserIntegralPoint sharedInstance];
    [tool loadFristPage:1 controller:self income:incomeOrOutCome];
}
#pragma mark - UITableViewDelegate Datasoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDScoreCell *cell = [FDScoreCell cellWithTableView:tableView];
    if (incomeOrOutCome == 1) {
        DetailsIncome *model = self.datyArray[indexPath.row];
        cell.score_left.text = @"+";
        cell.score_left.textColor = [FDUtils colorWithHexString:@"#ec455c"];
        cell.score_point.textColor = [FDUtils colorWithHexString:@"#ec455c"];
        cell.merchant_detail.text = [NSString stringWithFormat:@"%@ %@",model.merchant_name,model.content];
        cell.score_detail.text = model.reason;
        cell.eat_time.text = model.order_date;
        cell.score_point.text = [NSString stringWithFormat:@"%@", model.point];
        
    }else{
        DetailsIncome *model = self.datyArray[indexPath.row];
        cell.score_left.text = @"-";
        cell.score_left.textColor = [FDUtils colorWithHexString:@"#333333"];
        cell.score_point.textColor = [FDUtils colorWithHexString:@"#333333"];
        cell.merchant_detail.text = [NSString stringWithFormat:@"%@ %@",model.merchant_name,model.content];
        cell.score_detail.text = model.reason;
        cell.eat_time.text = model.order_date;
        cell.score_point.text = [NSString stringWithFormat:@"%@", model.point];
    
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
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    headerView.backgroundColor = Background_Color;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW,40)];
    whiteView.backgroundColor = [FDUtils colorWithHexString:@"#ff5b51"];
    
    inBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenW/2-1, 40)];
    [inBtn setTitle:@"收入" forState:UIControlStateNormal];
    inBtn.tag =1000;
    [inBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [inBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:whiteView];
    [whiteView addSubview:inBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenW/2-1, 5, 1, 30)];
    line.backgroundColor = [UIColor whiteColor];
    
    [whiteView addSubview:line];
    
    
    leftArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW/4-5, 35, 10, 5)];
    leftArrowImage.image = [UIImage imageNamed:@"list_ico_down_sj"];
    leftArrowImage.hidden = leftImabgHide;
    [whiteView addSubview:leftArrowImage];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    outBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW/2, 0, ScreenW/2, 40)];
    outBtn.tag =1001;
    [outBtn setTitle:@"支出" forState:UIControlStateNormal];
    [outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [outBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:whiteView];
    [whiteView addSubview:outBtn];
    headerView.backgroundColor = Background_Color;
    
    rightArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*3/4-5, 35, 10, 5)];
    rightArrowImage.hidden = rightImabgHide;
    rightArrowImage.image = [UIImage imageNamed:@"list_ico_down_sj"];
    [whiteView addSubview:rightArrowImage];
    return headerView;
    
}

- (void)buttonClick:(UIButton *)sender{
    if (sender.tag == 1000) {

        incomeOrOutCome = 1;
        leftImabgHide = NO;
        rightImabgHide = YES;
    }else{
        incomeOrOutCome = 2;
        leftImabgHide = YES;
        rightImabgHide = NO;
    }
    [self loadFristPage];
    leftArrowImage.hidden = leftImabgHide;
    rightArrowImage.hidden = rightImabgHide;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 77;
    
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
