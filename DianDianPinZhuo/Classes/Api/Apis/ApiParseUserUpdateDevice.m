//
//  ApiParseUserUpdateDevice.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseUserUpdateDevice.h"
#import "ReqUserUpdateDevice.h"
#import "RespUserUpdateDevice.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"


@implementation ApiParseUserUpdateDevice
-(RequestModel *)requestData:(ReqUserUpdateDevice *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.device_token forKey:@"device_token"];
    [self.datas setSafeObject:reqModel.cver forKey:@"cver"];
    [self.datas setSafeObject:reqModel.imei forKey:@"imei"];
    [self.datas setSafeObject:reqModel.platform forKey:@"platform"];
    [self.datas setSafeObject:reqModel.channel forKey:@"channel"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_UPDATE_DEVICE];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserUpdateDevice=%@",[self.datas description]);
    return requestModel;
}

-(RespUserUpdateDevice *)parseData:(id)resultData
{
    RespUserUpdateDevice *respModel=[[RespUserUpdateDevice alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespUserUpdateDevice=%@",[resultData description]);
    
    return respModel;
}
@end
