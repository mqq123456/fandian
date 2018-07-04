//
//  ApiParseBaseAds.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseBaseAds.h"
#import "RespBaseAds.h"
#import "ReqBaseAds.h"
#import "HQConst.h"
#import "AdsHomeModel.h"
#import "RequestModel.h"

@implementation ApiParseBaseAds

-(RequestModel *)requestData:(ReqBaseAds *)reqModel
{
    [self.datas setSafeObject:reqModel.imei forKey:@"imei"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_ADS];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseAdsModel=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseAds *)parseData:(id)resultData
{
    RespBaseAds *respModel=[[RespBaseAds alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            NSMutableArray *adsArray = [[NSMutableArray alloc] init];
            NSMutableArray *adsItem = [body safeObjectForKey:@"ads"];
            for (NSDictionary *item in adsItem) {
                AdsHomeModel *adsModel = [[AdsHomeModel alloc] init];
                adsModel.ads_id = [item safeObjectForKey:@"id"];
                adsModel.url = [item safeObjectForKey:@"url"];
                adsModel.img  = [item safeObjectForKey:@"img"];
                adsModel.title = [item safeObjectForKey:@"title"];
                [adsArray addObject:adsModel];
            }
            respModel.ads = adsArray;
        }
    }
    MQQLog(@"RespBaseAdsModel=%@",[resultData description]);
    
    return respModel;
    
}


@end
