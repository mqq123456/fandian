//
//  ApiParseUserVoucherList.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  优惠券列表接口解析

#import "ApiParseUserVoucherList.h"
#import "RequestModel.h"
#import "ReqUserVoucherListModel.h"
#import "RespUserVoucherListModel.h"
#import "VoucherModel.h"
#import "HQConst.h"
@implementation ApiParseUserVoucherList

-(RequestModel *)requestData:(ReqUserVoucherListModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }
    
    [self.datas setSafeObject:reqModel.people forKey:@"people"];

    [self.datas setSafeObject:reqModel.order_no forKey:@"order_no"];
    
    
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    
    
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];

    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_VOUCHER_LIST];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserVoucherListModel =%@",[self.datas description]);
    return requestModel;
}

-(RespUserVoucherListModel *)parseData:(id)resultData
{
    RespUserVoucherListModel *respModel=[[RespUserVoucherListModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSMutableArray *mutItems=[NSMutableArray array];
            NSDictionary *items=[body safeObjectForKey:@"vouchers"];
            for (NSDictionary *item in items) {
                VoucherModel *voucherModel=[[VoucherModel alloc]init];
                voucherModel.voucher_id=[[item safeObjectForKey:@"voucher_id"] intValue];
                voucherModel.voucher_name=[item safeObjectForKey:@"voucher_name"];
                voucherModel.voucher_source=[item safeObjectForKey:@"voucher_source"];
                voucherModel.cash=[item safeObjectForKey:@"cash"];
                voucherModel.expire_time = [item safeObjectForKey:@"expire_time"];
                voucherModel.img = [item safeObjectForKey:@"img"];
                voucherModel.people = [item safeObjectForKey:@"people"];
                voucherModel.limits = [item safeObjectForKey:@"limits"];
                voucherModel.first_use = [item safeObjectForKey:@"first_use"];
                voucherModel.voucher_type = [item safeObjectForKey:@"voucher_type"];
                voucherModel.discount = [item safeObjectForKey:@"discount"];
                voucherModel.most_discount_cash = [item safeObjectForKey:@"most_discount_cash"];
                [mutItems addObject:voucherModel];
                
            }
            respModel.vouchers=mutItems;
        }
    }
    MQQLog(@"RespUserVoucherListModel =%@",[resultData description]);
    
    return respModel;
}
@end
