//
//  ApiUserBannerNotify.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiUserBannerNotify.h"


#import "ReqUserBannerNotifyModel.h"
#import "RespuserBannerNotifyModel.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiUserBannerNotify

-(RequestModel *)requestData:(ReqUserBannerNotifyModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
  
    [self.datas setSafeObject:reqModel.banner_id forKey:@"banner_id"];

    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_BANNER_NOTIFY];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserBannerNotifyModel=%@",[self.datas description]);
    return requestModel;
}

-(RespuserBannerNotifyModel *)parseData:(id)resultData
{
    RespuserBannerNotifyModel *respModel=[[RespuserBannerNotifyModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespuserBannerNotifyModel=%@",[resultData description]);
    
    return respModel;
}
@end
