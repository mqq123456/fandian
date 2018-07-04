

//
//  HQCouponsSelectViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/31.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "HQCouponsSelectViewController.h"
#import "FDCouponsCell.h"
#import "HQHttpTool.h"
#import "RequestModel.h"
#import "ApiParseUserVoucherList.h"
#import "RespUserVoucherListModel.h"
#import "ReqUserVoucherListModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "HQDefaultTool.h"
#import "VoucherModel.h"
#import "HttpUserVoucherList.h"
#import "FDWebViewController.h"

@interface HQCouponsSelectViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@end

@implementation HQCouponsSelectViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    _page = 1;
    
    [self addTitleViewWithTitle:@"抵扣券"];

    [self setTableView];
    
    [self setupDownRefresh];
    
    [self setTopMJRefresh];
    
    _tableView.footer.hidden = YES;


}

- (void)setTopMJRefresh{
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadUserVoucherList)];
    [_tableView.header beginRefreshing];
}
- (void)loadUserVoucherList{
    HttpUserVoucherList *list = [HttpUserVoucherList sharedInstance];
    [list loadUserVoucherList:self];
}
#pragma mark - 加载更多
- (void)setupDownRefresh{
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserVoucherList)];
}

- (void)loadMoreUserVoucherList{
    HttpUserVoucherList *list = [HttpUserVoucherList sharedInstance];
    [list loadCouponsSelectViewControllerListMore:self];
    
}

#pragma mark - TableView
- (void)setTableView{
    
    self.view.backgroundColor = Background_Color;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.backgroundColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headView.backgroundColor = Background_Color;
    
    [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 12.5, 15, 15)];
    imageView.image = [UIImage imageNamed:@"couponse_why"];
    [headView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 40)];
    label.text = @"抵扣券使用规则";
    label.font = [UIFont systemFontOfSize:12];
    
    [headView addSubview:label];
    _tableView.tableHeaderView = headView;

}

#pragma mark - 抵扣券使用规则
- (void)tapClick{

    FDWebViewController *webView = [[FDWebViewController alloc]init];
    webView.url = [HQDefaultTool getVoucher_qa_url];
    webView.titleString = @"使用规则";
    [self.navigationController pushViewController:webView animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    FDCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FDCouponsCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (IPHONE4||IPHONE5) {
        cell.discount_price.font = [UIFont boldSystemFontOfSize:30];
        cell.yuan.font = [UIFont boldSystemFontOfSize:14];
    }else if (IPhone6){
        cell.discount_price.font = [UIFont boldSystemFontOfSize:38];
        cell.yuan.font = [UIFont boldSystemFontOfSize:15];
    }
    
    VoucherModel *model = self.dataArray[indexPath.row];
    
    if ([model.cash intValue]>=100) {
        cell.discount_price.font = [UIFont boldSystemFontOfSize:26];
        cell.yuan.font = [UIFont boldSystemFontOfSize:14];
        cell.yuanBotton.constant = -3;
    }
    if ([model.voucher_type intValue]==1) {
        cell.discount_price.text = [NSString stringWithFormat:@"%@",model.discount];
        cell.yuan.text = @"折";
        if ([model.discount floatValue]*10-[model.discount intValue]*10>0) {
            if (IPHONE4||IPHONE5) {
                cell.priceW.constant =58;
            }else{
                cell.priceW.constant =70;
            }
            
        }else{
            if (IPHONE4||IPHONE5) {
                cell.priceW.constant =45;
            }else if(IPhone6){
                cell.priceW.constant =50;
            }else{
                cell.priceW.constant =60;
            }
        }
    }else if ([model.voucher_type intValue]==0){
        cell.discount_price.text = model.cash;
        cell.yuan.text = @"元";
        if ([model.cash intValue]>10) {
            if (IPHONE4||IPHONE5) {
                cell.priceW.constant =58;
            }else{
                cell.priceW.constant =70;
            }
            
        }else{
            if (IPHONE4||IPHONE5) {
                cell.priceW.constant =45;
            }else if(IPhone6){
                cell.priceW.constant =50;
            }else{
                cell.priceW.constant =60;
            }
        }
    }
    cell.coupon_name.text = model.voucher_source;

    
    for (int i=0; i<model.limits.count; i++) {
        if (i==0) {
            if (i==0) {
                cell.label1.hidden = NO;
                cell.label1.text = [NSString stringWithFormat:@"%@",model.limits[i]];
            }else{
                cell.label1.hidden = YES;
            }
        }
        if (i==1) {
            if (i==1) {
                cell.label2.hidden = NO;
                cell.label2.text = [NSString stringWithFormat:@"%@",model.limits[i]];
            }else{
                cell.label2.hidden = YES;
            }
        }else if (i==2) {
            if (i==2) {
                cell.label3.hidden = NO;
                cell.label3.text = [NSString stringWithFormat:@"%@",model.limits[i]];
            }else{
                cell.label3.hidden = YES;
            }
        }else if (i==3) {
            if (i==3) {
                cell.label4.hidden = NO;
                cell.label4.text = [NSString stringWithFormat:@"%@",model.limits[i]];
            }else{
                cell.label4.hidden = YES;
            }
        }else if (i==4) {
            if (i==4) {
                cell.label5.hidden = NO;
                cell.label5.text = [NSString stringWithFormat:@"%@",model.limits[i]];
            }else{
                cell.label5.hidden = YES;
            }
        }
    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VoucherModel *model = self.dataArray[indexPath.row];
    if (model.limits.count==1) {
        return 100;
    }if (model.limits.count==2) {
        return 110;
    }else if (model.limits.count==3){
        return 125;
    }else if (model.limits.count==4){
        return 135;
    }else{
        return 150;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.voucherModel = self.dataArray[indexPath.row];
    if (self.voucherModel) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(backWithVoucherModel:)]) {
            [self.delegate backWithVoucherModel:self.voucherModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
