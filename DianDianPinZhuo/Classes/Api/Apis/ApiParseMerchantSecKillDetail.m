//
//  ApiParseMerchantSecKillDetail.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseMerchantSecKillDetail.h"
#import "RequestModel.h"
#import "ReqMerchantSeckillDetailModel.h"
#import "RespMerchantSeckillDetailModel.h"
#import "MerchantModel.h"
#import "TagsModel.h"
#import "CommentModel.h"
#import "MenusModel.h"
#import "ImagesModel.h"
#import "HQConst.h"
@implementation ApiParseMerchantSecKillDetail

-(RequestModel *)requestData:(ReqMerchantSeckillDetailModel *)reqModel
{
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    [self.datas setSafeObject:reqModel.local_lat forKey:@"local_lat"];
    [self.datas setSafeObject:reqModel.local_lng forKey:@"local_lng"];
    [self.datas setSafeObject:reqModel.meal_id forKey:@"meal_id"];
    [self.datas setSafeObject:reqModel.local forKey:@"local"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_SECKILL_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantSeckillDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantSeckillDetailModel *)parseData:(id)resultData
{
    RespMerchantSeckillDetailModel *respModel=[[RespMerchantSeckillDetailModel alloc]init];
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
                merchantModel.star=[item safeObjectForKey:@"star"];
                merchantModel.price=[item safeObjectForKey:@"price"];
                merchantModel.lat=[item safeObjectForKey:@"lat"];
                merchantModel.lng=[item safeObjectForKey:@"lng"];
                merchantModel.distance=[item safeObjectForKey:@"distance"];
                merchantModel.dishes=[item safeObjectForKey:@"dishes"];
                merchantModel.vacancy=[[item safeObjectForKey:@"vacancy"]intValue];

                merchantModel.tastes=[[item safeObjectForKey:@"tastes"]intValue];
                merchantModel.is_comment=[[item safeObjectForKey:@"is_comment"]intValue];

                merchantModel.sold_out = [item safeObjectForKey:@"sold_out"];
                merchantModel.menu_id = [item safeObjectForKey:@"menu_id"];
                NSMutableArray *tagsItems=[NSMutableArray array];
                NSMutableArray *tags=[item safeObjectForKey:@"tags"];
                for (NSDictionary *tagDict in tags) {
                    TagsModel *tagsModel = [[TagsModel alloc] init];
                    tagsModel.tag_name = [tagDict safeObjectForKey:@"tag_name"];
                    tagsModel.tag_color = [tagDict safeObjectForKey:@"tag_color"];
                    [tagsItems addObject:tagsModel];
                }
                merchantModel.tags = tagsItems;
                
                [mutItems addObject:merchantModel];
            }
            respModel.merchant = mutItems;
            
            NSMutableArray *commentItems=[NSMutableArray array];
            NSMutableArray *comments=[body safeObjectForKey:@"comments"];
            for (NSDictionary *comment in comments) {
                CommentModel *commentModel = [[CommentModel alloc] init];
                commentModel.icon = [comment safeObjectForKey:@"icon"];
                commentModel.kid = [comment safeObjectForKey:@"kid"];
                commentModel.nick_name = [comment safeObjectForKey:@"nick_name"];
                commentModel.content = [comment safeObjectForKey:@"content"];
                commentModel.star = [comment safeObjectForKey:@"star"];
                commentModel.create_time = [comment safeObjectForKey:@"create_time"];
                [commentItems addObject:commentModel];
            }
            respModel.comments = commentItems;
            
            NSMutableArray *menusItems=[NSMutableArray array];
            NSMutableArray *menus=[body safeObjectForKey:@"menus"];
            
            for (NSDictionary *menusDict in menus) {
                MenusModel *menusModel = [[MenusModel alloc] init];
                menusModel.menu_name = [menusDict safeObjectForKey:@"menu_name"];
                menusModel.menu_detail = [menusDict safeObjectForKey:@"menu_detail"];
                [menusItems addObject:menusModel];
            }
            respModel.menus = menusItems;
            
            NSMutableArray *imagesItems=[NSMutableArray array];
            NSMutableArray *images=[body safeObjectForKey:@"imgs"];
            for (NSDictionary *imagesDict in images) {
                ImagesModel *imagesModel = [[ImagesModel alloc] init];
                imagesModel.title = [imagesDict safeObjectForKey:@"title"];
                imagesModel.url = [imagesDict safeObjectForKey:@"url"];
                [imagesItems addObject:imagesModel];
            }
            respModel.imgs = imagesItems;

            
        }
    }
    MQQLog(@"RespMerchantSeckillDetailModel=%@",[resultData description]);
    
    return respModel;
}

@end
