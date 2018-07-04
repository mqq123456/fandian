    //
//  ApiOrderDiscountInfo.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiOrderDiscountInfo.h"
#import "ReqOrderDiscountInfoModel.h"
#import "RespOrderDiscountInfoModel.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiOrderDiscountInfo
-(RequestModel *)requestData:(ReqOrderDiscountInfoModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    [self.datas setSafeObject:reqModel.meal_date forKey:@"meal_date"];
 
    [self.datas setSafeObject:reqModel.menu_id forKey:@"menu_id"];
    
    
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    
    [self.datas setSafeObject:reqModel.people forKey:@"people"];
    
    
    [self.datas setSafeObject:reqModel.order_kind forKey:@"order_kind"];
    
    [self.datas setSafeObject:reqModel.is_bz forKey:@"is_bz"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_ORDER_DISCOUNT_INFO];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqOrderDiscountInfoModel=%@",[self.datas description]);
    return requestModel;
}

-(RespOrderDiscountInfoModel *)parseData:(id)resultData
{
    RespOrderDiscountInfoModel *respModel=[[RespOrderDiscountInfoModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSDictionary *voucher=[body safeObjectForKey:@"voucher"];
            respModel.voucher_id = [voucher safeObjectForKey:@"voucher_id"];
            respModel.voucher_cash = [voucher safeObjectForKey:@"cash"];
            respModel.discount = [voucher safeObjectForKey:@"discount"];
            respModel.voucher_type = [voucher safeObjectForKey:@"voucher_type"];
            respModel.most_discount_cash = [voucher safeObjectForKey:@"most_discount_cash"];
            
            NSDictionary *integral_point=[body safeObjectForKey:@"integral_point"];
            
            respModel.integral_point_deduction_cash =[integral_point safeObjectForKey:@"deduction_cash"];
            respModel.integral_point_point =[integral_point safeObjectForKey:@"point"];
            respModel.integral_point_hint_a =[integral_point safeObjectForKey:@"hint_a"];
            respModel.integral_point_hint_b =[integral_point safeObjectForKey:@"hint_b"];
            respModel.integral_point_deduction_point =[integral_point safeObjectForKey:@"deduction_point"];
            respModel.integral_point_deduction_cash =[integral_point safeObjectForKey:@"deduction_cash"];
    
            
            NSDictionary *activity=[body safeObjectForKey:@"activity"];
            respModel.activity_cash =[activity safeObjectForKey:@"cash"];
            respModel.activity_name =[activity safeObjectForKey:@"name"];
            respModel.activity_id =[activity safeObjectForKey:@"id"];
            
            respModel.paid =[body safeObjectForKey:@"paid"];
            respModel.order_hint = [body safeObjectForKey:@"order_hint"];

        }
    }
    MQQLog(@"RespOrderDiscountInfoModel=%@",[resultData description]);
    
    return respModel;
}
@end
