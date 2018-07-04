//
//  ApiParseMerchantDetail.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌详情接口解析

#import "ApiParseMerchantDetail.h"
#import "RequestModel.h"
#import "ReqMerchantDetailModel.h"
#import "RespMerchantDetailModel.h"
#import "MerchantModel.h"
#import "CommentModel.h"
#import "HQConst.h"
#import "ImagesModel.h"
#import "MenusModel.h"
#import "TagsModel.h"
#import "KdateModel.h"
#import "MealsModel.h"
#import "SeatsModel.h"
#import "TaoCanModel.h"
#import "FDMenus_V2_3Model.h"

@implementation ApiParseMerchantDetail

-(RequestModel *)requestData:(ReqMerchantDetailModel *)reqModel
{
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    
    [self.datas setSafeObject:reqModel.lng forKey:@"lng"];
    
    [self.datas setSafeObject:reqModel.lat forKey:@"lat"];
    
    [self.datas setSafeObject:reqModel.local_lat forKey:@"local_lat"];
    
    [self.datas setSafeObject:reqModel.local_lng forKey:@"local_lng"];
    
    [self.datas setSafeObject:reqModel.local forKey:@"local"];
    
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    
    [self.datas setSafeObject:reqModel.meal_date forKey:@"meal_date"];
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.is_bz forKey:@"is_bz"];
    [self.datas setSafeObject:reqModel.menu_id forKey:@"menu_id"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantDetailModel *)parseData:(id)resultData
{
    RespMerchantDetailModel *respModel=[[RespMerchantDetailModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            ///comments
            NSMutableArray *commentItems=[NSMutableArray array];
            NSDictionary *comments=[body safeObjectForKey:@"comments"];
            for (NSDictionary *comment in comments) {
                CommentModel *commentModel = [[CommentModel alloc] init];
                commentModel.icon = [comment safeObjectForKey:@"icon"];
                commentModel.kid = [comment safeObjectForKey:@"kid"];
                commentModel.nick_name = [comment safeObjectForKey:@"nick_name"];
                commentModel.content = [comment safeObjectForKey:@"content"];
                commentModel.star = [comment safeObjectForKey:@"star"];
                commentModel.create_time = [comment safeObjectForKey:@"create_time"];
                commentModel.service_response=[comment safeObjectForKey:@"service_response"];
                commentModel.comment_id = [comment safeObjectForKey:@"comment_id"];
                commentModel.imgs=[comment safeObjectForKey:@"imgs"];
                [commentItems addObject:commentModel];
            }
            respModel.comments = commentItems;
            respModel.is_western_restaurant = [body safeObjectForKey:@"is_western_restaurant"];
//            ///menus
//            NSMutableArray *menusItems=[NSMutableArray array];
//            NSDictionary *menus=[body safeObjectForKey:@"menus"];
//            for (NSDictionary *menusDict in menus) {
//                MenusModel *menusModel = [[MenusModel alloc] init];
//                menusModel.menu_name = [menusDict safeObjectForKey:@"menu_name"];
//                menusModel.menu_detail = [menusDict safeObjectForKey:@"menu_detail"];
//                [menusItems addObject:menusModel];
//            }
//            respModel.menus = menusItems;
//            ///imgs
//            NSMutableArray *imagesItems=[NSMutableArray array];
//            NSDictionary *images=[body safeObjectForKey:@"imgs"];
//            for (NSDictionary *imagesDict in images) {
//                ImagesModel *imagesModel = [[ImagesModel alloc] init];
//                imagesModel.title = [imagesDict safeObjectForKey:@"title"];
//                imagesModel.url = [imagesDict safeObjectForKey:@"url"];
//                [imagesItems addObject:imagesModel];
//            }
//            respModel.imgs = imagesItems;
//            ///small_imgs
//            NSMutableArray *smallimagesItems=[NSMutableArray array];
//            NSDictionary *smallimages=[body safeObjectForKey:@"small_imgs"];
//            for (NSDictionary *imagesDict in smallimages) {
//                ImagesModel *imagesModel = [[ImagesModel alloc] init];
//                imagesModel.title = [imagesDict safeObjectForKey:@"title"];
//                imagesModel.url = [imagesDict safeObjectForKey:@"url"];
//                [smallimagesItems addObject:imagesModel];
//            }
//            respModel.small_imgs = smallimagesItems;
//            
//            
//            ///small_menus
//            NSMutableArray *small_menusItem=[NSMutableArray array];
//            NSDictionary *small=[body safeObjectForKey:@"small_menus"];
//            for (NSDictionary *smallDict in small) {
//                MenusModel *menusModel = [[MenusModel alloc] init];
//                menusModel.menu_name = [smallDict safeObjectForKey:@"menu_name"];
//                menusModel.menu_detail = [smallDict safeObjectForKey:@"menu_detail"];
//                [small_menusItem addObject:menusModel];
//            }
//            respModel.small_menus = small_menusItem;
            
            
            
            
            
            
            
            

            ///kdates
            NSMutableArray *kdatesItems=[NSMutableArray array];
            NSMutableArray *kdates=[body safeObjectForKey:@"kdates"];
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
                    mealModel.is_discount = [meal safeObjectForKey:@"is_discount"];
                    [mealsItems addObject:mealModel];
                }
                kdateModel.meals = mealsItems;
                
                [kdatesItems addObject:kdateModel];
            }
            respModel.kdates = kdatesItems;
            
            ///seats
            NSMutableArray *seatsItems=[NSMutableArray array];
            NSDictionary *seats=[body safeObjectForKey:@"seats"];
            for (NSDictionary *tagDict in seats) {
                SeatsModel *tagsModel = [[SeatsModel alloc] init];
                tagsModel.seat_num = [tagDict safeObjectForKey:@"seat_num"];
                tagsModel.seat_desc = [tagDict safeObjectForKey:@"seat_desc"];
                tagsModel.seat_state = [tagDict safeObjectForKey:@"seat_state"];
                [seatsItems addObject:tagsModel];
            }
            respModel.seats = seatsItems;
            
            
            
            ///menu_copy
            NSMutableArray *menus_copyItems=[NSMutableArray array];
            NSMutableArray *menus_copy=[body safeObjectForKey:@"menus_copy"];
            for (NSDictionary *tagDict in menus_copy) {
                TaoCanModel *tagsModel = [[TaoCanModel alloc] init];
                tagsModel.menu_id = [tagDict safeObjectForKey:@"menu_id"];
                tagsModel.merchant_id = [tagDict safeObjectForKey:@"merchant_id"];
                tagsModel.mt_time = [tagDict safeObjectForKey:@"mt_time"];
                tagsModel.price = [tagDict safeObjectForKey:@"price"];
                tagsModel.price_desc = [tagDict safeObjectForKey:@"price_desc"];
                tagsModel.menu_people = [tagDict safeObjectForKey:@"menu_people"];
                tagsModel.menu_people_desc = [tagDict safeObjectForKey:@"menu_people_desc"];
                tagsModel.menu_is_new = [tagDict safeObjectForKey:@"menu_is_new"];
                tagsModel.is_soldout = [tagDict safeObjectForKey:@"is_soldout"];
                tagsModel.recommend_hint = [tagDict safeObjectForKey:@"recommend_hint"];
                ///imgs
                NSMutableArray *imagesItems=[NSMutableArray array];
                NSDictionary *images=[tagDict safeObjectForKey:@"imgs"];
                for (NSDictionary *imagesDict in images) {
                    ImagesModel *imagesModel = [[ImagesModel alloc] init];
                    imagesModel.title = [imagesDict safeObjectForKey:@"title"];
                    imagesModel.url = [imagesDict safeObjectForKey:@"url"];
                    [imagesItems addObject:imagesModel];
                }
                tagsModel.imgs = imagesItems;
                
                ///menus
                NSMutableArray *menusItems=[NSMutableArray array];
                NSDictionary *menus=[tagDict safeObjectForKey:@"menus"];
                for (NSDictionary *menusDict in menus) {
                    FDMenus_V2_3Model *menusModel = [[FDMenus_V2_3Model alloc] init];
                    menusModel.dish_name = [menusDict safeObjectForKey:@"dish_name"];
                    menusModel.part_num = [menusDict safeObjectForKey:@"part_num"];
                    menusModel.dish_price = [menusDict safeObjectForKey:@"dish_price"];
                    menusModel.sort = [menusDict safeObjectForKey:@"sort"];
                    [menusItems addObject:menusModel];
                }
                tagsModel.menus = menusItems;
                
                tagsModel.original_price = [tagDict safeObjectForKey:@"original_price"];
                tagsModel.jzjg = [tagDict safeObjectForKey:@"jzjg"];
                tagsModel.total_deduction = [tagDict safeObjectForKey:@"total_deduction"];
                tagsModel.paid = [tagDict safeObjectForKey:@"paid"];
                
                [menus_copyItems addObject:tagsModel];
            }
            
            respModel.menus_copy = menus_copyItems;
            
            
            respModel.friend_hint = [body safeObjectForKey:@"friend_hint"];
            
            
            
            
            
            MerchantModel *merchantModel=[[MerchantModel alloc]init];
            
            merchantModel.icon = [body safeObjectForKey:@"icon"];
            merchantModel.menu_id = [body safeObjectForKey:@"menu_id"];
            merchantModel.star = [body safeObjectForKey:@"star"];
            merchantModel.merchant_name = [body safeObjectForKey:@"merchant_name"];
            merchantModel.address = [body safeObjectForKey:@"address"];
            merchantModel.lat = [body safeObjectForKey:@"lat"];
            merchantModel.lng = [body safeObjectForKey:@"lng"];
            merchantModel.order_seat = [body safeObjectForKey:@"order_seat"];
            merchantModel.price = [body safeObjectForKey:@"price"];
            
            respModel.merchant  = merchantModel;
            
            respModel.people_hint = [body safeObjectForKey:@"people_hint"];
            respModel.comment_num = [body safeObjectForKey:@"comment_num"];
            respModel.soldout_hint = [body safeObjectForKey:@"soldout_hint"];
            respModel.meal_time_end_hint = [body safeObjectForKey:@"meal_time_end_hint"];
            respModel.meal_time_expired_hint = [body safeObjectForKey:@"meal_time_expired_hint"];
            respModel.small_menu_title = [body safeObjectForKey:@"small_menu_title"];
            respModel.small_menu_hint = [body safeObjectForKey:@"small_menu_hint"];
            respModel.clean_plate_hint = [body safeObjectForKey:@"clean_plate_hint"];
            respModel.left_seat = [body safeObjectForKey:@"left_seat"];
            
            respModel.pz_menu_id = [body safeObjectForKey:@"pz_menu_id"];
            
            
            respModel.WeChat_friends_share_title = [body safeObjectForKey:@"WeChat_friends_share_title"];
            respModel.WeChat_friends_share_text = [body safeObjectForKey:@"WeChat_friends_share_text"];
            respModel.WeChat_friends_circle_share_title = [body safeObjectForKey:@"WeChat_friends_circle_share_title"];
            respModel.group_share_title = [body safeObjectForKey:@"group_share_title"];
            respModel.group_share_hint = [body safeObjectForKey:@"group_share_hint"];
            
           
        }
    }
    MQQLog(@"RespMerchantDetailModel=%@",[resultData description]);
    
    return respModel;
}

@end
