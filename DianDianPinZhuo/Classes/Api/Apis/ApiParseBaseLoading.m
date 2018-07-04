//
//  ApiParseBaseLoading.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  Loading接口解析

#import "ApiParseBaseLoading.h"
#import "RequestModel.h"
#import "ReqBaseLoadingModel.h"
#import "RespBaseLoadingModel.h"
#import "VersionModel.h"
#import "IndustriesModel.h"
#import "AdsModel.h"
#import "KdateModel.h"
#import "MealsModel.h"
#import "HQConst.h"
#import "OrderMsgModel.h"
#import "PeopleModel.h"
#import "SeatsModel.h"

@implementation ApiParseBaseLoading

-(RequestModel *)requestData:(ReqBaseLoadingModel *)reqModel
{

    
    [self.datas setSafeObject:reqModel.cver forKey:@"cver"];
    [self.datas setSafeObject:reqModel.dver forKey:@"dver"];
    [self.datas setSafeObject:reqModel.channel forKey:@"channel"];
    [self.datas setSafeObject:reqModel.imei forKey:@"imei"];
    [self.datas setSafeObject:reqModel.platform forKey:@"platform"];
    [self.datas setSafeObject:reqModel.brand forKey:@"brand"];
    [self.datas setSafeObject:reqModel.ua forKey:@"ua"];
    [self.datas setSafeObject:reqModel.device_token forKey:@"device_token"];

    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];

    [self.datas setSafeObject:reqModel.local_lat forKey:@"local_lat"];
    
    [self.datas setSafeObject:reqModel.local_lng forKey:@"local_lng"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
   
    [self.params setSafeObject:encryptString forKey:@"data"];

    RequestModel *requestModel=[[RequestModel alloc]init];
    
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_LOADING];
    
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseLoadingModel=%@",self.datas);
    return requestModel;
}

