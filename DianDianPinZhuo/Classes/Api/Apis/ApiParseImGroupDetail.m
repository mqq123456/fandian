//
//  ApiParseImGroupDetail.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseImGroupDetail.h"
#import "ReqImGroupDetailModel.h"
#import "RespImGroupDetailModel.h"
#import "RequestModel.h"
#import "MemberModel.h"
#import "HQConst.h"
@implementation ApiParseImGroupDetail
-(RequestModel *)requestData:(ReqImGroupDetailModel *)reqModel
{
    [self.datas setSafeObject:reqModel.group_id forKey:@"group_id"];

    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_IM_GROUP_DETAIL];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqImGroupDetailModel=%@",[self.datas description]);
    return requestModel;
}

-(RespImGroupDetailModel *)parseData:(id)resultData
{
    RespImGroupDetailModel *respModel=[[RespImGroupDetailModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSMutableArray *members = [NSMutableArray array];
            NSDictionary *body=[resultData safeObjectForKey:@"body"];

            NSMutableArray *items = [body safeObjectForKey:@"members"];
            for (NSDictionary *item in items) {
                MemberModel *model = [[MemberModel alloc]init];
                
                model.kid = [item safeObjectForKey:@"kid"];
                model.nick_name = [item safeObjectForKey:@"nick_name"];
                model.icon = [item safeObjectForKey:@"icon"];
                model.people = [item safeObjectForKey:@"people"];
                [members addObject:model];
            }
            respModel.members = members;
            
        }
    }
    MQQLog(@"RespImGroupDetailModel=%@",[resultData description]);
    
    return respModel;
}

@end
