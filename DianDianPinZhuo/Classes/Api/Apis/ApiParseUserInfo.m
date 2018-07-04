//
//  ApiParseUserInfo.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseUserInfo.h"
#import "RespUserInfoModel.h"
#import "ReqUserInfoModel.h"
#import "HQConst.h"
#import "UserModel.h"
#import "RequestModel.h"

@implementation ApiParseUserInfo

-(RequestModel *)requestData:(ReqUserInfoModel *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_INFO];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserInfoModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserInfoModel *)parseData:(id)resultData
{
    RespUserInfoModel *respModel=[[RespUserInfoModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            NSDictionary *user=[body safeObjectForKey:@"user"];
            
            UserModel *userModel = [[UserModel alloc] init];
            
            userModel.app_invite_url = [user safeObjectForKey:@"app_invite_url"];
            userModel.weixin_invite_url = [user safeObjectForKey:@"weixin_invite_url"];
            userModel.weixin_invite_content = [user safeObjectForKey:@"weixin_invite_content"];
            userModel.weixin_invite_title = [user safeObjectForKey:@"weixin_invite_title"];
            userModel.nick_name = [user safeObjectForKey:@"nick_name"];
            userModel.head  = [user safeObjectForKey:@"head"];
            userModel.sex = [user safeObjectForKey:@"sex"];
            userModel.phone = [user safeObjectForKey:@"phone"];
            userModel.ages  = [user safeObjectForKey:@"ages"];
            userModel.birth = [user safeObjectForKey:@"birth"];
            userModel.industry = [user safeObjectForKey:@"industry"];
            userModel.occupation  = [user safeObjectForKey:@"occupation"];
            userModel.hometown = [user safeObjectForKey:@"hometown"];
            userModel.im_password = [user safeObjectForKey:@"im_password"];
            
            userModel.company = [user safeObjectForKey:@"company"];
            userModel.constellation = [user safeObjectForKey:@"constellation"];
            userModel.office_build = [user safeObjectForKey:@"office_build"];
            userModel.kid = [user safeObjectForKey:@"kid"];
            userModel.taste = [user safeObjectForKey:@"taste"];
            
            userModel.growup_point = [user safeObjectForKey:@"growup_point"];
            userModel.integral_point = [user safeObjectForKey:@"integral_point"];
            userModel.voucher_count = [user safeObjectForKey:@"voucher_count"];
            userModel.orderSum = [user safeObjectForKey:@"orderSum"];
            
            userModel.is_msg = [[user safeObjectForKey:@"is_msg"] intValue];
            
            userModel.ages_hint = [user safeObjectForKey:@"ages_hint"];
            userModel.occupation_hint = [user safeObjectForKey:@"occupation_hint"];
            
            userModel.company_hint = [user safeObjectForKey:@"company_hint"];
            userModel.constellation_hint = [user safeObjectForKey:@"constellation_hint"];
            userModel.hometown_hint = [user safeObjectForKey:@"hometown_hint"];

            userModel.ages_default = [user safeObjectForKey:@"ages_default"];
            userModel.occupation_default = [user safeObjectForKey:@"occupation_default"];
            
            userModel.company_default = [user safeObjectForKey:@"company_default"];
            userModel.constellation_default = [user safeObjectForKey:@"constellation_default"];
            userModel.hometown_default = [user safeObjectForKey:@"hometown_default"];
            userModel.self_desc = [user safeObjectForKey:@"self_desc"];

            userModel.complete_info = [user safeObjectForKey:@"complete_info"];

            respModel.user = userModel;
            
        }
    }
    
    MQQLog(@"RespUserInfoModel = %@",[resultData description]);
    
    return respModel;
    
}


@end
