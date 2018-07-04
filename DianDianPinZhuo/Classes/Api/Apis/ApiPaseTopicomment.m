//
//  ApiPaseTopicomment.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicomment.h"
#import "ReqTopicComment.h"
#import "RespTopicComment.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseTopicomment
-(RequestModel *)requestData:(ReqTopicComment *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];

    [self.datas setSafeObject:reqModel.reply_kid forKey:@"reply_kid"];
    
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    [self.datas setSafeObject:reqModel.content forKey:@"content"];

    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_COMMENT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicComment=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicComment *)parseData:(id)resultData
{
    RespTopicComment *respModel=[[RespTopicComment alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespTopicComment=%@",[resultData description]);
    
    return respModel;
}


@end
