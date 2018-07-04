//
//  HttpLoading.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpLoading.h"
#import "HQMD5Tool.h"
#import "ApiParseBaseLoading.h"
#import "ReqBaseLoadingModel.h"
#import "RespBaseLoadingModel.h"
#import "IndustriesModel.h"
#import "AdsModel.h"
#import "VersionModel.h"
#import "KdateModel.h"
#import "MealsModel.h"
#import "HQConst.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "UIPopoverListView.h"
#import "PayFail.h"
#import "UIView+WZLBadge.h"
#import "PeopleModel.h"
#import "FDUUidManager.h"
#import "FDHomeViewController.h"

@implementation HttpLoading

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

- (void)saveDefault:(RespBaseLoadingModel *)paseData{
    [HQDefaultTool setDown_url:paseData.down_url];
    [HQDefaultTool setService:paseData.service];
    [HQDefaultTool setAgreement_url:paseData.agreement_url];
    [HQDefaultTool setOrder_timeout:paseData.order_timeout];
    [HQDefaultTool setOrder_tips:paseData.order_tips];
    [HQDefaultTool setTopic_tips:paseData.topic_tips];
    [HQDefaultTool setSeckill_order_tips:paseData.seckill_order_tips];
    [HQDefaultTool setVoucher_qa_url:paseData.voucher_qa_url];
    [HQDefaultTool setAdvanced_order_tips_title:paseData.advanced_order_tips_title];
    
    [HQDefaultTool setAdvanced_order_tips_content:paseData.advanced_order_tips_content];
    [HQDefaultTool setGroups_notice:paseData.groups_notice];

}
- (void)loadingLat:(NSString *)lat lng:(NSString *)lng viewController:(FDHomeViewController *)viewController{

    ReqBaseLoadingModel *reqModel=[[ReqBaseLoadingModel alloc]init];
    reqModel.platform=APP_PLAT;
    reqModel.device_token = [HQDefaultTool getRegistrationID];
    reqModel.ua=[[UIDevice currentDevice] model];
    reqModel.brand=[[UIDevice currentDevice] systemName];
    if ([FDUUidManager sharedManager].imei==nil) {
        [FDUUidManager sharedManager].imei=[HQMD5Tool md5:[HQDefaultTool getUuid]];
        [[FDUUidManager sharedManager] saveUserinfo];
        
    }
    reqModel.imei=[FDUUidManager sharedManager].imei;
    reqModel.fbl=[NSString stringWithFormat:@"%f-%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height];
    reqModel.ver=[[UIDevice currentDevice] systemVersion];;
    reqModel.cver=APP_VERSION;
    reqModel.channel=APP_CHANNEL;
    reqModel.dver=APP_DATA_VERSION;
    
    if (![[HQDefaultTool getKid] isEqualToString:@""]) {
        reqModel.kid = [HQDefaultTool getKid];
    }
    reqModel.local_lng = lng;
    reqModel.local_lat = lat;
    
    [[UIDevice currentDevice]identifierForVendor];
    ApiParseBaseLoading *request=[[ApiParseBaseLoading alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespBaseLoadingModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            [self saveDefault:paseData];
            
            if ([paseData.is_msg intValue]==1&&![[HQDefaultTool getKid] isEqualToString:@""]) {//有新的消息
                viewController.redDotView.hidden = NO;
            }else{
                viewController.redDotView.hidden = YES;
            }
            
            viewController.integral_tip = paseData.integral_tip;
            ///loading成功，显示附近人数
            [[NSNotificationCenter defaultCenter] postNotificationName:loadingBack object:nil userInfo:@{@"nearby_people":[NSString stringWithFormat:@"%@",paseData.nearby_people],@"nearby_people_desc":paseData.nearby_people_desc,@"nearby_topic":[NSString stringWithFormat:@"%@",paseData.nearby_topic],@"nearby_topic_desc":paseData.nearby_topic_desc,@"adsArray":paseData.ads}];
            
            
            if (paseData.kdates !=nil &&[paseData.kdates count]!= 0) {//开餐时间
                viewController.kdatesArray = paseData.kdates;
            }
            
            
            
            [viewController.kdates removeAllObjects];
            [viewController.kdescs removeAllObjects];
            [viewController.ktimes removeAllObjects];
            [viewController.kmeal_ids removeAllObjects];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (KdateModel *model in viewController.kdatesArray) {//将开餐时间装到不同数组中
                
                for (MealsModel *meals in model.meals) {
                    [array addObject:[NSString stringWithFormat:@"%@ %@ %@ %@",model.kdate_desc,meals.meal_desc,meals.meal_id,model.kdate]];
                    [viewController.kdates addObject:model.kdate];
                    [viewController.kdescs addObject:model.kdate_desc];
                    [viewController.ktimes addObject:meals.meal_desc];
                    [viewController.kmeal_ids addObject:meals.meal_id];
                    
                    
                }
                
                
            }
            viewController.eatingDatesArray = array;
            for (int i=0; i<viewController.kdatesArray.count; i++) {//计算最优时间
                KdateModel *kdateModel = viewController.kdatesArray[i];
                for (int j=0; j<kdateModel.meals.count; j++) {
                    MealsModel *mealModel = kdateModel.meals[j];
                    if ([mealModel.state intValue]==1) {
                        
                        viewController.best_select_index = i*kdateModel.meals.count+j+1;
                        
                        
                    }
                    
                }
            }            
            
            NSMutableArray *order_nosArray ;
            order_nosArray = paseData.orderMsgModel.order_nos;
            //发通知显示查看饭票
            [[NSNotificationCenter defaultCenter] postNotificationName:HomeTicket object:nil userInfo:@{@"order_nos": order_nosArray,@"title":paseData.orderMsgModel.title,@"desc":paseData.orderMsgModel.desc,@"order_desc":paseData.orderMsgModel.order_desc,@"topic_ids":paseData.orderMsgModel.topic_ids}];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
//        [SVProgressHUD showImage:nil status:@"网络连接错误，请检查网络"];
    }];
    
}

@end
