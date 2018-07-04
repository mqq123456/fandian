//
//  ApiParseUserGetVoucher.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiParseUserGetVoucher.h"


#import "ReqUserGetVoucher.h"
#import "RespUserGetVoucher.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseUserGetVoucher
-(RequestModel *)requestData:(ReqUserGetVoucher *)reqModel
{
    [self.datas setSafeObject:reqModel.phone forKey:@"phone"];
    [self.datas setSafeObject:reqModel.vacancy_id forKey:@"vacancy_id"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_USER_GET_VOUCHER];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqUserGetVoucher=%@",[self.datas description]);
    return requestModel;
}

-(RespUserGetVoucher *)parseData:(id)resultData
{
    RespUserGetVoucher *respModel=[[RespUserGetVoucher alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
        }
    }
    MQQLog(@"RespUserGetVoucher=%@",[resultData description]);
    
    return respModel;
}

@end

