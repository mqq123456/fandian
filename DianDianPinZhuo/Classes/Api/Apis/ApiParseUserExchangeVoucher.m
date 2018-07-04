//
//  ApiParseUserExchangeVoucher.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseUserExchangeVoucher.h"
#import "ReqUserExchangeVoucher.h"
#import "RespUserExchangeVoucher.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseUserExchangeVoucher
-(RequestModel *)requestData:(ReqUserExchangeVoucher *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    
    [self.datas setSafeObject:reqModel.occ_code forKey:@"occ_code"];
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_EXCHANGE_VOUCHER];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserExchangeVoucher=%@",[self.datas description]);
    return requestModel;
}

-(RespUserExchangeVoucher *)parseData:(id)resultData
{
    RespUserExchangeVoucher *respModel=[[RespUserExchangeVoucher alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        
        NSDictionary *body=[resultData safeObjectForKey:@"body"];
        
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        respModel.url = [body objectForKey:@"url"];
        respModel.url_title = [body objectForKey:@"url_title"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespUserExchangeVoucher=%@",[resultData description]);
    
    return respModel;
}

@end
