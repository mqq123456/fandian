//
//  ApiParseMerchantCommonComment.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/24.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "ApiParseMerchantCommonComment.h"
#import "RequestModel.h"
#import "ReqMerchantCommonComment.h"
#import "RespMerchantCommonComment.h"
#import "UsedCommentModel.h"
#import "HQConst.h"
@implementation ApiParseMerchantCommonComment

-(RequestModel *)requestData:(ReqMerchantCommonComment *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_MERCHANT_COMMON_COMMENT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqMerchantCommonComment=%@",[self.datas description]);
    return requestModel;
}

-(RespMerchantCommonComment *)parseData:(id)resultData
{
    RespMerchantCommonComment *respModel=[[RespMerchantCommonComment alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            //items
            NSMutableArray *itemItems=[NSMutableArray array];
            NSMutableArray *items=[body safeObjectForKey:@"items"];
            for (NSDictionary *comment in items) {
                UsedCommentModel *commentModel=[[UsedCommentModel alloc]init];
              
                commentModel.cc_id=[comment safeObjectForKey:@"cc_id"];
                commentModel.content=[comment safeObjectForKey:@"content"];
                commentModel.star=[comment safeObjectForKey:@"star"];
                
                [itemItems addObject:commentModel];
            }
            respModel.items=itemItems;
            
        }
    }
    MQQLog(@"RespMerchantCommonComment=%@",[resultData description]);
    
    return respModel;
}

@end
