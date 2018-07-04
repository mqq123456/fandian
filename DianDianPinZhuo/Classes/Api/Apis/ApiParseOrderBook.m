//
//  ApiParseOrderBook.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  预订接口解析

#import "ApiParseOrderBook.h"
#import "RequestModel.h"
#import "ReqOrderBookModel.h"
#import "RespOrderBookModel.h"
#import "OrderModel.h"
#import "HQConst.h"
#import "Order.h"
#import "HQConst.h"
#import "WXApiObject.h"
@implementation ApiParseOrderBook

-(RequestModel *)requestData:(ReqOrderBookModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    [self.datas setSafeObject:reqModel.meal_date forKey:@"meal_date"];
    [self.datas setSafeObject:reqModel.people forKey:@"people"];
    [self.datas setSafeObject:reqModel.menu_id forKey:@"menu_id"];
    [self.datas setSafeObject:reqModel.pay_type forKey:@"pay_type"];
    
    [self.datas setSafeObject:reqModel.integral_point forKey:@"integral_point"];
    
//    [self.datas setSafeObject:reqModel.activity_name forKey:@"activity_name"];
//    
//    [self.datas setSafeObject:reqModel.activity_cash forKey:@"activity_cash"];
    
    [self.datas setSafeObject:reqModel.activity_id forKey:@"activity_id"];
    
    
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    
    [self.datas setSafeObject:reqModel.voucher_id forKey:@"voucher_id"];

    [self.datas setSafeObject:reqModel.initial_topic forKey:@"initial_topic"];
    
    [self.datas setSafeObject:reqModel.order_kind forKey:@"order_kind"];
    
    [self.datas setSafeObject:reqModel.vacancy_id forKey:@"vacancy_id"];
    
    [self.datas setSafeObject:reqModel.table_id forKey:@"table_id"];
    
    [self.datas setSafeObject:reqModel.is_bz forKey:@"is_bz"];
    
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_ORDER_BOOK];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqOrderBookModel=%@",self.datas);
    return requestModel;
}

-(RespOrderBookModel *)parseData:(id)resultData
{
    RespOrderBookModel *respModel=[[RespOrderBookModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            //order
            NSDictionary *orders=[body safeObjectForKey:@"order"];
            OrderModel *item = [[OrderModel alloc] init];
            item.order_id = [[orders safeObjectForKey:@"order_id"]intValue];
            item.order_no = [orders safeObjectForKey:@"order_no"];
            item.table_name = [orders safeObjectForKey:@"table_name"];
            item.order_time = [orders safeObjectForKey:@"order_time"];
            item.order_date = [orders safeObjectForKey:@"order_date"];
            item.meal_time = [orders safeObjectForKey:@"meal_time"];
            item.paid = [orders safeObjectForKey:@"paid"];
            item.payable = [orders safeObjectForKey:@"payable"];
            item.people = [[orders safeObjectForKey:@"people"] intValue];
            item.price = [orders safeObjectForKey:@"price"];
            item.order_stamp = [orders safeObjectForKey:@"order_stamp"];
            item.server_stamp = [orders safeObjectForKey:@"server_stamp"];
            item.use_voucher = [orders safeObjectForKey:@"use_voucher"];
            item.voucher_name = [orders safeObjectForKey:@"voucher_name"];
            item.voucher_cash = [orders safeObjectForKey:@"voucher_cash"];
            item.is_voucher = [orders safeObjectForKey:@"is_voucher"];
            item.is_integral_point = [orders safeObjectForKey:@"is_integral_point"];
            item.integral_point = [orders safeObjectForKey:@"integral_point"];
            
            respModel.order = item;
            respModel.is_order = [body safeObjectForKey:@"is_order"];
            respModel.ca_se = [body safeObjectForKey:@"desc"];
            
 
            NSDictionary *alipayDict = [body safeObjectForKey:@"alipay_data"];
            if (alipayDict.count>0) {
                Order *order = [[Order alloc] init];
                order.partner = [alipayDict safeObjectForKey:@"partner"];
                order.seller = [alipayDict safeObjectForKey:@"seller"];
                order.tradeNO = [alipayDict safeObjectForKey:@"tradeNO"];
                order.productName = [alipayDict safeObjectForKey:@"productName"];
                order.productDescription = [alipayDict safeObjectForKey:@"productDescription"];
                order.amount = [alipayDict safeObjectForKey:@"amount"];
                order.notifyURL = [alipayDict safeObjectForKey:@"notifyURL"];
                order.service = [alipayDict safeObjectForKey:@"service"];
                order.paymentType = [alipayDict safeObjectForKey:@"paymentType"];
                order.inputCharset = [alipayDict safeObjectForKey:@"inputCharset"];
                order.itBPay = [alipayDict safeObjectForKey:@"itBPay"];
                order.showUrl = [alipayDict safeObjectForKey:@"showUrl"];
                order.privateKey = [alipayDict safeObjectForKey:@"privateKey"];
                
                respModel.alOrder= order;
                
            }
            NSDictionary *wxDict = [body safeObjectForKey:@"wxpay_data"];
            if (wxDict.count>0) {
                PayReq *wxOrder = [[PayReq alloc] init];
                wxOrder.openID = [wxDict safeObjectForKey:@"appid"];
                wxOrder.partnerId = [wxDict safeObjectForKey:@"partnerid"];
                wxOrder.prepayId = [wxDict safeObjectForKey:@"prepayid"];
                wxOrder.nonceStr = [wxDict safeObjectForKey:@"noncestr"];
                wxOrder.timeStamp = [[wxDict safeObjectForKey:@"timestamp"]unsignedIntValue];
                wxOrder.package = [wxDict safeObjectForKey:@"package"];
                wxOrder.sign = [wxDict safeObjectForKey:@"sign"];
                respModel.wxOrder = wxOrder;
            }
        }
         
    }
    
    MQQLog(@"RespOrderBookModel =%@",[resultData description]);
    
    return respModel;

}

@end
