//
//  FDMyOrderViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMyOrderViewController.h"
#import "FDMyOrderCell.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"
#import "HttpUserOrderList.h"
#import "FDEvaluationViewController.h"
#import "FDTicket_New_ViewController.h"
#import "FDOrderListCell.h"
#import "FDOrderListFrame.h"
#import "FDMerchantDetailController.h"
#import "FDOrderViewController.h"
#import "FDShareView.h"
#import "HttpOrderCancel.h"

@interface FDMyOrderViewController ()

@property (nonatomic ,strong) FDBonusView* bonusView;
@property (nonatomic ,strong) FDShareView *shareTicketView;///底部弹起


@end

@implementation FDMyOrderViewController
#pragma mark 底部弹起，右上角分享或者发话题
- (FDShareView *)shareTicketView{
    NSString *share_title;
    
    NSString *share_url;
    
    NSString *share_content;
    if (_shareTicketView==nil) {
        _shareTicketView = [FDShareView shareView];
        _shareTicketView.delegate = self;
        
    }
    
    share_title = @"红包";
    share_content = @"有红包快来抢吧～～～";
#warning 这里写死
    share_url = [NSString stringWithFormat:@"http://h5.fundot.com.cn/h5/extend/send.html?fromKid=%@",[HQDefaultTool getKid]];
        _shareTicketView.type = @"2";
    
    
    _shareTicketView.umURL = share_url;
    _shareTicketView.title = share_title;
    _shareTicketView.contText = share_content;
    _shareTicketView.group_share_title = share_title;
    
    _shareTicketView.group_share_hint = @"立即查看";
    
    _shareTicketView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    return _shareTicketView;
}
#pragma mark 红包视图
- (FDBonusView *)bonusView{
    if (_bonusView == nil) {
        _bonusView = [FDBonusView selfBounsView];
        _bonusView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    }
    return _bonusView;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    if ([self.state isEqualToString:@"1"]) {//待使用

        [MobClick event:@"pv_readyforuse"];
        
        
    }
    else if ([self.state isEqualToString:@"2"]) {//待评价

        [MobClick event:@"pv_readyforcomment"];
        
        
    }
    else if ([self.state isEqualToString:@"3"]) {//已完成

        [MobClick event:@"pv_ordercomplete"];
        
        
    }
    else if ([self.state isEqualToString:@"-2"]) {//退款
        
        ///我的订单流量
        [MobClick event:@"pv_refund"];
        
        
    }
    else{
        
        ///我的订单流量
        [MobClick event:@"pv_myorder"];
        
        
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.bonusView removeFromSuperview];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[FDUtils addNavBarView]];
    if ([self.state isEqualToString:@"0"]) {
        [self addTitleViewWithTitle:@"待付款"];
    }else if ([self.state isEqualToString:@"1"]) {//待使用
        [self addTitleViewWithTitle:@"待使用"];
    }
    else if ([self.state isEqualToString:@"2"]) {//待评价
        [self addTitleViewWithTitle:@"待评价"];
    }
    else if ([self.state isEqualToString:@"3"]) {//已完成
        [self addTitleViewWithTitle:@"已完成"];
    }
    else if ([self.state isEqualToString:@"-2"]) {//退款

        [self addTitleViewWithTitle:@"退款"];
    }
    else{
    
        [self addTitleViewWithTitle:@"我的饭票"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MJRefreshTop:) name:RefreshOrderListViewController object:nil];
    
    self.page = 1;
    self.haveMJRefresh = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //第一次加载
    [self loadUserOrderListFrist];
    
    self.tableView.footer.hidden = YES;
}
#pragma mark - 第一次加载
- (void)loadUserOrderListFrist{
    HttpUserOrderList *tool = [HttpUserOrderList sharedInstance];
    [tool loadUserOrderListFirst:self];
}
- (void)MJRefreshTop:(NSNotification *)no{
    HttpUserOrderList *tool = [HttpUserOrderList sharedInstance];
    tool.isCommentBack = YES;
    [tool loadUserOrderTop:self];
}

- (void)MJRefreshMore{
    HttpUserOrderList *tool = [HttpUserOrderList sharedInstance];
    [tool loadUserOrderMore:self];
}

- (void)MJRefreshTop{
    HttpUserOrderList *tool = [HttpUserOrderList sharedInstance];
    [tool loadUserOrderTop:self];
}

