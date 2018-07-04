//
//  ApiParseMerchantSecKillList.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseMerchantSecKillList.h"
#import "ReqMerchantSeckillListModel.h"
#import "RespMerchantSeckillListModel.h"
#import "RequestModel.h"
#import "MerchantModel.h"
#import "TagsModel.h"
#import "HQConst.h"
@implementation ApiParseMerchantSecKillList
-(RequestModel *)requestData:(ReqMerchantSeckillListModel *)reqModel
{
    [self.datas setSafeObject:reqModel.local_lng forKey:@"local_lng"];
    [self.datas setSafeObject:reqModel.local_lat forKey:@"local_lat"];
    [self.datas setSafeObject:reqModel.local forKey:@"local"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }
    
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    [self.datas setSafeObject:reqModel.max_distance forKey:@"max_distance"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_SECKILL_LIST];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantSeckillListModel=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantSeckillListModel *)parseData:(id)resultData
{
    RespMerchantSeckillListModel *respModel=[[RespMerchantSeckillListModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            NSMutableArray *merchants=[NSMutableArray array];
            NSMutableArray *items = [body safeObjectForKey:@"merchants"];
            respModel.order_date = [body safeObjectForKey:@"order_date"];
            respModel.meal_time = [body safeObjectForKey:@"meal_time"];
            respModel.start_time = [body safeObjectForKey:@"start_time"];
            respModel.end_time = [body safeObjectForKey:@"end_time"];
            respModel.max_distance = [body safeObjectForKey:@"max_distance"];
            
            for (NSDictionary *item in items) {
                MerchantModel *merchantModel = [[MerchantModel alloc]init];
                merchantModel.merchant_id = [[item safeObjectForKey:@"merchant_id"] intValue];
                merchantModel.merchant_name = [item safeObjectForKey:@"merchant_name"];
                merchantModel.address =[item safeObjectForKey:@"address"];
                merchantModel.icon = [item safeObjectForKey:@"icon"];
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
                merchantModel.payable = [item safeObjectForKey:@"payable"];

                NSMutableArray *tagsItems=[NSMutableArray array];
                NSDictionary *tags=[item safeObjectForKey:@"tags"];
                for (NSDictionary *tagDict in tags) {
                    TagsModel *tagsModel = [[TagsModel alloc] init];
                    tagsModel.tag_name = [tagDict safeObjectForKey:@"tag_name"];
                    tagsModel.tag_color = [tagDict safeObjectForKey:@"tag_color"];
                    [tagsItems addObject:tagsModel];
                }
                merchantModel.tags = tagsItems;
                [merchants addObject:merchantModel];

            }
            
            respModel.merchants = merchants;
        }
    }
    MQQLog(@"RespMerchantSeckillListModel=%@",[resultData description]);
    
    return respModel;
}

@end
