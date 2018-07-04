//
//  ApiOrderSelfDesc.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiOrderSelfDesc.h"

#import "ReqOrderSelfDescModel.h"
#import "RespTopicPersonalDescribeModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "TopicUsersModel.h"
@implementation ApiOrderSelfDesc
-(RequestModel *)requestData:(ReqOrderSelfDescModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.table_id forKey:@"table_id"];
    [self.datas setSafeObject:reqModel.self_desc forKey:@"self_desc"];
    [self.datas setSafeObject:reqModel.order_no forKey:@"order_no"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_ORDER_SELF_DESC];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqOrderSelfDescModel=%@",[self.datas description]);
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

        }
    }
    MQQLog(@"RespOrderSelfDescModel=%@",[resultData description]);
    
    return respModel;
}
@end
