//
//  ApiParseMerchantCommentList.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  评论列表接口解析

#import "ApiParseMerchantCommentList.h"
#import "RequestModel.h"
#import "ReqMerchantCommentListModel.h"
#import "RespMerchantCommentListModel.h"
#import "CommentModel.h"
#import "HQConst.h"
@implementation ApiParseMerchantCommentList

-(RequestModel *)requestData:(ReqMerchantCommentListModel *)reqModel
{
    [self.datas setSafeObject:reqModel.merchant_id forKey:@"merchant_id"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.page] forKey:@"page"];
    }
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_COMMENT_LIST];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantCommentListModel=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantCommentListModel *)parseData:(id)resultData
{
    RespMerchantCommentListModel *respModel=[[RespMerchantCommentListModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            //comment
            NSMutableArray *commentItems=[NSMutableArray array];
            NSMutableArray *comments=[body safeObjectForKey:@"comments"];
            for (NSDictionary *comment in comments) {
                CommentModel *commentModel=[[CommentModel alloc]init];
                commentModel.kid=[comment safeObjectForKey:@"kid"];
                commentModel.nick_name=[comment safeObjectForKey:@"nick_name"];
                commentModel.icon=[comment safeObjectForKey:@"icon"];
                commentModel.content=[comment safeObjectForKey:@"content"];
                commentModel.star=[comment safeObjectForKey:@"star"];
                commentModel.create_time=[comment safeObjectForKey:@"create_time"];
                commentModel.service_response=[comment safeObjectForKey:@"service_response"];
                commentModel.comment_id=[comment safeObjectForKey:@"comment_id"];
                commentModel.imgs= [NSMutableArray arrayWithArray:@[@"http://image.fundot.com.cn/user-head/1449633404521124.jpg",@"http://image.fundot.com.cn/user-head/1449633404521124.jpg",@"http://image.fundot.com.cn/user-head/1449633404521124.jpg"]];
               // commentModel.imgs=[comment safeObjectForKey:@"imgs"];
                [commentItems addObject:commentModel];
            }
            respModel.comments=commentItems;
            
        }
    }
    MQQLog(@"RespMerchantCommentListModel=%@",[resultData description]);
    
    return respModel;
}

@end
