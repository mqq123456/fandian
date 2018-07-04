//
//  ApiPaseTopicJoin.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicJoin.h"


#import "ReqTopicJoinModel.h"
#import "RespTopicJoinModel.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseTopicJoin
-(RequestModel *)requestData:(ReqTopicJoinModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    [self.datas setSafeObject:reqModel.people forKey:@"people"];

    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_JOIN];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicJoinModel=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicJoinModel *)parseData:(id)resultData
{
    RespTopicJoinModel *respModel=[[RespTopicJoinModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            respModel.topic_people = [body safeObjectForKey:@"topic_people"];
        }
    }
    MQQLog(@"RespTopicJoinModel=%@",[resultData description]);
    
    return respModel;
}
@end
