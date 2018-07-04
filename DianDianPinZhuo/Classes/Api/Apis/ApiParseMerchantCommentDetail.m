//
//  ApiParseMerchantCommentDetail.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/16.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseMerchantCommentDetail.h"
#import "ReqMerchantCommentDetail.h"
#import "RespMerchantCommentDetail.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"
#import "CommentModel.h"

@implementation ApiParseMerchantCommentDetail
-(RequestModel *)requestData:(ReqMerchantCommentDetail *)reqModel
{
    [self.datas setSafeObject:reqModel.comment_id forKey:@"comment_id"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_COMMENT_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantCommentDetail=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantCommentDetail *)parseData:(id)resultData
{
    RespMerchantCommentDetail *respModel=[[RespMerchantCommentDetail alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            CommentModel *commentModel=[[CommentModel alloc]init];
            commentModel.kid=[body safeObjectForKey:@"kid"];
            commentModel.nick_name=[body safeObjectForKey:@"nick_name"];
            commentModel.icon=[body safeObjectForKey:@"icon"];
            commentModel.content=[body safeObjectForKey:@"content"];
            commentModel.star=[body safeObjectForKey:@"star"];
            commentModel.create_time=[body safeObjectForKey:@"create_time"];
            commentModel.service_response=[body safeObjectForKey:@"service_response"];
            //commentModel.comment_id=[body safeObjectForKey:@"comment_id"];
            commentModel.imgs=[body safeObjectForKey:@"imgs"];
            respModel.comment = commentModel;
            
            respModel.merchant_name=[body safeObjectForKey:@"merchant_name"];
            respModel.merchant_id=[body safeObjectForKey:@"merchant_id"];
            respModel.icon=[body safeObjectForKey:@"icon"];
            respModel.price=[body safeObjectForKey:@"price"];
            respModel.price_desc=[body safeObjectForKey:@"price_desc"];
            respModel.region_area=[body safeObjectForKey:@"region_area"];
            respModel.district=[body safeObjectForKey:@"district"];
            respModel.distance=[body safeObjectForKey:@"distance"];
            respModel.WeChat_share_title=[body safeObjectForKey:@"WeChat_share_title"];
            respModel.WeChat_share_text=[body safeObjectForKey:@"WeChat_share_text"];
            respModel.WeChat_share_icon=[body safeObjectForKey:@"WeChat_share_icon"];
            respModel.group_share_title=[body safeObjectForKey:@"group_share_title"];
            respModel.group_share_hint=[body safeObjectForKey:@"group_share_hint"];
        }
    }
    MQQLog(@"RespMerchantCommentDetail=%@",[resultData description]);
    
    return respModel;
}
@end
