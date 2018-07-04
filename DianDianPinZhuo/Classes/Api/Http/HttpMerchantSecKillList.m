//
//  HttpMerchantSecKillList.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantSecKillList.h"
#import "ApiParseMerchantSecKillList.h"
#import "ReqMerchantSeckillListModel.h"
#import "RespMerchantSeckillListModel.h"
#import "MerchantModel.h"
#import "Toast+UIView.h"
@implementation HttpMerchantSecKillList
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
//
///**
// *  第一次
// *
// */
//- (void)loadSeckillMerchantListFirst:(FDSecondKillViewController *)controller{
//    controller.max_distance = @"0";
//    [controller.activity startAnimating];
//    ReqMerchantSeckillListModel *reqModel=[[ReqMerchantSeckillListModel alloc]init];
//    reqModel.local_lat = controller.latString;
//    reqModel.local_lng = controller.lngString;
//    reqModel.meal_id = controller.meal_id;
//    reqModel.page = 1;
//    reqModel.local = controller.local;
//    reqModel.max_distance = controller.max_distance;
//    ApiParseMerchantSecKillList *request=[[ApiParseMerchantSecKillList alloc]init];
//    RequestModel *requestModel=[request requestData:reqModel];
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        
//        RespMerchantSeckillListModel *paseData=[request parseData:json];
//        
//        if ([paseData.code isEqualToString:@"1"]) {
//            controller.headerView.hidden = NO;
//            [controller.headerView.meal_time setTitle:[NSString stringWithFormat:@"%@",paseData.meal_time] forState:UIControlStateNormal];
//            controller.meal_time = paseData.meal_time;
//            
//            controller.order_date = paseData.order_date;
//            
//            
//            if ([paseData.end_time intValue]<=0) {
//                controller.hasEnd = YES;
//                ///结束了
//                controller.headerView.descLabel.text = @"秒杀已结束";
//                [controller.headerView.minnute setTitle:@"0" forState:UIControlStateNormal];
//                [controller.headerView.second setTitle:@"0" forState:UIControlStateNormal];
//            }else{
//                controller.hasEnd = NO;
//                if ([paseData.start_time intValue]>0) {
//                    ///还没开始
//                    controller.hasStart = NO;
//                    controller.headerView.descLabel.text = @"距离秒杀开始";
//                    controller.secondsCountDown= [paseData.start_time intValue];
//                    
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                }else{
//                    controller.hasStart = YES;
//                    controller.headerView.descLabel.text = @"距离秒杀结束";
//                    controller.secondsCountDown= [paseData.end_time intValue];
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                    
//                }
//                
//            }
//            
//            if (paseData.merchants!=nil&&paseData.merchants.count!=0) {
//                controller.max_distance = paseData.max_distance;
//                [controller.datyArray removeAllObjects];
//                [controller.datyArray addObjectsFromArray:paseData.merchants];
//                [controller.tableView reloadData];
//            }else{
//                
//            }
//            
//        }else{
//            controller.headerView.hidden = YES;
//            [SVProgressHUD showImage:nil status:paseData.desc];
//            controller.page-=1;
//        }
//        if (paseData.merchants.count<8) {
//            controller.tableView.footer.hidden = YES;
//        }else{
//            controller.tableView.footer.hidden = NO;
//        }
//        [controller.activity stopAnimating];
//    } failure:^(NSError *error) {
//        controller.headerView.hidden = YES;
//        MQQLog(@"==%@",[error description]);
//        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
//        [controller.activity stopAnimating];
//    }];
//
//
//}
///**
// *  下拉
// *
// */
//- (void)loadSeckillMerchantListTop:(FDSecondKillViewController *)controller{
//    controller.page = 1;
//    controller.max_distance = @"0";
//    ReqMerchantSeckillListModel *reqModel=[[ReqMerchantSeckillListModel alloc]init];
//    reqModel.local_lat = controller.latString;
//    reqModel.local_lng = controller.lngString;
//    reqModel.meal_id = controller.meal_id;
//    reqModel.page = controller.page;
//    reqModel.local = controller.local;
//    reqModel.max_distance= controller.max_distance;
//    ApiParseMerchantSecKillList *request=[[ApiParseMerchantSecKillList alloc]init];
//    RequestModel *requestModel=[request requestData:reqModel];
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        
//        RespMerchantSeckillListModel *paseData=[request parseData:json];
//        if ([paseData.code isEqualToString:@"1"]) {
//            [controller.countDownTimer invalidate];
//            controller.headerView.hidden = NO;
//            [controller.headerView.meal_time setTitle:[NSString stringWithFormat:@"%@",paseData.meal_time] forState:UIControlStateNormal];
//            controller.meal_time = paseData.meal_time;
//            
//            controller.order_date = paseData.order_date;
//            
//            
//            if ([paseData.end_time intValue]<=0) {
//                controller.hasEnd = YES;
//                ///结束了
//                controller.headerView.descLabel.text = @"秒杀已结束";
//                [controller.headerView.minnute setTitle:@"0" forState:UIControlStateNormal];
//                [controller.headerView.second setTitle:@"0" forState:UIControlStateNormal];
//            }else{
//                controller.hasEnd = NO;
//                if ([paseData.start_time intValue]>0) {
//                    ///还没开始
//                    controller.hasStart = NO;
//                    controller.headerView.descLabel.text = @"距离秒杀开始";
//                    controller.secondsCountDown= [paseData.start_time intValue];
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                }else{
//                    controller.hasStart = YES;
//                    controller.headerView.descLabel.text = @"距离秒杀结束";
//                    controller.secondsCountDown= [paseData.end_time intValue];
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                    
//                }
//                
//            }
//            
//            if (paseData.merchants!=nil&&paseData.merchants.count!=0) {
//                [controller.datyArray removeAllObjects];
//                controller.max_distance = paseData.max_distance;
//                [controller.datyArray addObjectsFromArray:paseData.merchants];
//                [controller.tableView reloadData];
//            }else{
//                
//            }
//            
//            
//            
//        }else{
//            
//            [SVProgressHUD showImage:nil status:paseData.desc];
//            controller.page-=1;
//        }
//        if (paseData.merchants.count<8) {
//            controller.tableView.footer.hidden = YES;
//        }else{
//            controller.tableView.footer.hidden = NO;
//        }
//        [controller.tableView.header endRefreshing];
//    } failure:^(NSError *error) {
//        MQQLog(@"error=%@",[error description]);
//        [controller.tableView.header endRefreshing];
//        controller.page-=1;
//        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
//        
//    }];
//    
//    
//
//
//}
///**
// *  上拉
// *
// */
//- (void)loadSeckillMerchantListMore:(FDSecondKillViewController *)controller{
//    controller.page+=1;
//    ReqMerchantSeckillListModel *reqModel=[[ReqMerchantSeckillListModel alloc]init];
//    reqModel.local_lat = controller.latString;
//    reqModel.local_lng = controller.lngString;
//    reqModel.meal_id = controller.meal_id;
//    reqModel.page = controller.page;
//    reqModel.local = controller.local;
//    reqModel.max_distance= controller.max_distance;
//    
//    ApiParseMerchantSecKillList *request=[[ApiParseMerchantSecKillList alloc]init];
//    RequestModel *requestModel=[request requestData:reqModel];
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        RespMerchantSeckillListModel *paseData=[request parseData:json];
//        
//        [controller.tableView.footer endRefreshing];
//        
//        if ([paseData.code isEqualToString:@"1"]) {
//            [controller.countDownTimer invalidate];
//            controller.headerView.hidden = NO;
//            [controller.headerView.meal_time setTitle:[NSString stringWithFormat:@"%@",paseData.meal_time] forState:UIControlStateNormal];
//            controller.meal_time = paseData.meal_time;
//            
//            controller.order_date = paseData.order_date;
//            if (paseData.merchants.count<8) {
//                controller.tableView.footer.hidden = YES;
//                //[SVProgressHUD showImage:nil status:@"没有更多了！"];
//                [controller.view makeToast:@"没有更多了！"];
//                
//            }else{
//                controller.tableView.footer.hidden = NO;
//            }
//            
//            if ([paseData.end_time intValue]<=0) {
//                controller.hasEnd = YES;
//                ///结束了
//                controller.headerView.descLabel.text = @"秒杀已结束";
//                [controller.headerView.minnute setTitle:@"0" forState:UIControlStateNormal];
//                [controller.headerView.second setTitle:@"0" forState:UIControlStateNormal];
//            }else{
//                controller.hasEnd = NO;
//                if ([paseData.start_time intValue]>0) {
//                    ///还没开始
//                    controller.hasStart = NO;
//                    controller.headerView.descLabel.text = @"距离秒杀开始";
//                    controller.secondsCountDown= [paseData.start_time intValue];
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                }else{
//                    controller.hasStart = YES;
//                    controller.headerView.descLabel.text = @"距离秒杀结束";
//                    controller.secondsCountDown= [paseData.end_time intValue];
//                    [controller.countDownTimer invalidate];
//                    controller.countDownTimer=nil;
//                    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:controller selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//                    controller.countDownTimer = countDownTimer;
//                    
//                    
//                }
//                
//            }
//            
//            [controller.datyArray addObjectsFromArray:paseData.merchants];
//            
//            [controller.tableView reloadData];
//        }else{
//            [SVProgressHUD showImage:nil status:paseData.desc];
//            controller.page-=1;
//        }
//        
//    } failure:^(NSError *error) {
//        MQQLog(@"error=%@",[error description]);
//        [controller.tableView.footer endRefreshing];
//        controller.page-=1;
//        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
//        
//    }];
//
//}
@end
