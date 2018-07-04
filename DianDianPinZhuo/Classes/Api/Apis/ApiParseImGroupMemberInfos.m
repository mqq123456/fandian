//
//  ApiParseImGroupMemberInfos.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseImGroupMemberInfos.h"

#import "ReqImGroupMemberInfos.h"
#import "RespImGroupMemberInfos.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"

@implementation ApiParseImGroupMemberInfos
-(RequestModel *)requestData:(ReqImGroupMemberInfos *)reqModel
{
    [self.datas setSafeObject:reqModel.group_id forKey:@"group_id"];
    [self.datas setSafeObject:reqModel.page forKey:@"page"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_GROUP_MEMBER_INFOS];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImGroupMemberInfos=%@",[self.datas description]);
    return requestModel;
}

-(RespImGroupMemberInfos *)parseData:(id)resultData
{
    RespImGroupMemberInfos *respModel=[[RespImGroupMemberInfos alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            
            NSMutableArray *memberArray = [NSMutableArray array];
            NSMutableArray *groups = [body objectForKey:@"members"];
            
            for (NSDictionary *dic  in groups) {
                GroupMembersModel *model = [[GroupMembersModel alloc]init];
                model.kid  = [dic objectForKey:@"kid"];
                model.nick_name  = [dic objectForKey:@"nick_name"];
                model.icon  = [dic objectForKey:@"icon"];
                model.company  = [dic objectForKey:@"company"];
                model.occupation  = [dic objectForKey:@"occupation"];
                
                model.sex  = [dic objectForKey:@"sex"];
                model.age  = [dic objectForKey:@"age"];
                model.office_build  = [dic objectForKey:@"office_build"];
                
                [memberArray addObject:model];
            }
            respModel.members = memberArray;
            
            respModel.notice = [body safeObjectForKey:@"notice"];

            respModel.members_count = [body safeObjectForKey:@"members_count"];

        }
    }
    MQQLog(@"RespImGroupMemberInfos=%@",[resultData description]);
    
    return respModel;
}
@end
