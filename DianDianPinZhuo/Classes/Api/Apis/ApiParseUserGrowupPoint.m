//
//  ApiParseUserGrowupPoint.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseUserGrowupPoint.h"
#import "ReqUserGrowupPointModel.h"
#import "RespUserGrowupPointModel.h"
#import "HQConst.h"
#import "RequestModel.h"
#import "GrowUpDetailModel.h"
@implementation ApiParseUserGrowupPoint

-(RequestModel *)requestData:(ReqUserGrowupPointModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_GROWUP_POINT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserGrowupPointModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserGrowupPointModel *)parseData:(id)resultData
{
    RespUserGrowupPointModel *respModel=[[RespUserGrowupPointModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];

        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            respModel.icon=[body safeObjectForKey:@"icon"];
            respModel.point=[body safeObjectForKey:@"point"];
            respModel.hint=[body safeObjectForKey:@"hint"];
            NSMutableArray *details =[NSMutableArray array];
            
            NSMutableArray *items = [body safeObjectForKey:@"details"];
            
            for (NSDictionary *item in items) {
                GrowUpDetailModel *growUpModel = [[GrowUpDetailModel alloc]init];
                growUpModel.merchant_name = [item safeObjectForKey:@"merchant_name"];
                growUpModel.content = [item safeObjectForKey:@"content"];
                growUpModel.income = [item safeObjectForKey:@"income"];
                growUpModel.order_date = [item safeObjectForKey:@"order_date"];
                [details addObject:growUpModel];
                
            }
            
            respModel.details=details;
            
        }
    }
    MQQLog(@"ReqUserGrowupPointModel=%@",[resultData description]);
    
    return respModel;
}


@end
