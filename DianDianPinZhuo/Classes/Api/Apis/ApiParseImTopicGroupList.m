//
//  ApiParseImTopicGroupList.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseImTopicGroupList.h"
#import "ReqImTopicGroupList.h"
#import "RespImTopicGroupList.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "NotJoinGroupModel.h"
#import "ActiveUserModel.h"
@implementation ApiParseImTopicGroupList
-(RequestModel *)requestData:(ReqImTopicGroupList *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.lat forKey:@"lat"];
    [self.datas setSafeObject:reqModel.lng forKey:@"lng"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_TOPIC_GROUP_LIST];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImTopicGroupList=%@",[self.datas description]);
    return requestModel;
}

-(RespImTopicGroupList *)parseData:(id)resultData
{
    RespImTopicGroupList *respModel=[[RespImTopicGroupList alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            respModel.state = [body safeObjectForKey:@"state"];
            
            NSMutableArray *groupsArray = [NSMutableArray array];
            
            NSMutableArray *groups = [body objectForKey:@"groups"];
            
            for (NSDictionary *dic  in groups) {
                NotJoinGroupModel *model = [[NotJoinGroupModel alloc]init];
                model.group_id  = [dic objectForKey:@"group_id"];
                model.icon  = [dic objectForKey:@"icon"];
                model.name  = [dic objectForKey:@"name"];
                model.group_desc  = [dic objectForKey:@"group_desc"];
                model.notice  = [dic objectForKey:@"notice"];
                model.members_count  = [dic objectForKey:@"members_count"];
                NSMutableArray *activeArray = [NSMutableArray array];
                
                NSMutableArray *activ = [dic objectForKey:@"active_users"];
                for (NSDictionary *user  in activ) {
                    ActiveUserModel *model = [[ActiveUserModel alloc]init];
                    model.kid = [user safeObjectForKey:@"kid"];
                     model.head = [user safeObjectForKey:@"head"];
                    [activeArray addObject:model];
                }
                
                model.active_users  = activeArray;
                [groupsArray addObject:model];
                
            }
            respModel.groups = groupsArray;

        }
    }
    MQQLog(@"RespImTopicGroupList=%@",[resultData description]);
    
    return respModel;
}
@end
