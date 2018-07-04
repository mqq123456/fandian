//
//  ApiPaseUserMessageDel.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiPaseUserMessageDel.h"
#import "RequestModel.h"
#import "ReqUserMessageDelModel.h"
#import "RespUserMessageDelModel.h"
#import "HQConst.h"

@implementation ApiPaseUserMessageDel

-(RequestModel *)requestData:(ReqUserMessageDelModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
 
    [self.datas setSafeObject:reqModel.ids forKey:@"ids"];
    
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_MESSAGE_DEL];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserMessageDelModel =%@",[self.datas description]);
    return requestModel;
}

-(RespUserMessageDelModel *)parseData:(id)resultData
{
    RespUserMessageDelModel *respModel=[[RespUserMessageDelModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespUserMessageDelModel =%@",[resultData description]);
    
    return respModel;
}
@end
