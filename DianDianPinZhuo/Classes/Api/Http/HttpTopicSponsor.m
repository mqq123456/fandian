//
//  HttpTopicSponsor.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicSponsor.h"
#import "ApiPaseTopicSponsor.h"
#import "ReqTopicSponsorModel.h"
#import "RespTopicSponsorModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "ApiParseBaseImageUpload.h"
#import "ReqBaseImageUploadModel.h"
#import "RespBaseImageUploadModel.h"
#import "FDSubmitOrderViewController.h"
#import "MerchantModel.h"
#import "SeatsModel.h"
#import "FDLoginViewController.h"
#import "FDMerchantIntroductionViewController.h"
#import "FDMerchantListViewController.h"

@implementation HttpTopicSponsor
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

-(void)sendWithController:(FDMerchantIntroductionViewController *)controller{
    [SVProgressHUD showWithStatus:@"拼桌发起中..."];
    
    if (![controller.img isEqualToString:@""]) {
        
        ReqBaseImageUploadModel *reqModel=[[ReqBaseImageUploadModel alloc]init];
        reqModel.img = controller.img;
        reqModel.kid = [HQDefaultTool getKid];
        ApiParseBaseImageUpload *request=[[ApiParseBaseImageUpload alloc]init];
        RequestModel *requestModel=[request requestData:reqModel];
        [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
            
            RespBaseImageUploadModel *paseData=[request parseData:json];
            if ([paseData.code isEqualToString:@"1"]) {
                
                ReqTopicSponsorModel*reqModel =[[ReqTopicSponsorModel alloc]init];
                
                reqModel.kid = [HQDefaultTool getKid];
                reqModel.content = controller.content;
                if (paseData.pic_id) {
                    reqModel.avator_id = [NSString stringWithFormat:@"%d",paseData.pic_id];
                    
                }
                
                reqModel.meal_id = controller.meal_id;
                reqModel.meal_date = controller.kdate;
                
                reqModel.people = [NSString stringWithFormat:@"%d",[controller.peopleNum intValue]];
                
                reqModel.merchant_id = [NSString stringWithFormat:@"%d",controller.merchant_id];
                
                ApiPaseTopicSponsor *request=[[ApiPaseTopicSponsor alloc]init];
                
                RequestModel *requestModel=[request requestData:reqModel];
                [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
                    [SVProgressHUD dismiss];
                    RespTopicSponsorModel *paseData=[request parseData:json];
                    [SVProgressHUD dismiss];
                    if ([paseData.code isEqualToString:@"1"]) {//加载成功
                        FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
                        submit.merchant_id=[NSString stringWithFormat:@"%d",controller.merchant_id];
                        submit.merchant_name =controller.model.merchant_name;
                        submit.icon =controller.model.icon;
                        submit.kdate =controller.kdate;
                        submit.kdate_desc = controller.kdate_desc;
                        submit.meal_time = controller.meal_time;
                        submit.price = [NSString stringWithFormat:@"%@",controller.model.price];
                        
                        submit.people_desc = controller.people_desc;
                        submit.people = [NSString stringWithFormat:@"%@",controller.peopleNum];
                        submit.meal_id = controller.meal_id;
                        submit.menu_id = controller.menu_id;
                        submit.topic_id = paseData.topic_id;
                        submit.is_bz = @"0";
                        [controller.navigationController pushViewController:submit animated:YES];

                    }else{//加载失败
                        [SVProgressHUD dismiss];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD showImage:nil status:paseData.desc];
                        });
                    }
                    [SVProgressHUD dismiss];
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    MQQLog(@"errer = %@",[error description]);
                    [SVProgressHUD showImage:nil status:@"网络连接失败！"];
                    
                }];
                
                
            }
            
        } failure:^(NSError *error) {
            MQQLog(@"%@",[error description]);
            [SVProgressHUD dismiss];
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = @"拼桌发起失败";
            alertView.delegate = self;
            [alertView addButtonWithTitle:@"确定"];
            [alertView show];
            return;
        }];
        
    }else{
        ReqTopicSponsorModel*reqModel =[[ReqTopicSponsorModel alloc]init];
        
        reqModel.kid = [HQDefaultTool getKid];
        reqModel.content = controller.content;
        reqModel.meal_id = controller.meal_id;
        reqModel.meal_date = controller.kdate;
        reqModel.people = [NSString stringWithFormat:@"%d",[controller.peopleNum intValue]];
        reqModel.merchant_id = [NSString stringWithFormat:@"%d",controller.merchant_id];
        
        ApiPaseTopicSponsor *request=[[ApiPaseTopicSponsor alloc]init];
        
        RequestModel *requestModel=[request requestData:reqModel];
        [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
            [SVProgressHUD dismiss];
            RespTopicSponsorModel *paseData=[request parseData:json];
            [SVProgressHUD dismiss];
            if ([paseData.code isEqualToString:@"1"]) {//加载成功
                FDSubmitOrderViewController *submit = [[FDSubmitOrderViewController alloc] init];
                submit.merchant_id=[NSString stringWithFormat:@"%d",controller.merchant_id];
                submit.merchant_name =controller.model.merchant_name;
                submit.icon =controller.model.icon;
                submit.kdate =controller.kdate;
                submit.kdate_desc = controller.kdate_desc;
                submit.meal_time = controller.meal_time;
                submit.price = [NSString stringWithFormat:@"%@",controller.model.price];
                
                submit.people_desc = controller.people_desc;
                submit.people = [NSString stringWithFormat:@"%@",controller.peopleNum];
                submit.meal_id = controller.meal_id;
                submit.menu_id = controller.menu_id;
                submit.topic_id = paseData.topic_id;
                submit.is_bz = @"0";
                submit.initial_topic = @"1";
                [controller.navigationController pushViewController:submit animated:YES];
                
            }else{//加载失败
                [SVProgressHUD dismiss];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showImage:nil status:paseData.desc];
                });
                
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            MQQLog(@"errer = %@",[error description]);
            [SVProgressHUD showImage:nil status:@"网络连接失败！"];
            
        }];
        
    }
    

}

@end
