//
//  ApiParseUserLogout.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseUserLogout.h"
#import "ReqUserLogoutModel.h"
#import "RespUserLogoutModel.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseUserLogout

-(RequestModel *)requestData:(ReqUserLogoutModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_LOGOUT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserLogoutModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserLogoutModel *)parseData:(id)resultData
{
    RespUserLogoutModel *respModel=[[RespUserLogoutModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
  
        }
    }
    MQQLog(@"RespUserLogoutModel=%@",[resultData description]);
    
    return respModel;
}


@end
