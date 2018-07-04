//
//  HttpTopicOrderDetail.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicOrderDetail.h"
#import "TopicUsersModel.h"
#import "ApiPaseTopicOrderDetail.h"
#import "RespTopicOrderDetail.h"
#import "ReqTopicOrderDetailModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "HQConst.h"
#import "SVProgressHUD.h"
@implementation HttpTopicOrderDetail
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

//- (void)loadTopicOrderDetail:(NSString *)topic_id viewController:(FDTicket_New_ViewController *)viewController{
//    viewController.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64);
//    ReqTopicOrderDetailModel *reqModel =[[ReqTopicOrderDetailModel alloc]init];
//    reqModel.kid = [HQDefaultTool getKid];
//    reqModel.topic_id = topic_id;
//    reqModel.order_no = viewController.order_no;
//    ApiPaseTopicOrderDetail*request=[[ApiPaseTopicOrderDetail alloc]init];
//    
//    RequestModel *requestModel =[request requestData:reqModel];
//    
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        RespTopicOrderDetail *paseData=[request parseData:json];
//        if ([paseData.code isEqualToString:@"1"]) {
//            [viewController Topic_ticket_FrameModel:paseData];
//            viewController.topic_ticket_model = paseData;
//            [viewController setupWaitingView];
//            if ([viewController.topic_ticket_model.is_cancel integerValue] == 1) {
//                [viewController cancleRightItem];
//            }else{
//                [viewController noRightItem];
//            }
//            
//            if([viewController.topic_ticket_model.table_alloc_left_time integerValue]<=0){
//                [viewController.timer invalidate];
//                viewController.timer = nil;
//            }else{
//                [viewController.timer invalidate];
//                viewController.timer = nil;
//                viewController.timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:viewController selector:@selector(loadUserOrderDetailRepeats) userInfo:nil repeats:YES];
//            }
//            if(paseData.bag_url&&(![paseData.bag_url isEqualToString:@""])&&viewController.isFromPayShowBonus){
//                viewController.isFromPayShowBonus = NO;
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"立即分享到微信\n邀请好友一起来参与吧" delegate:viewController cancelButtonTitle:nil otherButtonTitles:@"暂不邀请",@"邀请同事",nil];
//                alertView.tag = 10004;
//                [alertView show];
//            }
//            
//            [viewController.tableView reloadData];
//        }else{
//            [SVProgressHUD showImage:nil status:paseData.desc];
//            viewController.tableView.height = 0;
//        }
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUD showImage:nil status:@"网络连接失败"];
//        MQQLog(@"=======%@======",[error description]);
//        viewController.tableView.height = 0;
//    }];
//    
//}
//
//#pragma mark - 一分钟刷新一次
//- (void)loadUserOrderDetailRepeatsOrderDetail:(NSString *)topic_id viewcontroller:(FDTicket_New_ViewController *)viewController{
//    
//    viewController.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-64);
//    ReqTopicOrderDetailModel *reqModel =[[ReqTopicOrderDetailModel alloc]init];
//    reqModel.kid = [HQDefaultTool getKid];
//    reqModel.topic_id = topic_id;
//    reqModel.order_no = viewController.order_no;
//    ApiPaseTopicOrderDetail*request=[[ApiPaseTopicOrderDetail alloc]init];
//    
//    RequestModel *requestModel =[request requestData:reqModel];
//    
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        RespTopicOrderDetail *paseData=[request parseData:json];
//        if ([paseData.code isEqualToString:@"1"]) {
//            [viewController Topic_ticket_FrameModel:paseData];
//            viewController.topic_ticket_model = paseData;
//            [viewController setupWaitingView];
//            if ([viewController.topic_ticket_model.is_cancel integerValue] == 1) {
//                [viewController cancleRightItem];
//            }else{
//                [viewController noRightItem];
//            }
//            
//            if([viewController.topic_ticket_model.table_alloc_left_time integerValue]<0){
//                [viewController.timer invalidate];
//                viewController.timer = nil;
//            }else{
//                [viewController.timer invalidate];
//                viewController.timer = nil;
//                viewController.timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:viewController selector:@selector(loadUserOrderDetailRepeats) userInfo:nil repeats:YES];
//            }
////            if(paseData.bag_url&&(![paseData.bag_url isEqualToString:@""])&&viewController.isFromPayShowBonus){
////                viewController.isFromPayShowBonus = NO;
//////                [viewController.navigationController.view addSubview:viewController.bonusView];
//////                
//////                [viewController.bonusView.sendTo_weixin addTarget:viewController action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
//////                [viewController.bonusView.bonus_NO addTarget:viewController action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
////                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"立即分享到微信\n邀请好友一起来参与吧" delegate:self cancelButtonTitle:@"暂不邀请" otherButtonTitles:@"邀请同事",nil];
////                [alertView show];
////                
////            }
//            
//            [viewController.tableView reloadData];
//        }else{
//            viewController.tableView.height = 0;
//            [SVProgressHUD showImage:nil status:paseData.desc];
//        }
//        
//    } failure:^(NSError *error) {
//        viewController.tableView.height = 0;
//        [SVProgressHUD showImage:nil status:@"网络连接失败"];
//        MQQLog(@"=======%@======",[error description]);
//    }];
//    
//    
//}

@end
