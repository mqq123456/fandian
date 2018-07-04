
//
//  ApiParseMerchantComment.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  商户评论接口解析

#import "ApiParseMerchantComment.h"
#import "RequestModel.h"
#import "ReqMerchantCommentModel.h"
#import "RespMerchantCommentModel.h"
#import "HQConst.h"
@implementation ApiParseMerchantComment

-(RequestModel *)requestData:(ReqMerchantCommentModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
   
    [self.datas setSafeObject:reqModel.order_no forKey:@"order_no"];
   
    [self.datas setSafeObject:reqModel.content forKey:@"content"];
    if (reqModel.star) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.star] forKey:@"star"];
    }
    if (reqModel.merchant_id) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.merchant_id] forKey:@"merchant_id"];
    }
    

    [self.datas setSafeObject:reqModel.cc_ids forKey:@"cc_ids"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_COMMENT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantCommentModel=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantCommentModel *)parseData:(id)resultData
{
    RespMerchantCommentModel *respModel=[[RespMerchantCommentModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            respModel.bag_url = [body safeObjectForKey:@"bag_url"];
        }
    }
    
    MQQLog(@"ReqMerchantCommentModel=%@",[resultData description]);
    
    return respModel;
}

@end