-(RespBaseLoadingModel *)parseData:(id)resultData
{
    RespBaseLoadingModel *respModel=[[RespBaseLoadingModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            //version
            NSDictionary *version=[body safeObjectForKey:@"version"];
            VersionModel *versionModel=[[VersionModel alloc]init];
            versionModel.is_new=[[version safeObjectForKey:@"is_new"] intValue];
            versionModel.title=[version safeObjectForKey:@"title"];
            versionModel.tips=[version safeObjectForKey:@"tips"];
            versionModel.url=[version safeObjectForKey:@"url"];
            versionModel.ver = [version safeObjectForKey:@"ver"];
            respModel.version=versionModel;
            
            //kdates
            NSMutableArray *kdatesItems=[NSMutableArray array];
            NSDictionary *kdates=[body safeObjectForKey:@"kdates"];
            for (NSDictionary *kdate in kdates) {
                KdateModel *kdateModel=[[KdateModel alloc]init];
                kdateModel.kdate=[kdate safeObjectForKey:@"kdate"];
                kdateModel.kdate_desc=[kdate safeObjectForKey:@"kdate_desc"];
                NSMutableArray *mealsItems=[NSMutableArray array];
                
                NSMutableArray *meals=[kdate safeObjectForKey:@"meals"];
                for (NSDictionary *meal in meals) {
                    MealsModel *mealModel = [[MealsModel alloc] init];
                    mealModel.meal_id = [meal safeObjectForKey:@"meal_id"];
                    mealModel.meal_desc = [meal safeObjectForKey:@"meal_desc"];
                    mealModel.state = [meal safeObjectForKey:@"state"];
                    [mealsItems addObject:mealModel];
                }
                kdateModel.meals = mealsItems;
                
                [kdatesItems addObject:kdateModel];
            }
            respModel.kdates=kdatesItems;
            
            
//            //industries
//            NSMutableArray *industriesItems=[NSMutableArray array];
//            NSDictionary *industries=[body safeObjectForKey:@"industries"];
//            for (NSDictionary *industry in industries) {
//                IndustriesModel *industriesModel=[[IndustriesModel alloc]init];
//                industriesModel.industry_id=[industry safeObjectForKey:@"industry_id"];
//                industriesModel.industry_name=[industry safeObjectForKey:@"industry_name"];
//                
//                [industriesItems addObject:industriesModel];
//            }
//            respModel.industries=industriesItems;
//            
            //ads
            NSMutableArray *adsItems=[NSMutableArray array];
            NSDictionary *ads=[body safeObjectForKey:@"ads"];
            for (NSDictionary *adsDict in ads) {
                AdsModel *adsModel=[[AdsModel alloc]init];
                adsModel.img=[adsDict safeObjectForKey:@"img"];
                adsModel.url=[adsDict safeObjectForKey:@"url"];
                adsModel.title = [adsDict safeObjectForKey:@"title"];
                adsModel.banner_id = [adsDict safeObjectForKey:@"banner_id"];
                [adsItems addObject:adsModel];
            }
            respModel.ads = adsItems;
            
            //peoples
            NSMutableArray *peoplesArr=[NSMutableArray array];
            NSMutableArray *peoples=[body safeObjectForKey:@"peoples"];
            for (NSDictionary *peopleDic in peoples) {
                PeopleModel *peopleModel=[[PeopleModel alloc]init];
                peopleModel.people=[peopleDic safeObjectForKey:@"people"];
                peopleModel.desc=[peopleDic safeObjectForKey:@"desc"];
                
                [peoplesArr addObject:peopleModel];
            }
            respModel.peoples=peoplesArr;

            //
            NSMutableArray *topic_class_id=[NSMutableArray array];
            NSMutableArray *topic_class_name=[NSMutableArray array];
            NSMutableArray *user_option=[NSMutableArray array];
            for (NSDictionary *dic in [body safeObjectForKey:@"topic_class"]) {
                [topic_class_id addObject:[dic safeObjectForKey:@"class_id"]];
                [topic_class_name addObject:[dic safeObjectForKey:@"class_name"]];
                [user_option addObject:[dic safeObjectForKey:@"user_option"]];
                
            }
            
            respModel.topic_class_id = topic_class_id;
            respModel.topic_class_name = topic_class_name;

            
            respModel.down_url = [body safeObjectForKey:@"down_url"];
            respModel.service = [body safeObjectForKey:@"service"];
            respModel.agreement_url = [body safeObjectForKey:@"agreement_url"];
            respModel.invite_url = [body safeObjectForKey:@"invite_url"];
            respModel.order_timeout = [body safeObjectForKey:@"order_timeout"];
            NSDictionary *order_Dict= [body safeObjectForKey:@"order_msg"];
            OrderMsgModel *orderMsgModel = [[OrderMsgModel alloc] init];
            orderMsgModel.title = [order_Dict safeObjectForKey:@"title"];
            orderMsgModel.desc = [order_Dict safeObjectForKey:@"desc"];
            orderMsgModel.order_desc = [order_Dict safeObjectForKey:@"order_desc"];
            orderMsgModel.order_nos = [order_Dict safeObjectForKey:@"order_nos"];
            orderMsgModel.topic_ids = [order_Dict safeObjectForKey:@"topic_ids"];
            respModel.orderMsgModel = orderMsgModel;

            respModel.order_tips = [body safeObjectForKey:@"order_tips"];
            respModel.topic_tips = [body safeObjectForKey:@"topic_tips"];
            respModel.seckill_order_tips= [body safeObjectForKey:@"seckill_order_tips"];
            respModel.voucher_qa_url= [body safeObjectForKey:@"voucher_qa_url"];
            
            respModel.is_msg = [body safeObjectForKey:@"is_msg"];
            respModel.integral_tip = [body safeObjectForKey:@"integral_tip"];
            
            
            respModel.nearby_people = [body safeObjectForKey:@"nearby_people"];
            
            respModel.nearby_people_desc= [body safeObjectForKey:@"nearby_people_desc"];
            
            respModel.nearby_topic = [body safeObjectForKey:@"nearby_topic"];
            respModel.nearby_topic_desc = [body safeObjectForKey:@"nearby_topic_desc"];
            
            respModel.advanced_order_tips_title = [body safeObjectForKey:@"advanced_order_tips_title"];
            
            respModel.advanced_order_tips_content = [body safeObjectForKey:@"advanced_order_tips_content"];
            respModel.groups_notice = [body safeObjectForKey:@"groups_notice"];
            
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
            
        }
    }
    MQQLog(@"RespBaseLoadingModel====%@",[resultData description]);
    
    return respModel;
}
@end
