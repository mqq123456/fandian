
//
//  ApiParseBaseAppkey.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  加密串请求接口解析

#import "ApiParseBaseAppkey.h"
#import "RequestModel.h"
#import "ReqBaseAppkeyModel.h"
#import "RespBaseAppkeyModel.h"
#import "HQConst.h"

@implementation ApiParseBaseAppkey
-(RequestModel *)requestData:(ReqBaseAppkeyModel *)reqModel
{
    [self.datas setSafeObject:reqModel.uuid forKey:@"uuid"];
    [self.datas setSafeObject:reqModel.plat forKey:@"plat"];
    [self.datas setSafeObject:reqModel.ua forKey:@"ua"];
    [self.datas setSafeObject:reqModel.brand forKey:@"brand"];
    [self.datas setSafeObject:reqModel.imei forKey:@"imei"];
    [self.datas setSafeObject:reqModel.fbl forKey:@"fbl"];
    [self.datas setSafeObject:reqModel.ver forKey:@"ver"];
    [self.datas setSafeObject:reqModel.cver forKey:@"cver"];
    [self.datas setSafeObject:reqModel.channel forKey:@"channel"];
    [self.datas setSafeObject:reqModel.dver forKey:@"dver"];
    
    //此接口不需要data和加密
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_APPKEY];;
    requestModel.parameters=self.datas;
    
    MQQLog(@"ReqBaseAppkeyModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseAppkeyModel *)parseData:(id)resultData
{
    RespBaseAppkeyModel *respModel=[[RespBaseAppkeyModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            respModel.key=[body safeObjectForKey:@"key"];
            
        }
    }
    MQQLog(@"RespBaseAppkeyModel=%@",[resultData description]);
    
    return respModel;
}


@end
