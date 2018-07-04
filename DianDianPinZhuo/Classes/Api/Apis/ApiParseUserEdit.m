//
//  ApiParseUserEdit.m
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  修改个人资料接口解析

#import "ApiParseUserEdit.h"
#import "RequestModel.h"
#import "ReqUserEditModel.h"
#import "RespUserEditModel.h"
#import "HQConst.h"
@implementation ApiParseUserEdit
-(RequestModel *)requestData:(ReqUserEditModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.avator_id) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.avator_id] forKey:@"avator_id"];
    }
    
    
    [self.datas setSafeObject:reqModel.nick_name forKey:@"nick_name"];
    
    
    [self.datas setSafeObject:reqModel.industry forKey:@"industry"];
    
    
    [self.datas setSafeObject:reqModel.birth forKey:@"birth"];
    
    if (reqModel.sex) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%d",reqModel.sex] forKey:@"sex"];
    }
    
    
    [self.datas setSafeObject:reqModel.hometown forKey:@"hometown"];
    
    [self.datas setSafeObject:reqModel.ages forKey:@"ages"];
    
    
    
    [self.datas setSafeObject:reqModel.company forKey:@"company"];
    
    
    [self.datas setSafeObject:reqModel.constellation forKey:@"constellation"];
    
    [self.datas setSafeObject:reqModel.office_build forKey:@"office_build"];
    
    
    [self.datas setSafeObject:reqModel.occupation forKey:@"occupation"];
    
    [self.datas setSafeObject:reqModel.self_desc forKey:@"self_desc"];
    
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_EDIT];;
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserEditModel =%@",[self.datas description]);
    return requestModel;
}

-(RespUserEditModel *)parseData:(id)resultData
{
    RespUserEditModel *respModel=[[RespUserEditModel alloc]init];
    if (resultData!=nil) {
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
    }
    
    MQQLog(@"RespUserEditModel =%@",[resultData description]);
    
    return respModel;
}
@end
