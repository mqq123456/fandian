//
//  ApiParseTopicInit.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseTopicInit.h"

#import "ReqTopicInit.h"
#import "RespTopicInit.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseTopicInit
-(RequestModel *)requestData:(ReqTopicInit *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_INIT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicInit=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicInit *)parseData:(id)resultData
{
    RespTopicInit *respModel=[[RespTopicInit alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            respModel.is_today_finished = [body safeObjectForKey:@"is_today_finished"];
            respModel.today_finished_hint = [body safeObjectForKey:@"today_finished_hint"];
            respModel.default_topic_title = [body safeObjectForKey:@"default_topic_title"];
            
        }
    }
    MQQLog(@"RespTopicInit=%@",[resultData description]);
    
    return respModel;
}

@end
