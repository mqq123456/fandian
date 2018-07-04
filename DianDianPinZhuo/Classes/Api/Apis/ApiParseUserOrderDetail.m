//
//  ApiParseUserOrderDetail.m
//  DianDianPinZhuo
//
//  Created by user on 15/9/1.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "ApiParseUserOrderDetail.h"

#import "RequestModel.h"
#import "ReqUserOrderDetailModel.h"
#import "RespUserOrderDetailModel.h"
#import "OrderModel.h"
#import "HQConst.h"
#import "TablesModel.h"
#import "membersModel.h"
#import "FDGroupDetailTool.h"
@implementation ApiParseUserOrderDetail

-(RequestModel *)requestData:(ReqUserOrderDetailModel *)reqModel
{
    [self.datas setObject:reqModel.kid forKey:@"kid"];
    if (!reqModel.order_no) {
        
    }else{
        
        [self.datas setObject:reqModel.order_no forKey:@"order_no"];
        
    }
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString    = [dataWrite stringWithFragment:self.datas];
    dataString              = [dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData        = [[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.url           = [NSString stringWithFormat:@"%@%@",self.url,API_USER_ORDER_DETAIL];
    requestModel.parameters    = self.params;

    MQQLog(@"ReqUserOrderDetailModel =%@",[self.datas description]);
    return requestModel;
}

-(RespUserOrderDetailModel *)parseData:(id)resultData
{
    RespUserOrderDetailModel *respModel = [[RespUserOrderDetailModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head = [resultData objectForKey:@"head"];
        respModel.code = [NSString stringWithFormat:@"%@",[head objectForKey:@"code"]];
        respModel.desc = [head objectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *item = [resultData objectForKey:@"body"];
            
            OrderModel *orderModel    = [[OrderModel alloc] init];
            orderModel.order_id       = [[item objectForKey:@"order_id"] intValue];
            orderModel.topic_id       = [item objectForKey:@"topic_id"];
            orderModel.icon           = [item objectForKey:@"icon"];
            orderModel.validation     = [item objectForKey:@"validation"];
            orderModel.payable        = [item objectForKey:@"payable"];
            orderModel.paid           = [item objectForKey:@"paid"];
            orderModel.order_no       = [item objectForKey:@"order_no"];
            orderModel.table_id       = [item objectForKey:@"table_id"];
            orderModel.order_date     = [item objectForKey:@"order_date"];
            orderModel.order_date_std = [item objectForKey:@"order_date_std"];
            orderModel.meal_time      = [item objectForKey:@"meal_time"];
            orderModel.meal_id        = [item objectForKey:@"meal_id"];
            orderModel.people         = [[item objectForKey:@"people"]intValue];
            orderModel.price          = [item objectForKey:@"price"];
            orderModel.state          = [[item objectForKey:@"state"] intValue];
            orderModel.merchant_name  = [item objectForKey:@"merchant_name"];
            orderModel.state_desc     = [item objectForKey:@"state_desc"];
            orderModel.merchant_id    = [[item objectForKey:@"merchant_id"] intValue];
            orderModel.address        = [item objectForKey:@"address"];
            orderModel.phone          = [item objectForKey:@"phone"];
            orderModel.give_url       = [item objectForKey:@"give_url"];
            orderModel.is_use         = [[item objectForKey:@"is_use"] intValue];
            orderModel.is_comment     = [[item objectForKey:@"is_comment"] intValue];
            orderModel.is_unsubscribe = [[item objectForKey:@"is_unsubscribe"] intValue];
            orderModel.order_time     = [item objectForKey:@"order_time"];
            orderModel.voucher_cash   = [item objectForKey:@"voucher_cash"];
            orderModel.order_stamp    = [item objectForKey:@"order_stamp"];
            orderModel.server_stamp   = [item objectForKey:@"server_stamp"];
            orderModel.order_num      = [item objectForKey:@"order_num"];
            orderModel.star                  = [item objectForKey:@"star"];
            orderModel.table_name            = [item objectForKey:@"table_name"];
            orderModel.bag_url               = [item objectForKey:@"bag_url"];
            orderModel.bag_title = [item safeObjectForKey:@"bag_title"];
            orderModel.bag_content = [item safeObjectForKey:@"bag_content"];

            orderModel.table_alloc_left_time = [item objectForKey:@"table_alloc_left_time"];
            orderModel.table_alloc_time      = [item objectForKey:@"table_alloc_time"];

            ///2.1添加
            orderModel.order_kind                = [item objectForKey:@"order_kind"];
            orderModel.eggshell_empty_seat       = [item objectForKey:@"eggshell_empty_seat"];
            orderModel.eggshell_window_content       = [item objectForKey:@"eggshell_window_content"];
            orderModel.weixin_empty_seat_title   = [item objectForKey:@"weixin_empty_seat_title"];
            orderModel.weixin_empty_seat_content = [item objectForKey:@"weixin_empty_seat_content"];
            orderModel.weixin_empty_seat_url     = [item objectForKey:@"weixin_empty_seat_url"];
            orderModel.is_bz = [item objectForKey:@"is_bz"];
            orderModel.meal_desc = [item objectForKey:@"meal_desc"];

            orderModel.group_share_title   = [item objectForKey:@"group_share_title"];
            orderModel.group_share_hint = [item objectForKey:@"group_share_hint"];
            orderModel.weixin_share_title     = [item objectForKey:@"weixin_share_title"];
            orderModel.weixin_share_content = [item objectForKey:@"weixin_share_content"];
            orderModel.weixin_share_url = [item objectForKey:@"weixin_share_url"];

            orderModel.weixin_topic_title = [item safeObjectForKey:@"weixin_topic_title"];
            orderModel.weixin_topic_content = [item safeObjectForKey:@"weixin_topic_content"];
            orderModel.weixin_topic_url = [item safeObjectForKey:@"weixin_topic_url"];
            orderModel.scan_code_hint = [item safeObjectForKey:@"scan_code_hint"];
            
            //tables
            NSMutableArray *tableItems     = [NSMutableArray array];
            NSDictionary *tables           = [item objectForKey:@"tables"];
            for (NSDictionary *tableDict in tables) {
            TablesModel *tablesModel       = [[TablesModel alloc]init];
            tablesModel.table_no           = [tableDict objectForKey:@"table_no"];
            tablesModel.table_desc         = [tableDict objectForKey:@"table_desc"];
            tablesModel.table_people       = [tableDict objectForKey:@"table_people"];
            tablesModel.total_order_people = [tableDict objectForKey:@"total_order_people"];
            tablesModel.total_people_desc  = [tableDict objectForKey:@"total_people_desc"];
            tablesModel.table_id           = [tableDict objectForKey:@"table_id"];
            tablesModel.total_people       = [tableDict objectForKey:@"total_people"];
            tablesModel.group_id           = [tableDict objectForKey:@"group_id"];
            tablesModel.group_name         = [tableDict objectForKey:@"group_name"];
            tablesModel.empty_seat         = [tableDict objectForKey:@"empty_seat"];


//                if ([tablesModel.group_id integerValue]!=0) {
//              NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",tablesModel.group_id],@"group_id",[HQDefaultTool getKid],@"kid", nil];
//              [[FDGroupDetailTool sharedInstance] addGroupJoined:dic group_idString:[NSString stringWithFormat:@"%@",tablesModel.group_id]];
//                }
                
                
                [tableItems addObject:tablesModel];
                NSMutableArray *memberItems = [NSMutableArray array];
                NSMutableArray *members     = [tableDict objectForKey:@"members"];
                for (NSDictionary *tableDict in members) {
                    membersModel *memberModel = [[membersModel alloc]init];
                    memberModel.kid           = [tableDict objectForKey:@"kid"];
                    memberModel.icon          = [tableDict objectForKey:@"icon"];
                    memberModel.nick_name     = [tableDict objectForKey:@"nick_name"];
                    memberModel.people        = [tableDict objectForKey:@"people"];
                    memberModel.industry      = [tableDict objectForKey:@"industry"];
                    memberModel.occupation    = [tableDict objectForKey:@"occupation"];
                    memberModel.self_desc     = [tableDict objectForKey:@"self_desc"];
                    
                    memberModel.company      = [tableDict objectForKey:@"company"];
                    memberModel.sex    = [tableDict objectForKey:@"sex"];
                    memberModel.age     = [tableDict objectForKey:@"age"];
                    [memberItems addObject:memberModel];

                }
                 tablesModel.members = memberItems;

            }
                 orderModel.tables   = tableItems;


            
            
            
            //            orderModel.table_id=[item objectForKey:@"table_id"];
            //            orderModel.use_voucher=[item objectForKey:@"use_voucher"];
            //            orderModel.is_voucher=[item objectForKey:@"is_voucher"];
            //            orderModel.voucher_name=[item objectForKey:@"voucher_name"];
            //
            
            //            orderModel.server_time = [item objectForKey:@"server_time"];

            orderModel.is_cancel     = [item objectForKey:@"is_cancel"];
            orderModel.lat           = [item objectForKey:@"lat"];
            orderModel.lng           = [item objectForKey:@"lng"];
            orderModel.order_tips    = [item objectForKey:@"order_tips"];
            orderModel.table_hint    = [item objectForKey:@"table_hint"];
            orderModel.deliver_toast = [item objectForKey:@"deliver_toast"];
            orderModel.refund_toast  = [item objectForKey:@"refund_toast"];
            
            respModel.order          = orderModel;
            respModel.menu_id = [item objectForKey:@"menu_id"];
        }
        
        
    }
    MQQLog(@"RespUserOrderDetailModel =%@",[resultData description]);
    
    return respModel;
}

@end
