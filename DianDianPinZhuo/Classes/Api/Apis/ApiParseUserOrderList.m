//
//  ApiParseUserOrderList.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌记录列表接口解析

#import "ApiParseUserOrderList.h"
#import "RequestModel.h"
#import "ReqUserOrderListModel.h"
#import "RespUserOrderListModel.h"
#import "OrderModel.h"
#import "TablesModel.h"
#import "HQConst.h"
@implementation ApiParseUserOrderList

-(RequestModel *)requestData:(ReqUserOrderListModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }
    if (reqModel.state) {
        [self.datas setSafeObject:reqModel.state forKey:@"state"];
    }
    
    
    
  
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_ORDER_LIST];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserOrderListModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserOrderListModel *)parseData:(id)resultData
{
    RespUserOrderListModel *respModel=[[RespUserOrderListModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSMutableArray *mutItems=[NSMutableArray array];
            NSDictionary *items=[body safeObjectForKey:@"orders"];
            for (NSDictionary *item in items) {
                OrderModel *orderModel=[[OrderModel alloc]init];
                orderModel.order_id=[[item safeObjectForKey:@"order_id"] intValue];
                orderModel.icon=[item safeObjectForKey:@"icon"];
                orderModel.validation=[item safeObjectForKey:@"validation"];
                orderModel.payable=[item safeObjectForKey:@"payable"];
                orderModel.paid=[item safeObjectForKey:@"paid"];
                orderModel.order_no=[item safeObjectForKey:@"order_no"];
                orderModel.order_date=[item safeObjectForKey:@"order_date"];
                orderModel.meal_time=[item safeObjectForKey:@"meal_time"];
                orderModel.people = [[item safeObjectForKey:@"people"]intValue];
                orderModel.price = [item safeObjectForKey:@"price"];
                orderModel.state=[[item safeObjectForKey:@"state"] intValue];
                orderModel.topic_id=[item safeObjectForKey:@"topic_id"];
                orderModel.merchant_name=[item safeObjectForKey:@"merchant_name"];
                 orderModel.state_desc=[item safeObjectForKey:@"state_desc"];
                orderModel.merchant_id=[[item safeObjectForKey:@"merchant_id"] intValue];
                orderModel.address=[item safeObjectForKey:@"address"];
                orderModel.phone=[item safeObjectForKey:@"phone"];
                orderModel.order_time=[item safeObjectForKey:@"order_time"];
                orderModel.give_url=[item safeObjectForKey:@"give_url"];
                orderModel.is_use=[[item safeObjectForKey:@"is_use"] intValue];
                orderModel.is_comment=[[item safeObjectForKey:@"is_comment"] intValue];
                orderModel.is_unsubscribe=[[item safeObjectForKey:@"is_unsubscribe"] intValue];
                
                
                NSMutableArray *tablesItems=[NSMutableArray array];
                NSDictionary *tables=[item safeObjectForKey:@"tables"];
                for (TablesModel *tableModel in tables) {
                    tableModel.table_no = [tables safeObjectForKey:@"table_no"];
                    tableModel.table_desc = [tables safeObjectForKey:@"table_desc"];
                    tableModel.table_people = [tables safeObjectForKey:@"table_people"];
                    
                    [tablesItems addObject:tableModel];
                }
                orderModel.tables = tablesItems;
                orderModel.lat=[item safeObjectForKey:@"lat"];
                orderModel.lng=[item safeObjectForKey:@"lng"];
                orderModel.bag_url=[item safeObjectForKey:@"bag_url"];
                
                orderModel.meal_desc=[item safeObjectForKey:@"meal_desc"];
                [mutItems addObject:orderModel];
            }
            respModel.orders=mutItems;
        }
    }
    MQQLog(@"RespUserOrderListModel=%@",[resultData description]);
    
    return respModel;
}
@end
