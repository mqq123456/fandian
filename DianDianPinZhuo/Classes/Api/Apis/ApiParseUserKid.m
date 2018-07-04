//
//  ApiParseUserKid.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseUserKid.h"
#import "RequestModel.h"
#import "ReqUserKidModel.h"
#import "RespUserKidModel.h"
#import "HQConst.h"
#import "UsersModel.h"


@implementation ApiParseUserKid
-(RequestModel *)requestData:(ReqUserKidModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kids forKey:@"kids"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_KID];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserKidModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserKidModel *)parseData:(id)resultData
{
    RespUserKidModel *respModel=[[RespUserKidModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSMutableArray *users = [NSMutableArray array];
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            NSMutableArray *items = [body safeObjectForKey:@"users"];
            for (NSDictionary *item in items) {
                UsersModel *model = [[UsersModel alloc]init];
                model.kid = [item safeObjectForKey:@"kid"];
                model.nickname = [item safeObjectForKey:@"nickname"];
                model.url = [item safeObjectForKey:@"url"];
                [users addObject:model];
            }
            respModel.users = users;
            
        }
    }
    MQQLog(@"RespUserKidModel=%@",[resultData description]);
    
    return respModel;
}
@end
