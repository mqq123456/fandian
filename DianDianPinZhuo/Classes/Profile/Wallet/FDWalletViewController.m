//
//  FDWalletViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDWalletViewController.h"
#import "FDCouponsViewController.h"
#import "FDInvoiceViewController.h"
#import "FDIntegralViewController.h"

@interface FDWalletViewController ()
{
    NSArray *_imageArray;
    NSArray *_titleArray;
    NSArray *_detailArray;
}


@end

@implementation FDWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:[FDUtils addNavBarView]];
    [self addTitleViewWithTitle:@"我的钱包"];

    _imageArray = @[@"wallet_list_ico_yhq",@"wallet_list_ico_jf",@"wallet_list_ico_fp"];
    _titleArray = @[@"抵扣券",@"积分",@"发票"];
    _detailArray = @[[NSString stringWithFormat:@"%@张",[HQDefaultTool getVoucher_count]],[NSString stringWithFormat:@"%@分",[HQDefaultTool getIntegral_point]],@""];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text  =_detailArray[indexPath.row];

    return cell;
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
        [self.navigationController pushViewController:coupons animated:YES];
    }else if (indexPath.row==1){
        FDIntegralViewController *integral = [[FDIntegralViewController alloc] init];
        [self.navigationController pushViewController:integral animated:YES];
    }else if (indexPath.row==2){
        FDInvoiceViewController *invitation = [[FDInvoiceViewController alloc] init];
        [self.navigationController pushViewController:invitation animated:YES];
    }
}


@end