#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDOrderListFrame *frame = self.datyArray[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FDOrderListCell *cell = [FDOrderListCell cellWithTableView:tableView];
    
    cell.statusFrame = self.datyArray[indexPath.row];
    cell.again_btn.tag = indexPath.row*10;
    cell.only_btn.tag = indexPath.row;
    [cell.again_btn addTarget:self action:@selector(again_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.only_btn addTarget:self action:@selector(only_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
- (void)again_btnClick:(UIButton *)btn{
    FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
    FDOrderListFrame *frame = self.datyArray[btn.tag/10];
    OrderModel *order = frame.status;
    MerchantModel *model = [[MerchantModel alloc] init];
    model.merchant_id = order.merchant_id;
    detail.model = model;
    detail.latString = [HQDefaultTool getLat];
    detail.lngString = [HQDefaultTool getLng];
    detail.local_lng = [HQDefaultTool getLng];
    detail.local_lat = [HQDefaultTool getLat];
    detail.local = @"1";
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)only_btnClick:(UIButton *)btn{
    FDOrderListFrame *frame = self.datyArray[btn.tag];
    OrderModel *order = frame.status;
    
    if ([btn.titleLabel.text isEqualToString:@"去支付"]) {
        
        FDOrderViewController *orderController = [[FDOrderViewController alloc] init];
        
        orderController.merchant_id = [NSString stringWithFormat:@"%d",order.merchant_id];
        orderController.merchant_name = order.merchant_name;
        orderController.icon = order.icon;
        orderController.kdate = order.order_date_std;
        orderController.kdate_desc = order.order_date;
        if (order.is_bz) {
            orderController.people_desc = order.meal_desc;
        }else{
            orderController.people_desc = [NSString stringWithFormat:@"拼桌 %d人",order.people];
        }
        
        orderController.meal_time = order.meal_time;
        orderController.price = order.price;
        orderController.people = [NSString stringWithFormat:@"%d",order.people];
        orderController.meal_id = order.meal_id;
//        orderController.menu_id = order.menu_id;
        orderController.topic_id = order.topic_id;
//        VoucherModel *vourcher = [[VoucherModel alloc] init];
//        vourcher.voucher_id = [order.voucher_id intValue];
//        vourcher.voucher_type = order.voucher_type;
//        order.voucherModel = vourcher;
        orderController.is_bz = order.is_bz;
        if ([order.integral_point intValue]>=500) {///选择了积分
            orderController.integral_point = @"500";
        }else{
            orderController.integral_point = @"0";
        }
//        orderController.activity_id = order.activity_id;
        orderController.topic_id = order.topic_id;
//        if (order.initial_topic) {
//            orderController.initial_topic = self.initial_topic;
//        }
        orderController._paid = [NSString stringWithFormat:@"%.2f",[order.paid doubleValue]];
        
        [self.navigationController pushViewController:orderController animated:YES];

    }else if ([btn.titleLabel.text isEqualToString:@"退款"]){
        _selected_btn_model = order;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确认退款？" delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alertView.tag =10002;
        [alertView show];
        
        
    }else if ([btn.titleLabel.text isEqualToString:@"评价送积分"]){
        [MobClick event:@"click_commentreward"];
        FDEvaluationViewController *evaluation = [[FDEvaluationViewController alloc] init];
        evaluation.merchant_id = [NSString stringWithFormat:@"%d",order.merchant_id] ;
        evaluation.order_no = order.order_no;
        evaluation.merchant_name = order.merchant_name;
        evaluation.icon = order.icon;
        evaluation.creat_time = order.order_date;
        evaluation.fromOrderList = YES;
        [self.navigationController pushViewController:evaluation animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"发红包"]){
        [self.navigationController.view addSubview:self.bonusView];
        [self.bonusView.sendTo_weixin addTarget:self action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
        [self.bonusView.bonus_NO addTarget:self action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
        

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10002) {
        ///退订
        if (buttonIndex == 1) {
//            if ([self.selected_btn_model.is_cancel intValue]==0) {
//                [SVProgressHUD showImage:nil status:self.selected_btn_model.refund_toast];
//                return;
//            }
            [MobClick event:@"click_certificate_cancel"];
            HttpOrderCancel *cancle = [HttpOrderCancel sharedInstance];
            [cancle loadCancleOrderWithModel:self.selected_btn_model Controller:self];
            
        }
    }
}
#pragma mark  退订成功
- (void)cancleSuccessed{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"已支付的%@元会在24小时内退回你",self.selected_btn_model.paid] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 10001;
    [alertView show];
}

- (void)cancleFailed{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"退订失败，请稍后重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = 10003;
    [alertView show];
    
}

#pragma mark  分享红包
- (void)sendTo_weixin_Click{
    
    [self.bonusView removeFromSuperview];
    [self.navigationController.view addSubview:self.shareTicketView];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bag_url"];
    
    
}
- (void)bonus_NO_Click{
    [self.bonusView removeFromSuperview];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ///点击某一订单
    [MobClick event:@"click_myorder_order"];
    FDOrderListFrame *frame = self.datyArray[indexPath.row];
    OrderModel *model = frame.status;
    
    
    FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc]init];
    ticket.orderModel = model;
    ticket.order_no = model.order_no;
    
    if(model.state==0){//以提交
        
    }else if (model.state==1) {//待使用
        
        [self.navigationController pushViewController:ticket animated:YES];
        
        
    }else if (model.state ==2){//待评价
        
        [self.navigationController pushViewController:ticket animated:YES];
        
    }else if (model.state ==3){
        
        [self.navigationController pushViewController:ticket animated:YES];
        
    }
    
    
    

    

}

#pragma mark - 点击状态按钮
- (void)clickStateBtn:(UIButton *)sender{

    ///点击某一订单
    [MobClick event:@"click_myorder_order"];
    
    OrderModel *model = self.datyArray[sender.tag];
    if(model.state==0){//以提交
        
    }else if (model.state==1) {//待使用

        FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc] init];
        ticket.orderModel = model;
            
        [self.navigationController pushViewController:ticket animated:YES];
    }else if (model.state ==2){//待评价
        [MobClick event:@"click_commentreward"];
        FDEvaluationViewController *evaluation = [[FDEvaluationViewController alloc] init];
        evaluation.merchant_id = [NSString stringWithFormat:@"%d",model.merchant_id] ;
        evaluation.order_no = model.order_no;
        evaluation.merchant_name = model.merchant_name;
        evaluation.icon = model.icon;
        evaluation.creat_time = model.order_date;
        evaluation.fromOrderList = YES;
        [self.navigationController pushViewController:evaluation animated:YES];
    }else if (model.state ==3){
        FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc] init];
        ticket.orderModel = model;
        [self.navigationController pushViewController:ticket animated:YES];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datyArray.count;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
