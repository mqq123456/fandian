//
//  ApiPaseTopicCommentDelete.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicCommentDelete.h"
#import "ReqTopicCommentDelete.h"
#import "RespTopicCommentDelete.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseTopicCommentDelete
-(RequestModel *)requestData:(ReqTopicCommentDelete *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.comment_id forKey:@"comment_id"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_DELETE_COMMENT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicCommentDelete=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicCommentDelete *)parseData:(id)resultData
{
    RespTopicCommentDelete *respModel=[[RespTopicCommentDelete alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespTopicCommentDelete=%@",[resultData description]);
    
    return respModel;
}


@end
