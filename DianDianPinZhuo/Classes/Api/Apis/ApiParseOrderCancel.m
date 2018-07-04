//
//  ApiParseOrderCancel.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  取消订单接口解析

#import "ApiParseOrderCancel.h"
#import "RequestModel.h"
#import "ReqOrderCancelModel.h"
#import "RespOrderCancelModel.h"
#import "HQConst.h"
@implementation ApiParseOrderCancel

-(RequestModel *)requestData:(ReqOrderCancelModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];

    [self.datas setSafeObject:reqModel.order_no forKey:@"order_no"];
        
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_ORDER_CANCEL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqOrderCancelModel =%@",[self.datas description]);
    return requestModel;
}

-(RespOrderCancelModel *)parseData:(id)resultData
{
    RespOrderCancelModel *respModel=[[RespOrderCancelModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
    }
    MQQLog(@"RespOrderCancelModel =%@",[resultData description]);
    
    return respModel;
}

@end
