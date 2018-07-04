//
//  FDOrderViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDOrderViewController.h"
#import "FDOrderSection0Cell.h"
#import "FDSection11TableViewCell.h"
#import "FDSection10TableViewCell.h"
#import "FDOrderBottomView.h"
#import "HQCouponsSelectViewController.h"
#import "PayResultView.h"
#import "PayFail.h"
#import "HttpOrderBook.h"
#import "HttpOrderCancel.h"
#import "FDSubmitOrderSection02Cell.h"
#import "FDSubmitOrderSection00Cell.h"
#import "FDTicket_New_ViewController.h"

@interface FDOrderViewController ()<UIAlertViewDelegate>

@end

@implementation FDOrderViewController

#pragma mark - life cycle
- (FDOrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [FDOrderBottomView fdOrderBottomView];
        _bottomView.price.text = [NSString stringWithFormat:@"%d",(int)([self.price doubleValue]*[self.people intValue])];
        _bottomView.diccount_prie.text = @"";
        [_bottomView.confirmBtn addTarget:self action:@selector(orderClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"支付订单"];
    
    self.voucherArray = [NSMutableArray array];
    
    [self.view addSubview:self.bottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultNtDeal:) name:PayOrderBackNotification object:nil];
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-60-64);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _payWay = 1;

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back3"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    backButton.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    self.navigationItem.leftBarButtonItem= backButton;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"pv_pay"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)leftClick{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"放弃当前订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1000;
    [alertView show];
}
- (void)backClick{
    [self.popoverListView dismiss];
    [self orderCancel];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)orderClick:(UIButton *)button{
    HttpOrderBook *tool = [HttpOrderBook sharedInstance];
    [tool orderClick:self button:button];
    
}
#pragma mark  开餐日期已过
- (void)timeFialBtnClick{
    [self.popoverListView dismiss];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 支付结果
- (void)payResultNtDeal:(NSNotification *)notice{
    [self.popoverListView dismiss];
    NSDictionary *dict = notice.userInfo;
    NSInteger type = [dict[PaySuccFlag] integerValue];
    if (type==1) {//支付成功
        ///支付成功
        [MobClick event:@"click_pay_success"];
        [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];
        
        FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc]init];
        ticket.order_no = self.order_on;
        ticket.isFromPay = YES;
        ticket.isFromPayShowBonus = YES;
        [self.navigationController pushViewController:ticket animated:YES];
        
    }else{
        ///支付失败
        [MobClick event:@"click_pay_fail"];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"支付失败，请重新支付" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 2000;
        [alertView show];
    }
}

#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1000) {///放弃订单
        
        if(buttonIndex == 1){
            
            [self orderCancel];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else if (alertView.tag == 2000){///支付失败
        [self orderCancel];
        
    }else if (alertView.tag == 3000){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)orderCancel{
    HttpOrderCancel *tool = [HttpOrderCancel sharedInstance];
    [tool PayFailWithOrder_no:self.order_on controller:self];
}

- (void)PayFail{
    [self.popoverListView dismiss];
    [self orderCancel];
    CGFloat xWidth = [UIScreen mainScreen].bounds.size.width- 40.0f;
    CGFloat yHeight = 240.0f;
    CGFloat yOffset = ([UIScreen mainScreen].bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    poplistview.listView.scrollEnabled = FALSE;
    poplistview.isTouchOverlayView = YES;
    [poplistview show];
    self.popoverListView = poplistview;
    self.popoverListView.listView.separatorStyle =UITableViewCellSeparatorStyleNone;
    PayResultView *payResult = [[[NSBundle mainBundle] loadNibNamed:@"PayResultView" owner:nil options:nil]lastObject];
    [payResult addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
    payResult.frame = self.popoverListView.bounds;
    payResult.title.text = @"支付失败";
    payResult.detail.text = @"请重新支付";
    [payResult.doneBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [poplistview addSubview:payResult];
    
}
- (void)cancleBtnClick{
    [self.popoverListView dismiss];
}

#pragma mark - UITableViewDatous Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }else{
        return 12;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return 80;
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                return 40;
            }
            return 60;
        }
            break;
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            FDSubmitOrderSection00Cell *cell = [FDSubmitOrderSection00Cell cellWithTableView:tableView];
            cell.merchantName.text = self.merchant_name;
            
            if ([self.is_bz intValue]==1) {
                cell.price.text = [NSString stringWithFormat:@"%@",self.price];
                cell.meiren.text = @"/桌";
            }else{
                
                cell.price.text = self.price;
                cell.meiren.text = @"/人";
            }
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                cell.icon.image = image;
            }];
            return cell;
            
        }
            break;
            
        case 1:
            
        {
            
            FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
            if (indexPath.row==0) {
                cell.title.text = @"开餐时间";
                cell.price.text = [NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
                cell.accView.hidden = YES;
                
            }else{
                cell.title.text = @"就餐方式";
                NSString *people_desc =  [self.people_desc stringByReplacingOccurrencesOfString:@"\n"withString:@""];
                cell.price.text = people_desc;
                cell.accView.hidden = YES;
            }
            return cell;
            
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0) {
                FDSection10TableViewCell *cell = [FDSection10TableViewCell cellWithTableView:tableView];
                cell.otherPrice.text =[NSString stringWithFormat:@"¥%@",self._paid];
                return cell;
                
            }else{
                
                FDSection11TableViewCell *cell = [FDSection11TableViewCell cellWithTableView:tableView];
                if(indexPath.row == 1){
                    
                    cell.payView.image = [UIImage imageNamed:@"order_ico_zfb"];
                    
                    cell.pay_name.text = @"支付宝";
                    
                    cell.pay_Select.tag = 1001;
                    
                    if (_payWay==1) {
                        cell.pay_Select.selected = YES;
                        
                    }else{
                        cell.pay_Select.selected = NO;
                        
                    }
                    
                    
                }else{
                    
                    cell.payView.image = [UIImage imageNamed:@"order_ico_weixin"];
                    
                    if (_payWay==2) {
                        cell.pay_Select.selected = YES;
                        
                    }else{
                        cell.pay_Select.selected = NO;
                        
                    }
                    cell.pay_name.text = @"微信";
                    
                    cell.pay_Select.tag = 1002;
                    
                }
                
                return cell;
                
            }
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)pay_SelectBtnClick:(UIButton *)button{
    button.selected = YES;
    _payWay = button.tag-1000;
    if (button.tag==1001) {
        UIButton *btn = [self.tableView viewWithTag:1002];
        btn.selected = NO;
    }else{
        UIButton *btn = [self.tableView viewWithTag:1001];
        btn.selected = NO;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSIndexPath *path1 = [NSIndexPath indexPathForRow:1 inSection:2];
        FDSection11TableViewCell *cellPay = [self.tableView cellForRowAtIndexPath:path1];
        NSIndexPath *path2 = [NSIndexPath indexPathForRow:2 inSection:2];
        FDSection11TableViewCell *cellWeixin = [self.tableView cellForRowAtIndexPath:path2];
        if (indexPath.row == 1) {
            ///支付宝
            [MobClick event:@"click_pay_alipay"];
            _payWay = 1;
            cellPay.pay_Select.selected = YES;
            cellWeixin.pay_Select.selected = NO;
        }else if(indexPath.row == 2){
            ///微信
            [MobClick event:@"click_pay_weixin"];
            _payWay = 2;
            cellPay.pay_Select.selected = NO;
            cellWeixin.pay_Select.selected = YES;
        }
    }
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end