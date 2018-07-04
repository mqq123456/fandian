//
//  ApiParseBaseImageUpload.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  图片上传接口解析

#import "ApiParseBaseImageUpload.h"
#import "RequestModel.h"
#import "ReqBaseImageUploadModel.h"
#import "RespBaseImageUploadModel.h"
#import "HQConst.h"
@implementation ApiParseBaseImageUpload

-(RequestModel *)requestData:(ReqBaseImageUploadModel *)reqModel
{
    //[self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.uuid] forKey:@"uuid"];
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    [self.params setSafeObject:reqModel.img forKey:@"img"];//图片数据流
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_IMAGE_UPLOAD];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseImageUploadModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseImageUploadModel *)parseData:(id)resultData
{
    RespBaseImageUploadModel *respModel=[[RespBaseImageUploadModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            respModel.pic_id=[[body safeObjectForKey:@"pic_id"]intValue];
            respModel.url=[body safeObjectForKey:@"url"];
            
        }
    }
    MQQLog(@"RespBaseImageUploadModel=%@",[resultData description]);
    
    return respModel;
}
@end
