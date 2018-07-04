//
//  ApiParseMerchantSearch.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌搜索接口解析

#import "ApiParseMerchantSearch.h"
#import "RequestModel.h"
#import "ReqMerchantSearchModel.h"
#import "RespMerchantSearchModel.h"
#import "MerchantModel.h"
#import "HQConst.h"
#import "MenusModel.h"
#import "TagsModel.h"
#import "SeatMealArrModel.h"

@implementation ApiParseMerchantSearch

-(RequestModel *)requestData:(ReqMerchantSearchModel *)reqModel
{
    [self.datas setSafeObject:reqModel.lng forKey:@"lng"];
    [self.datas setSafeObject:reqModel.lat forKey:@"lat"];
    [self.datas setSafeObject:reqModel.local_lng forKey:@"local_lng"];
    [self.datas setSafeObject:reqModel.local_lat forKey:@"local_lat"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.page ] forKey:@"page"];
    }
    
    [self.datas setSafeObject:reqModel.local forKey:@"local"];
    [self.datas setSafeObject:reqModel.max_distance forKey:@"max_distance"];
    
    [self.datas setSafeObject:reqModel.is_bz forKey:@"is_bz"];
    
    
    [self.datas setSafeObject:reqModel.meal_date forKey:@"meal_date"];
    
    
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    
    [self.datas setSafeObject:reqModel.people forKey:@"people"];
    
    if (reqModel.kid &&![reqModel.kid isEqualToString:@""]) {
        [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    }
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    if ([self.ApiUrl isEqualToString:@""]||!self.ApiUrl) {
     requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_SEARCH];;
    }else{
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,self.ApiUrl];
    }
    
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantSearchModel=%@",self.datas);
    return requestModel;
}

-(RespMerchantSearchModel *)parseData:(id)resultData
{
    RespMerchantSearchModel *respModel=[[RespMerchantSearchModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSMutableArray *mutItems=[NSMutableArray array];
            NSMutableArray *items=[body safeObjectForKey:@"merchants"];
            for (NSDictionary *item in items) {
                MerchantModel *merchantModel=[[MerchantModel alloc]init];
                merchantModel.merchant_id=[[item safeObjectForKey:@"merchant_id"] intValue];
                merchantModel.merchant_name=[item safeObjectForKey:@"merchant_name"];
                merchantModel.address=[item safeObjectForKey:@"address"];
                merchantModel.icon=[item safeObjectForKey:@"icon"];
                merchantModel.img=[item safeObjectForKey:@"img"];
                merchantModel.star=[item safeObjectForKey:@"star"];
                merchantModel.price=[item safeObjectForKey:@"price"];
                merchantModel.lat=[item safeObjectForKey:@"lat"];
                merchantModel.lng=[item safeObjectForKey:@"lng"];
                merchantModel.distance=[item safeObjectForKey:@"distance"];
                merchantModel.dishes=[item safeObjectForKey:@"dishes"];
                merchantModel.vacancy=[[item safeObjectForKey:@"vacancy"]intValue];
                merchantModel.others=[item safeObjectForKey:@"other"];
                merchantModel.tastes=[[item safeObjectForKey:@"tastes"]intValue];
                merchantModel.is_comment=[[item safeObjectForKey:@"is_comment"]intValue];
                merchantModel.sold_out=[item safeObjectForKey:@"sold_out"];
                merchantModel.menu_id = [item safeObjectForKey:@"menu_id"];
                merchantModel.segment=[item safeObjectForKey:@"segment"];
                merchantModel.segment_desc=[item safeObjectForKey:@"segment_desc"];
                merchantModel.hot = [item safeObjectForKey:@"hot"];
                merchantModel.isNew = [item safeObjectForKey:@"latest"];
                
                NSMutableArray *tagsItems=[NSMutableArray array];
                NSDictionary *tags=[item safeObjectForKey:@"tags"];
                for (NSDictionary *tagDict in tags) {
                    TagsModel *tagsModel = [[TagsModel alloc] init];
                    tagsModel.tag_name = [tagDict safeObjectForKey:@"tag_name"];
                    tagsModel.tag_color = [tagDict safeObjectForKey:@"tag_color"];
                    [tagsItems addObject:tagsModel];
                }
                merchantModel.tags = tagsItems;
                
                
                NSMutableArray *set_meal_arrItems=[NSMutableArray array];
                NSMutableArray *set_meal_arr=[item safeObjectForKey:@"set_meal_arr"];
                for (NSDictionary *tagDict in set_meal_arr) {
                    SeatMealArrModel *tagsModel = [[SeatMealArrModel alloc] init];
                    tagsModel.price = [tagDict safeObjectForKey:@"price"];
                    tagsModel.menu_people = [tagDict safeObjectForKey:@"menu_people"];
                    tagsModel.menu_is_new = [tagDict safeObjectForKey:@"menu_is_new"];
                    tagsModel.price_people_num_desc = [[NSMutableAttributedString alloc] initWithString:[tagDict safeObjectForKey:@"price_people_num_desc"]];
                    tagsModel.original_price = [tagDict safeObjectForKey:@"original_price"];
                    tagsModel.jzjg = [tagDict safeObjectForKey:@"jzjg"];
                    [set_meal_arrItems addObject:tagsModel];
                }
                merchantModel.set_meal_arr = set_meal_arrItems;
                
                merchantModel.order_seat=[item safeObjectForKey:@"order_seat"];
                merchantModel.tablemate=[item safeObjectForKey:@"tablemate"];
                merchantModel.people_desc=[item safeObjectForKey:@"people_desc"];
                merchantModel.nearby_people=[item safeObjectForKey:@"nearby_people"];
                
                merchantModel.table_desc=[item safeObjectForKey:@"table_desc"];
                merchantModel.description_desc=[item safeObjectForKey:@"description"];
                merchantModel.nearby_people_desc=[item safeObjectForKey:@"nearby_people_desc"];
                
                merchantModel.only_bz = [item safeObjectForKey:@"only_bz"];
                merchantModel.only_pz = [item safeObjectForKey:@"only_pz"];
                
                [mutItems addObject:merchantModel];
                
            }
            respModel.merchants=mutItems;
            respModel.max_distance = [body safeObjectForKey:@"max_distance"];
            respModel.meal_status = [body safeObjectForKey:@"meal_status"];
            respModel.meal_desc = [body safeObjectForKey:@"meal_desc"];
            respModel.soldout_hint = [body safeObjectForKey:@"soldout_hint"];
        }
    }
    
    MQQLog(@"RespMerchantSearchModel=%@",[resultData description]);
    
    return respModel;
}

@end
