//
//  ApiUserIndustryCategory.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiUserIndustryCategory.h"
#import "ReqUserIndustryCategoryModel.h"
#import "RespUserIndustryCategoryModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "OccupationModel.h"

@implementation ApiUserIndustryCategory

-(RequestModel *)requestData:(ReqUserIndustryCategoryModel *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_INDUSTRY_CATGEGORY];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserIndustryCategoryModel=%@",[self.datas description]);
    return requestModel;
}

-(RespUserIndustryCategoryModel *)parseData:(id)resultData
{
    RespUserIndustryCategoryModel *respModel=[[RespUserIndustryCategoryModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            NSMutableArray *occupationItem=[body safeObjectForKey:@"occupation"];
            NSMutableArray *occupation=[NSMutableArray array];
            
            for (NSDictionary *item in occupationItem) {
                OccupationModel *growUpModel = [[OccupationModel alloc]init];
                growUpModel.name = [item safeObjectForKey:@"name"];
                growUpModel.children = [item safeObjectForKey:@"children"];
                [occupation addObject:growUpModel];
                
            }
            
            respModel.occupation = occupation;
        }
    }
    MQQLog(@"RespUserIndustryCategoryModel=%@",[resultData description]);
    
    return respModel;
}
@end
