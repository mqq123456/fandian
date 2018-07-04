//
//  ApiPaseTopicSponsor.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicSponsor.h"
#import "ReqTopicSponsorModel.h"
#import "RespTopicSponsorModel.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiPaseTopicSponsor
-(RequestModel *)requestData:(ReqTopicSponsorModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.content forKey:@"content"];
    
    [self.datas setSafeObject:reqModel.img forKey:@"img"];
    
    [self.datas setSafeObject:reqModel.is_eat forKey:@"is_eat"];
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    [self.datas setSafeObject:reqModel.meal_date forKey:@"meal_date"];
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    [self.datas setSafeObject:reqModel.people forKey:@"people"];
    
    [self.datas setSafeObject:reqModel.myself_desc forKey:@"myself_desc"];
    
    [self.datas setSafeObject:reqModel.avator_id forKey:@"avator_id"];

    [self.datas setSafeObject:reqModel.class_id forKey:@"class_id"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_SPONSOR];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicSponsorModel=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicSponsorModel *)parseData:(id)resultData
{
    RespTopicSponsorModel *respModel=[[RespTopicSponsorModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            respModel.topic_id = [body safeObjectForKey:@"topic_id"];
            
        }
    }
    MQQLog(@"RespTopicSponsorModel=%@",[resultData description]);
    
    return respModel;
}
@end
