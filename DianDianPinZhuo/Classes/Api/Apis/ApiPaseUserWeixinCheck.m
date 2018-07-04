//
//  ApiPaseUserWeixinCheck.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseUserWeixinCheck.h"
#import "ReqUserWeixinCheck.h"
#import "RespUserWeixinCheck.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiPaseUserWeixinCheck
-(RequestModel *)requestData:(ReqUserWeixinCheck *)reqModel
{
    [self.datas setSafeObject:reqModel.weixin_account forKey:@"weixin_account"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_WEIXIN_CHECK];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserWeixinCheck=%@",[self.datas description]);
    return requestModel;
}

-(RespUserWeixinCheck *)parseData:(id)resultData
{
    RespUserWeixinCheck *respModel=[[RespUserWeixinCheck alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        NSDictionary *body=[resultData safeObjectForKey:@"body"];
        if ([respModel.code isEqualToString:@"1"]) {
            respModel.kid = body[@"kid"];
        }
    }
    MQQLog(@"RespUserWeixinCheck=%@",[resultData description]);
    
    return respModel;
}

@end


