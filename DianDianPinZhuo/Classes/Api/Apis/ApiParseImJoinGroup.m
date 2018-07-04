//
//  ApiParseImJoinGroup.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseImJoinGroup.h"


#import "ReqImJoinGroup.h"
#import "RespImJoinGroup.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"

@implementation ApiParseImJoinGroup
-(RequestModel *)requestData:(ReqImJoinGroup *)reqModel
{
    [self.datas setSafeObject:reqModel.group_id forKey:@"group_id"];
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_JOIN_GROUP];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImJoinGroup=%@",[self.datas description]);
    return requestModel;
}

-(RespImJoinGroup *)parseData:(id)resultData
{
    RespImJoinGroup *respModel=[[RespImJoinGroup alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespImJoinGroup=%@",[resultData description]);
    
    return respModel;
}
@end
