//
//  ApiPaseImFriendAdd.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseImFriendAdd.h"

#import "ReqImFriendAdd.h"
#import "RespImFriendAdd.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseImFriendAdd

-(RequestModel *)requestData:(ReqImFriendAdd *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.friend_kid forKey:@"friend_kid"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_FRIEND_ADD];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImFriendAdd=%@",[self.datas description]);
    return requestModel;
}

-(RespImFriendAdd *)parseData:(id)resultData
{
    RespImFriendAdd *respModel=[[RespImFriendAdd alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespImFriendAdd=%@",[resultData description]);
    
    return respModel;
}

@end
