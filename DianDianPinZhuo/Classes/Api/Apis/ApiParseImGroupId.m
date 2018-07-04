//
//  ApiParseImGroupId.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseImGroupId.h"
#import "ReqImGroupIdModel.h"
#import "RespImGroupIdModel.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiParseImGroupId
-(RequestModel *)requestData:(ReqImGroupIdModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.order_no forKey:@"order_no"];
    [self.datas setSafeObject:reqModel.table_id forKey:@"table_id"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_GROUP_ID];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImGroupIdModel=%@",[self.datas description]);
    return requestModel;
}

-(RespImGroupIdModel *)parseData:(id)resultData
{
    RespImGroupIdModel *respModel=[[RespImGroupIdModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            respModel.group_id = [body safeObjectForKey:@"group_id"];
            respModel.group_name = [body safeObjectForKey:@"group_name"];
        }
    }
    MQQLog(@"RespImGroupIdModel=%@",[resultData description]);
    
    return respModel;
}
@end
