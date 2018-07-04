//
//  ApiParseImGroupExit.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/20.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseImGroupExit.h"
#import "RequestModel.h"
#import "ReqImGroupExitModel.h"
#import "RespImGroupExitModel.h"
#import "HQConst.h"
@implementation ApiParseImGroupExit
-(RequestModel *)requestData:(ReqImGroupExitModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.group_id forKey:@"group_id"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_GROUP_EXIT];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImGroupExitModel =%@",[self.datas description]);
    return requestModel;
}

-(RespImGroupExitModel *)parseData:(id)resultData
{
    RespImGroupExitModel *respModel=[[RespImGroupExitModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespImGroupExitModel =%@",[resultData description]);
    
    return respModel;
}
@end


