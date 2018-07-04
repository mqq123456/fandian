//
//  ApiParseBaseGetCode.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  获取手机验证码接口解析

#import "ApiParseBaseGetCode.h"
#import "RequestModel.h"
#import "ReqBaseGetCodeModel.h"
#import "RespBaseGetCodeModel.h"
#import "HQConst.h"
@implementation ApiParseBaseGetCode

-(RequestModel *)requestData:(ReqBaseGetCodeModel *)reqModel
{
    [self.datas setSafeObject:reqModel.phone forKey:@"phone"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_GET_CODE];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseGetCodeModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseGetCodeModel *)parseData:(id)resultData
{
    RespBaseGetCodeModel *respModel=[[RespBaseGetCodeModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            respModel.vcode=[body safeObjectForKey:@"vcode"];
        }
    }
    MQQLog(@"RespBaseGetCodeModel=%@",[resultData description]);
    
    return respModel;
}
@end
