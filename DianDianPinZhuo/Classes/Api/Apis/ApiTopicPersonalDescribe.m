//
//  ApiTopicPersonalDescribe.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiTopicPersonalDescribe.h"

#import "ReqTopicPersonalDescribeModel.h"
#import "RespTopicPersonalDescribeModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "TopicUsersModel.h"
@implementation ApiTopicPersonalDescribe
-(RequestModel *)requestData:(ReqTopicPersonalDescribeModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    [self.datas setSafeObject:reqModel.myself_desc forKey:@"myself_desc"];

    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_PERSONAL_DESCRIBE];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicPersonalDescribeModel=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicPersonalDescribeModel *)parseData:(id)resultData
{
    RespTopicPersonalDescribeModel *respModel=[[RespTopicPersonalDescribeModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];

        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            respModel.ricefriend_desc = [body safeObjectForKey:@"ricefriend_desc"];
            respModel.ricefriend_title = [body safeObjectForKey:@"ricefriend_title"];
        }
    }
    MQQLog(@"RespTopicPersonalDescribeModel=%@",[resultData description]);
    
    return respModel;
}
@end
