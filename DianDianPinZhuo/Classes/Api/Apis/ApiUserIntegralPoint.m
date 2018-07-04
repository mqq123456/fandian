//
//  ApiUserIntegralPoint.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiUserIntegralPoint.h"
#import "ReqUserIntegralPoint.h"
#import "RespUserIntegralPoint.h"
#import "DetailsDefray.h"
#import "DetailsIncome.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiUserIntegralPoint
-(RequestModel *)requestData:(ReqUserIntegralPoint *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_INTEGRAL_POINT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserIntegralPoint=%@",[self.datas description]);
    return requestModel;
}

-(RespUserIntegralPoint *)parseData:(id)resultData
{
    RespUserIntegralPoint *respModel=[[RespUserIntegralPoint alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];

            //DetailsDefray
            NSMutableArray *details_defray=[body safeObjectForKey:@"details_defray"];
            NSMutableArray *defrayArray = [NSMutableArray array];
            for (NSDictionary *dict in details_defray) {
                DetailsIncome *defrayModel = [[DetailsIncome alloc] init];
                defrayModel.reason = [dict safeObjectForKey:@"reason"];
                defrayModel.merchant_name = [dict safeObjectForKey:@"merchant_name"];
                defrayModel.content = [dict safeObjectForKey:@"content"];
                defrayModel.order_date = [dict safeObjectForKey:@"order_date"];
                defrayModel.point = [dict safeObjectForKey:@"point"];
                [defrayArray addObject:defrayModel];
            }
            
            respModel.defrayArray = defrayArray;
            
            
            
            
            
            
            
            //details_income
            NSMutableArray *details_income=[body safeObjectForKey:@"details_income"];
            NSMutableArray *incomeArray = [NSMutableArray array];
            for (NSDictionary *dict in details_income) {
                DetailsIncome *defrayModel = [[DetailsIncome alloc] init];
                defrayModel.reason = [dict safeObjectForKey:@"reason"];
                defrayModel.merchant_name = [dict safeObjectForKey:@"merchant_name"];
                defrayModel.content = [dict safeObjectForKey:@"content"];
                defrayModel.order_date = [dict safeObjectForKey:@"order_date"];
                defrayModel.point = [dict safeObjectForKey:@"point"];
                
                [incomeArray addObject:defrayModel];
            }
            
            respModel.incomeArray = incomeArray;
            
            
            respModel.point = [body safeObjectForKey:@"point"];
        }
        
    }
    
    MQQLog(@"RespUserIntegralPoint = %@",[resultData description]);
    
    return respModel;
    
}

@end
