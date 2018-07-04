//
//  ApiPaseTopicOrderDetail.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicOrderDetail.h"
#import "ReqTopicOrderDetailModel.h"
#import "RespTopicOrderDetail.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "membersModel.h"
@implementation ApiPaseTopicOrderDetail
-(RequestModel *)requestData:(ReqTopicOrderDetailModel *)reqModel
{
    [self.datas setObject:reqModel.kid forKey:@"kid"];
    [self.datas setObject:reqModel.topic_id forKey:@"topic_id"];
    [self.datas setObject:reqModel.order_no forKey:@"order_no"];
    [self.datas setObject:reqModel.is_bz forKey:@"is_bz"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_ORDER_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicOrderDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicOrderDetail *)parseData:(id)resultData
{
    RespTopicOrderDetail *respModel=[[RespTopicOrderDetail alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData objectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head objectForKey:@"code"]];
        respModel.desc =[head objectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData objectForKey:@"body"];
            
            respModel.content = [body objectForKey:@"content"];
            respModel.img = [body objectForKey:@"img"];
            respModel.lat = [body objectForKey:@"lat"];
            respModel.lng = [body objectForKey:@"lng"];
            respModel.icon = [body objectForKey:@"icon"];
            respModel.nickname = [body objectForKey:@"nickname"];
            respModel.myself_desc = [body objectForKey:@"myself_desc"];
            respModel.is_free = [body objectForKey:@"is_free"];
            respModel.meal_time = [body objectForKey:@"meal_time"];
            respModel.merchant_id = [body objectForKey:@"merchant_id"];
            respModel.merchant_name = [body objectForKey:@"merchant_name"];
            respModel.address = [body objectForKey:@"address"];
            respModel.table_desc = [body objectForKey:@"table_desc"];
            respModel.table_name = [body objectForKey:@"table_name"];
            respModel.table_no = [body objectForKey:@"table_no"];
            respModel.server_stamp = [body objectForKey:@"server_stamp"];
            respModel.rice_friend = [body objectForKey:@"rice_friend"];
            respModel.table_alloc_left_time = [body objectForKey:@"table_alloc_left_time"];
            respModel.table_alloc_time = [body objectForKey:@"table_alloc_time"];
            respModel.price = [body objectForKey:@"price"];
            respModel.meal_date = [body objectForKey:@"meal_date"];
            respModel.meal_date_std = [body objectForKey:@"meal_date_std"];
            respModel.star = [body objectForKey:@"star"];
            respModel.order_seat = [body objectForKey:@"order_seat"];
            respModel.validation = [body objectForKey:@"validation"];
            respModel.order_num = [body objectForKey:@"order_num"];
            respModel.order_tips = [body objectForKey:@"order_tips"];
            respModel.group_id = [body objectForKey:@"group_id"];
            respModel.group_name = [body objectForKey:@"group_name"];
            respModel.is_cancel = [body objectForKey:@"is_cancel"];
            respModel.order_no = [body objectForKey:@"order_no"];
            respModel.table_id = [body objectForKey:@"table_id"];
            respModel.bag_url = [body objectForKey:@"bag_url"];
            
            respModel.paid = [body objectForKey:@"paid"];
            respModel.meal_id = [body objectForKey:@"meal_id"];

            respModel.total_order_people = [body objectForKey:@"total_order_people"];
            respModel.total_people = [body objectForKey:@"total_people"];
            
            ///2.1
            respModel.weixin_topic_content = [body objectForKey:@"weixin_topic_content"];
            
            respModel.weixin_topic_title = [body objectForKey:@"weixin_topic_title"];
            respModel.weixin_topic_url = [body objectForKey:@"weixin_topic_url"];
            respModel.is_bz = [body objectForKey:@"is_bz"];
            
            
            NSMutableArray *usersArray = [NSMutableArray array];
            
            NSMutableArray *users = [body objectForKey:@"users"];
            
            for (NSDictionary *dic  in users) {
                membersModel *model = [[membersModel alloc]init];
                model.kid  = [dic objectForKey:@"kid"];
                model.img  = [dic objectForKey:@"img"];
                model.nickname  = [dic objectForKey:@"nickname"];
                model.myself_desc  = [dic objectForKey:@"myself_desc"];
                [usersArray addObject:model];
            }
            
            respModel.users = usersArray;
        }
    }
    MQQLog(@"RespTopicOrderDetail=%@",[resultData description]);
    
    return respModel;
}
@end
