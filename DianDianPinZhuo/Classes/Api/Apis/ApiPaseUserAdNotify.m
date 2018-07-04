//
//  ApiPaseUserAdNotify.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseUserAdNotify.h"

#import "ReqUserAdNotifyModel.h"
#import "RespUserAdNotifyModel.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseUserAdNotify

-(RequestModel *)requestData:(ReqUserAdNotifyModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];

    [self.datas setSafeObject:reqModel.ad_id forKey:@"ad_id"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_AD_NOTIFY];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserAdNotifyModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserAdNotifyModel *)parseData:(id)resultData
{
    RespUserAdNotifyModel *respModel=[[RespUserAdNotifyModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespUserAdNotifyModel=%@",[resultData description]);
    
    return respModel;
}

@end
