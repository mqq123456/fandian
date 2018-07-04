//
//  HttpUserOrderDetail.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserOrderDetail.h"
#import "ReqUserOrderDetailModel.h"
#import "ApiParseUserOrderDetail.h"
#import "RespUserOrderDetailModel.h"
#import "HQHttpTool.h"
#import "RequestModel.h"
#import "TablesModel.h"
#import "FDEvaluationViewController.h"
#import "FDTicket_New_ViewController.h"
#import "FDTopicWaitingView.h"
@implementation HttpUserOrderDetail
#pragma mark -  获取单例对象
static id _instace;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

#pragma mark - 加载订单详情
- (void)loadUserOrderDetail:(FDTicket_New_ViewController *)controller{
    
    [controller.activity startAnimating];
    ReqUserOrderDetailModel *reqModel=[[ReqUserOrderDetailModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    if (controller.order_no) {
        reqModel.order_no = controller.order_no;
    }else{
        reqModel.order_no = controller.orderModel.order_no;
    }
    
    ApiParseUserOrderDetail *request=[[ApiParseUserOrderDetail alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [controller.rowInSectionArray removeAllObjects];
            controller.hasNoMassage = NO;
            controller.orderModel = paseData.order;
            ///是否可退款
            if ([controller.orderModel.is_cancel integerValue] == 1) {
                [controller cancleRightItem];
            }else{
                [controller noRightItem];
            }
            ///有分桌了
            if (controller.orderModel.tables.count>0) {
                if(controller.orderModel.tables.count == 1){
                    
                        TablesModel *model = controller.orderModel.tables[0];
                        
                        [controller.rowInSectionArray addObject:model.members];
                }else{
                    for (TablesModel *model in paseData.order.tables) {
                        [controller.rowInSectionArray addObject:model.members];
                    }
                }
                [controller.timer invalidate];
                controller.timer = nil;
            }else{
                [controller.timer invalidate];
                controller.timer = nil;
                controller.timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:controller selector:@selector(loadUserOrderDetailRepeats) userInfo:nil repeats:YES];
            }
            
            
            
            
            
            
            
            //////////////////////////////////////////////

            
            
            
            if([paseData.order.order_kind intValue]==2&&controller.isFromPayShowBonus){///push下单，刚下完单，有空位，分享一元饭票
                controller.isFromPayShowBonus = NO;
                if ([paseData.order.eggshell_empty_seat integerValue]>0) {
                    ///还有剩余，弹一元的
                    controller.shareView.topText.text = [NSString stringWithFormat:@"%@",paseData.order.eggshell_window_content];
                    
                    [controller.navigationController.view addSubview:controller.shareView];
                    
                }else{
                    ///没剩余，弹普通的
                    [controller.navigationController.view addSubview:controller.bonusView];
                    [controller.bonusView.sendTo_weixin addTarget:controller action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
                    [controller.bonusView.bonus_NO addTarget:controller action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                }
                
            }else{
                ///普通的或者话题的
                if ([controller.orderModel.is_bz intValue]==1) {
                    ///普通的
                    if(paseData.order.bag_url&&(![paseData.order.bag_url isEqualToString:@""])&&controller.isFromPayShowBonus){
                        controller.isFromPayShowBonus = NO;
                        [controller.navigationController.view addSubview:controller.bonusView];
                        [controller.bonusView.sendTo_weixin addTarget:controller action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
                        [controller.bonusView.bonus_NO addTarget:controller action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                    }
                }else
                {///话题的
                    if(paseData.order.weixin_topic_url&&(![paseData.order.weixin_topic_url isEqualToString:@""])&&controller.isFromPayShowBonus){
                        controller.isFromPayShowBonus = NO;
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"立即分享到微信\n邀请好友一起来参与吧" delegate:controller cancelButtonTitle:nil otherButtonTitles:@"暂不邀请",@"邀请同事",nil];
                        alertView.tag = 10004;
                        [alertView show];
                    }
                
                }

                
            }
            
            

            
            //////////////////////////////////////////////

            
            if ([controller.orderModel.table_alloc_left_time integerValue]>0) {
                ///餐厅饭票未分桌流量
                [MobClick event:@"pv_certificate1"];
                controller.tableView.tableHeaderView =nil;
                
                controller.tableView.tableHeaderView =controller.topicwaitingView;
                
//                controller.waitingView.merchantName.text = controller.orderModel.merchant_name;
//                NSString *holdStr;
//
//                holdStr=[NSString stringWithFormat:@"%@  %@  %@",controller.orderModel.meal_desc,controller.orderModel.order_date,controller.orderModel.meal_time];
//
//                controller.waitingView.peoplesAndDate.text =holdStr;
//                CGRect  Rect = [[NSString stringWithFormat:@"%@  %@",controller.orderModel.merchant_name,holdStr] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
//                controller.waitingView.contentW.constant = Rect.size.width+10;
//                
//                //                int hour = [controller.orderModel.table_alloc_left_time intValue]/60;
//                //                int minute = [controller.orderModel.table_alloc_left_time intValue]%60;
//                controller.waitingView.hour.text = controller.orderModel.table_alloc_time;
                
            }
            else{
                ///餐厅饭票已分桌流量
                [MobClick event:@"pv_certificate2"];
                controller.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
                
                
            }
            controller.menu_id = paseData.menu_id;
            [controller.tableView reloadData];
            
        }else{
            controller.hasNoMassage = YES;
            
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        controller.hasNoMassage = YES;
        //[controller reloadDataNULL:@"网络连接失败" imageName:@"network_fail_out_nor"];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
        MQQLog(@"%@",[error description]);
        [controller.activity stopAnimating];
    }];
    
}
#pragma mark - 一分钟刷新一次
- (void)loadUserOrderDetailRepeats:(FDTicket_New_ViewController *)controller{
    ReqUserOrderDetailModel *reqModel=[[ReqUserOrderDetailModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    if (controller.order_no) {
        reqModel.order_no = controller.order_no;
    }else{
        reqModel.order_no = controller.orderModel.order_no;
    }
    ApiParseUserOrderDetail *request=[[ApiParseUserOrderDetail alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [controller.rowInSectionArray removeAllObjects];
            controller.hasNoMassage = NO;
            controller.orderModel = paseData.order;
            
            
            if ([controller.orderModel.is_cancel integerValue] == 1) {
                [controller cancleRightItem];
            }else{
                [controller noRightItem];
            }
            
            if (controller.orderModel.tables.count>0) {
                if(controller.orderModel.tables.count == 1){
                    if ([controller.orderModel.is_bz isEqualToString:@"1"]) {
                        
                        
                    }else{
//                        [controller.selectedArray replaceObjectAtIndex:0 withObject:@"1"];//这个用于判断展开还是缩回当前section的cell
                        TablesModel *model = controller.orderModel.tables[0];
                        
                        [controller.rowInSectionArray addObject:model.members];
                    
                    }

                }else{
                    for (TablesModel *model in paseData.order.tables) {
                        [controller.rowInSectionArray addObject:model.members];
                    }
                }
                [controller.timer invalidate];
                controller.timer = nil;
            }else{
                [controller.timer invalidate];
                controller.timer = nil;
                controller.timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:controller selector:@selector(loadUserOrderDetailRepeats) userInfo:nil repeats:YES];
            }
            if ([controller.orderModel.table_alloc_left_time integerValue]>0) {
                controller.tableView.tableHeaderView =nil;
                
                controller.tableView.tableHeaderView =controller.topicwaitingView;
                
//                controller.waitingView.merchantName.text = controller.orderModel.merchant_name;
//                NSString *holdStr;
//                
//                holdStr=[NSString stringWithFormat:@"%@  %@  %@",controller.orderModel.meal_desc,controller.orderModel.order_date,controller.orderModel.meal_time];
//
//                controller.waitingView.peoplesAndDate.text =holdStr;
//                CGRect  Rect = [[NSString stringWithFormat:@"%@  %@",controller.orderModel.merchant_name,holdStr] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
//                controller.waitingView.contentW.constant = Rect.size.width+10;
//                
//                //                    int hour = [controller.orderModel.table_alloc_left_time intValue]/60;
//                //                    int minute = [controller.orderModel.table_alloc_left_time intValue]%60;
//                controller.waitingView.hour.text = controller.orderModel.table_alloc_time;
                
                
            }
            else{
                
                
                controller.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
                
            }
            controller.menu_id = paseData.menu_id;
            [controller.tableView reloadData];
            return ;
            
            
        }else{
            controller.hasNoMassage = YES;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
    } failure:^(NSError *error) {
        controller.hasNoMassage = YES;
        MQQLog(@"%@",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
    }];
    
    
}

- (void)userDetailWithEnvaluation:(FDEvaluationViewController *)controller{
    [controller.activity startAnimating];
    ReqUserOrderDetailModel *reqModel=[[ReqUserOrderDetailModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    if (controller.order_no) {
        reqModel.order_no = controller.order_no;
    }
    ApiParseUserOrderDetail *request=[[ApiParseUserOrderDetail alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderDetailModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            controller.merchant_id = [NSString stringWithFormat:@"%d",paseData.order.merchant_id];
            controller.merchant_name = paseData.order.merchant_name;
            controller.icon = paseData.order.icon;
            controller.creat_time = [NSString stringWithFormat:@"%@", paseData.order.order_date];
            [controller.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.activity stopAnimating];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
    }];
    
}
@end
