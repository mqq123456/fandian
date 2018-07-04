//
//  HttpOrderDiscountInfo.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpOrderDiscountInfo.h"
#import "ApiOrderDiscountInfo.h"
#import "FDSubmitOrderViewController.h"
#import "ReqOrderDiscountInfoModel.h"
#import "RespOrderDiscountInfoModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"

@implementation HttpOrderDiscountInfo
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

- (void)loadOrderDiscountInfoWithMerchant_id:(NSString *)merchant_id meal_id:(NSString *)meal_id meal_date:(NSString *)meal_date menu_id:(NSString *)menu_id people:(NSString *)people topic_id:(NSString *)topic_id is_bz:(NSString *)is_bz controller:(FDSubmitOrderViewController *)controller{
    [controller.activity startAnimating];
    ReqOrderDiscountInfoModel*reqModel =[[ReqOrderDiscountInfoModel alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.merchant_id = merchant_id;
    reqModel.meal_id = meal_id;
    reqModel.meal_date = meal_date;
    reqModel.menu_id = menu_id;
    reqModel.people = people;
    reqModel.is_bz = is_bz;
    if (topic_id) {
    reqModel.topic_id = topic_id;
    }
    
    ApiOrderDiscountInfo *request=[[ApiOrderDiscountInfo alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespOrderDiscountInfoModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            if (paseData.order_hint &&![paseData.order_hint isEqualToString:@""]) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:paseData.order_hint delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            controller.model = paseData;
            controller.integral_point =paseData.integral_point_point;
            controller.activity_name =paseData.activity_name;
            controller.activity_cash =paseData.activity_cash;
            controller.activity_id =paseData.activity_id;
            if ([paseData.integral_point_point intValue]>=500) {
                controller.selectedJF = YES;
            }
            [controller.tableView reloadData];
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
        [controller.activity stopAnimating];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        [controller.activity stopAnimating];
    }];

    
}
@end
