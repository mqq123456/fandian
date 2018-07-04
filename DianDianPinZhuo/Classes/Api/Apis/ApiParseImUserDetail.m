//
//  ApiParseImUserDetail.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseImUserDetail.h"
#import "ReqImUserDetailModel.h"
#import "RespImUserDetailModel.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseImUserDetail
-(RequestModel *)requestData:(ReqImUserDetailModel *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_USER_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImUserDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespImUserDetailModel *)parseData:(id)resultData
{
    RespImUserDetailModel *respModel=[[RespImUserDetailModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
    
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            respModel.nick_name = [body safeObjectForKey:@"nick_name"];

            respModel.icon = [body safeObjectForKey:@"icon"];
            respModel.kid = [body safeObjectForKey:@"kid"];
            
        }
    }
    MQQLog(@"RespImUserDetailModel=%@",[resultData description]);
    
    return respModel;
}

@end
