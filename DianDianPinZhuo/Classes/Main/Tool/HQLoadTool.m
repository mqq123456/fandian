//
//  HQLoadTool.m
//  normandy
//
//  Created by rongdong on 15/6/13.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "HQLoadTool.h"
#import "HQMD5Tool.h"
#import "HQHttpTool.h"
#import "HQConst.h"
#import "AFNetworking.h"
#import "RequestModel.h"

#import "ApiParseBaseAppkey.h"
#import "ReqBaseAppkeyModel.h"
#import "RespBaseAppkeyModel.h"

#import "ApiParseBaseLoading.h"
#import "ReqBaseLoadingModel.h"
#import "RespBaseLoadingModel.h"

#import "ApiParseBaseVersion.h"
#import "ReqBaseVersionModel.h"
#import "RespBaseVersionModel.h"

#import "HQDefaultTool.h"
#import "IndustriesModel.h"
#import "AdsModel.h"
#import "FDUUidManager.h"

@implementation HQLoadTool

+(void)appkey
{
    ReqBaseAppkeyModel *reqModel=[[ReqBaseAppkeyModel alloc]init];
    reqModel.uuid=[HQDefaultTool getUuid];
    reqModel.plat=APP_PLAT;
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
    
    [[UIDevice currentDevice]identifierForVendor];
    ApiParseBaseAppkey *request=[[ApiParseBaseAppkey alloc]init];
    MQQLog(@"%@",reqModel);
    RequestModel *requestModel=[request requestData:reqModel];

    [self post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespBaseAppkeyModel *paseData=[request parseData:json];
        MQQLog(@"%@",[json description]);
        if ([paseData.code isEqualToString:@"1"]) {
            NSString *str;
            if (paseData.key.length>=16) {
                str = [paseData.key substringToIndex:16];
                //MQQLog(@"str=%@",str);
            }else{
                str = paseData.key;
                //MQQLog(@"str=%@",str);
            }
            [HQDefaultTool setKey:str];
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
    }];

}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loading
{
    //NSString *uuid=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    ReqBaseLoadingModel *reqModel=[[ReqBaseLoadingModel alloc]init];
    reqModel.platform=APP_PLAT;
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
//    reqModel.device_token = [HQDefaultTool getDevice_token];
    reqModel.device_token = [HQDefaultTool getRegistrationID];
    reqModel.kid = [HQDefaultTool getKid];
    
    [[UIDevice currentDevice]identifierForVendor];
    ApiParseBaseLoading *request=[[ApiParseBaseLoading alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespBaseLoadingModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [HQDefaultTool setDown_url:paseData.down_url];
            [HQDefaultTool setInvite_url:paseData.invite_url];
            [HQDefaultTool setService:paseData.service];
            [HQDefaultTool setAgreement_url:paseData.agreement_url];
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (IndustriesModel *model  in paseData.industries) {
                [array addObject:model.industry_name];
            }
            [HQDefaultTool setIndusties:array];

        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
    }];
}
+(void)version
{
    ReqBaseVersionModel *reqModel=[[ReqBaseVersionModel alloc]init];
    reqModel.platform=APP_PLAT;
    reqModel.cver=APP_VERSION;

    ApiParseBaseVersion *request=[[ApiParseBaseVersion alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {

        RespBaseVersionModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if ([paseData.is_new intValue]==1) {
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = paseData.tips;
                alertView.title = paseData.title;
                alertView.delegate = self;
                [alertView addButtonWithTitle:@"取消"];
                [alertView addButtonWithTitle:@"确定"];
                [alertView show];
                return;
            }
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[HQDefaultTool getDown_url]]];
    }
}



@end
