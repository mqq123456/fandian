//
//  ApiPaseTopicDetail.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiPaseTopicDetail.h"
#import "ReqTopicDetailModel.h"
#import "RespBaseTopicDetailModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDTopics.h"
#import "MemberModel.h"
#import "TopicCommentModel.h"
#import "SeatsModel.h"

@implementation ApiPaseTopicDetail
-(RequestModel *)requestData:(ReqTopicDetailModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.topic_id forKey:@"topic_id"];
    [self.datas setSafeObject:reqModel.lat forKey:@"lat"];
    [self.datas setSafeObject:reqModel.lng forKey:@"lng"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseTopicDetailModel *)parseData:(id)resultData
{
    RespBaseTopicDetailModel *respModel=[[RespBaseTopicDetailModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSMutableArray *topicsItem = [NSMutableArray array];
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            
            FDTopics *model = [[FDTopics alloc]init];
            
            model.person_img = [body safeObjectForKey:@"person_img"];
            model.nickname = [body safeObjectForKey:@"nickname"];
            model.nickname_desc = [body safeObjectForKey:@"nickname_desc"];
            model.content = [body safeObjectForKey:@"content"];
            model.is_free = [[body safeObjectForKey:@"is_free"] intValue];
            model.meal_time = [body safeObjectForKey:@"meal_time"];
            model.meal_desc = [body safeObjectForKey:@"meal_desc"];
            model.table_id = [body safeObjectForKey:@"table_id"];
            model.table_name = [body safeObjectForKey:@"table_name"];
            model.table_num = [body safeObjectForKey:@"table_num"];
            model.table_desc = [body safeObjectForKey:@"table_desc"];
            model.ordermeal_num = [[body safeObjectForKey:@"ordermeal_num"] intValue];
            model.comment_num = [[body safeObjectForKey:@"comment_num"] intValue];
            model.comment_desc = [body safeObjectForKey:@"comment_desc"];
            model.topic_keyword = [body safeObjectForKey:@"topic_keyword"];
            model.image = [body safeObjectForKey:@"topic_img"];
            model.star = [body safeObjectForKey:@"star"];
            model.is_order = [body safeObjectForKey:@"is_order"];
            model.people = [body safeObjectForKey:@"people"];
            model.topic_id = [body safeObjectForKey:@"topic_id"];
            model.kid = [body safeObjectForKey:@"kid"];
            model.free_price = [body safeObjectForKey:@"free_price"];
            model.seat_desc = [body safeObjectForKey:@"seat_desc"];
            model.free_people = [body safeObjectForKey:@"free_people"];
            
            ///2.1
            model.weixin_topic_title = [body safeObjectForKey:@"weixin_topic_title"];
            model.weixin_topic_content = [body safeObjectForKey:@"weixin_topic_content"];
            model.weixin_topic_url = [body safeObjectForKey:@"weixin_topic_url"];
            
            
            respModel.topic = model;
       
            
            NSMutableArray *memberArray = [NSMutableArray array];
            NSMutableArray *members = [body safeObjectForKey:@"users_img"];
            for (NSDictionary *memberItem in members) {
                MemberModel *member = [[MemberModel alloc]init];
                
                member.kid = [memberItem safeObjectForKey:@"kid"];
                member.img = [memberItem safeObjectForKey:@"img"];
                member.nick_name = [memberItem safeObjectForKey:@"nick_name"];
                [memberArray addObject:member];
                
            }
            if ([[body safeObjectForKey:@"replace_people_num"] intValue]>0) {
                MemberModel *member = [[MemberModel alloc]init];
                
                member.img = [NSString stringWithFormat:@"%@",[body safeObjectForKey:@"replace_people_num"]];
                [memberArray addObject:member];
            }
            respModel.members = memberArray;
            NSMutableArray *commentItems=[NSMutableArray array];
            NSMutableArray *comments=[body safeObjectForKey:@"comments"];
            for (NSDictionary *comment in comments) {
                TopicCommentModel *commentModel=[[TopicCommentModel alloc]init];
                commentModel.kid=[comment safeObjectForKey:@"kid"];
                commentModel.nickname=[comment safeObjectForKey:@"nickname"];
                commentModel.img=[comment safeObjectForKey:@"img"];
                commentModel.character_desc=[comment safeObjectForKey:@"character_desc"];
                commentModel.content=[comment safeObjectForKey:@"content"];
                commentModel.reply_nickname=[comment safeObjectForKey:@"reply_nickname"];
                commentModel.reply_kid=[comment safeObjectForKey:@"reply_kid"];
                
                commentModel.comment_id=[comment safeObjectForKey:@"id"];
                commentModel.time_desc=[comment safeObjectForKey:@"time_desc"];
                [commentItems addObject:commentModel];
            }
            respModel.comments=commentItems;
            [topicsItem addObject:model];
            respModel.meal_id = [body safeObjectForKey:@"meal_id"];
            
            respModel.meal_date = [body safeObjectForKey:@"meal_date"];
            respModel.meal_time = [body safeObjectForKey:@"meal_time"];
            respModel.kdate_desc = [body safeObjectForKey:@"kdate_desc"];
            
            respModel.left_seat = [body safeObjectForKey:@"left_seat"];
            respModel.is_order = [body safeObjectForKey:@"is_order"];
            respModel.order_seat = [body safeObjectForKey:@"order_seat"];
            respModel.menu_id = [body safeObjectForKey:@"menu_id"];
            
            
            NSMutableArray *seatsItems=[NSMutableArray array];
            NSDictionary *seats=[body safeObjectForKey:@"seats"];
            for (NSDictionary *tagDict in seats) {
                SeatsModel *tagsModel = [[SeatsModel alloc] init];
                tagsModel.seat_num = [tagDict safeObjectForKey:@"seat_num"];
                tagsModel.seat_desc = [tagDict safeObjectForKey:@"seat_desc"];
                tagsModel.seat_state =[tagDict safeObjectForKey:@"seat_state"];
                [seatsItems addObject:tagsModel];
            }
            respModel.seats = seatsItems;
            
            NSDictionary *item=[body safeObjectForKey:@"merchant"];
            MerchantModel *merchantModel = [[MerchantModel alloc] init];
            
            merchantModel.merchant_id=[[item safeObjectForKey:@"merchant_id"] intValue];
            merchantModel.merchant_name=[item safeObjectForKey:@"merchant_name"];
            merchantModel.address=[item safeObjectForKey:@"address"];
            merchantModel.icon=[item safeObjectForKey:@"icon"];
            merchantModel.is_order=[item safeObjectForKey:@"is_order"];
            merchantModel.star=[item safeObjectForKey:@"star"];
            merchantModel.price=[item safeObjectForKey:@"price"];
            merchantModel.menu_id=[item safeObjectForKey:@"menu_id"];
            merchantModel.lat = [item safeObjectForKey:@"lat"];
            merchantModel.lng = [item safeObjectForKey:@"lng"];
            
            
            merchantModel.distance=[body safeObjectForKey:@"distance"];
            respModel.merchant = merchantModel;
            
            
            
        }
    }
    MQQLog(@"RespBaseTopicDetailModel=%@",[resultData description]);
    
    return respModel;
}
@end
