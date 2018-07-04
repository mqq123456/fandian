//
//  ApiParseImUserGroupList.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseImUserGroupList.h"
#import "ReqImUserGroupList.h"
#import "RespImUserGroupList.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseImUserGroupList
-(RequestModel *)requestData:(ReqImUserGroupList *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_USER_GROUP_LIST];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImUserGroupList=%@",[self.datas description]);
    return requestModel;
}

-(RespImUserGroupList *)parseData:(id)resultData
{
    RespImUserGroupList *respModel=[[RespImUserGroupList alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            respModel.groups = [body safeObjectForKey:@"groups"];
        }
    }
    MQQLog(@"RespImUserGroupList=%@",[resultData description]);
    
    return respModel;
}
@end
