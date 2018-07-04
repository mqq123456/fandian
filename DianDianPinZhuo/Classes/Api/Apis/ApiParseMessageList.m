//
//  ApiParseMessageList.m
//  DianDianPinZhuo
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "ApiParseMessageList.h"
#import "RequestModel.h"
#import "ReqUserMessageListModel.h"
#import "RespUserMessageListModel.h"
#import "MyMessageModel.h"
#import "HQConst.h"
@implementation ApiParseMessageList

-(RequestModel *)requestData:(ReqUserMessageListModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }

    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_MESSAGE_LIST];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserMessageListModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserMessageListModel *)parseData:(id)resultData
{
    RespUserMessageListModel *respModel=[[RespUserMessageListModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSMutableArray *mutItems=[NSMutableArray array];
            NSDictionary *items=[body safeObjectForKey:@"messages"];
            for (NSDictionary *item in items) {
                MyMessageModel *messageModel=[[MyMessageModel alloc]init];
                messageModel.my_id=[item safeObjectForKey:@"id"];
                messageModel.msg_id=[item safeObjectForKey:@"msg_id"];
                messageModel.title=[item safeObjectForKey:@"title"];
                messageModel.content=[item safeObjectForKey:@"content"];
                messageModel.page=[item safeObjectForKey:@"page"];
                messageModel.param = [item safeObjectForKey:@"param"];
                messageModel.img=[item safeObjectForKey:@"img"];
                messageModel.hint=[item safeObjectForKey:@"hint"];
                messageModel.create_time = [item safeObjectForKey:@"create_time"];
                messageModel.url = [item safeObjectForKey:@"url"];

                [mutItems addObject:messageModel];
            }
            respModel.messages=mutItems;

        }
    }
    MQQLog(@"RespUserMessageListModel=%@",[resultData description]);
    
    return respModel;
}
@end
