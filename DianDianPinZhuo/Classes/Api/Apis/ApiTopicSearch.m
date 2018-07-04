//
//  ApiTopicSearch.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiTopicSearch.h"

#import "ReqTopicSearchModel.h"
#import "RespTopicSearchModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDTopics.h"
#import "MemberModel.h"

@implementation ApiTopicSearch
-(RequestModel *)requestData:(ReqTopicSearchModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.lng forKey:@"lng"];
    [self.datas setSafeObject:reqModel.lat forKey:@"lat"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.page] forKey:@"page"];
    }
    

    [self.datas setSafeObject:reqModel.class_id forKey:@"class_id"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_TOPIC_SEARCH];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqTopicSearchModel=%@",[self.datas description]);
    return requestModel;
}

-(RespTopicSearchModel *)parseData:(id)resultData
{
    RespTopicSearchModel *respModel=[[RespTopicSearchModel alloc]init];
    if (resultData!=nil) {
        MQQLog(@"RespTopicSearchModel=%@",[resultData description]);
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSMutableArray *topicsItem = [NSMutableArray array];
            NSDictionary *body=[resultData safeObjectForKey:@"body"];

            NSMutableArray *topic = [body safeObjectForKey:@"topic"];
            for (NSDictionary *item in topic) {
                FDTopics *model = [[FDTopics alloc]init];
                model.topic_id = [item safeObjectForKey:@"topic_id"];
                model.kid = [item safeObjectForKey:@"kid"];
                model.person_img = [item safeObjectForKey:@"person_img"];
                model.nickname = [item safeObjectForKey:@"nickname"];
                model.nickname_desc = [item safeObjectForKey:@"nickname_desc"];
                model.content = [item safeObjectForKey:@"content"];
                model.is_free = [[item safeObjectForKey:@"is_free"] intValue];
                model.merchant_id = [item safeObjectForKey:@"merchant_id"];
                model.merchant_name = [item safeObjectForKey:@"merchant_name"];
                model.address = [item safeObjectForKey:@"address"];
                model.distance = [item safeObjectForKey:@"distance"];
                model.meal_time = [item safeObjectForKey:@"meal_time"];
                model.table_id = [item safeObjectForKey:@"table_id"];
                model.table_name = [item safeObjectForKey:@"table_name"];
                model.table_num = [item safeObjectForKey:@"table_num"];
                model.table_desc = [item safeObjectForKey:@"table_desc"];
                model.ordermeal_num = [[item safeObjectForKey:@"ordermeal_num"] intValue];
                model.comment_num = [[item safeObjectForKey:@"comment_num"] intValue];
                model.comment_desc = [item safeObjectForKey:@"comment_desc"];
                model.topic_keyword = [item safeObjectForKey:@"topic_keyword"];
                model.image = [item safeObjectForKey:@"topic_img"];
                model.kdate_desc = [item safeObjectForKey:@"kdate_desc"];
                model.meal_date = [item safeObjectForKey:@"meal_date"];
                
                model.ordermeal_num = [[item safeObjectForKey:@"people"] intValue];
                model.sheng_yu = [[item safeObjectForKey:@"left_seat"] intValue];
                model.last_unfinished = [item safeObjectForKey:@"last_unfinished"];
                
                model.company = [item safeObjectForKey:@"company"];
                model.occupation = [item safeObjectForKey:@"occupation"];
                model.age = [item safeObjectForKey:@"age"];
                model.is_finished = [item safeObjectForKey:@"is_finished"];
                model.sex = [item safeObjectForKey:@"sex"];
                
                NSMutableArray *imgs=[NSMutableArray array];
                NSMutableArray *imgsItem = [item safeObjectForKey:@"users_img"];
                
                for (NSDictionary *itemDict in imgsItem) {
                    MemberModel *imgsModel = [[MemberModel alloc]init];
                    imgsModel.img = [itemDict safeObjectForKey:@"img"];
                    imgsModel.kid = [itemDict safeObjectForKey:@"kid"];
                    [imgs addObject:imgsModel];
                    
                }
                model.users_img = imgs;
                
                [topicsItem addObject:model];
            }
            
            
            respModel.topic = topicsItem;
            
            
            
        }
    }
    
    return respModel;
}
@end
