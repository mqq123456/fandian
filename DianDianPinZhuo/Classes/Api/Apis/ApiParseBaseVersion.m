//
//  ApiParseBaseVersion.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  版本检查接口解析

#import "ApiParseBaseVersion.h"
#import "RequestModel.h"
#import "ReqBaseVersionModel.h"
#import "RespBaseVersionModel.h"
#import "VersionModel.h"
#import "HQConst.h"
@implementation ApiParseBaseVersion

-(RequestModel *)requestData:(ReqBaseVersionModel *)reqModel
{
    [self.datas setSafeObject:reqModel.cver forKey:@"cver"];
    [self.datas setSafeObject:reqModel.platform forKey:@"platform"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_VERSION];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseVersionModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseVersionModel *)parseData:(id)resultData
{
    RespBaseVersionModel *respModel=[[RespBaseVersionModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body =[resultData safeObjectForKey:@"body"];
            
            NSDictionary *version=[body safeObjectForKey:@"version"];
            
            respModel.is_new=[version safeObjectForKey:@"is_new"];
            respModel.title=[version safeObjectForKey:@"title"];
            respModel.tips=[version safeObjectForKey:@"tips"];
            respModel.url=[version safeObjectForKey:@"url"];
            
        }
    }
    MQQLog(@"RespBaseVersionModel=%@",[resultData description]);
    
    return respModel;
}

@end
