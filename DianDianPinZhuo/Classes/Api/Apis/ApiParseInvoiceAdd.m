//
//  ApiParseInvoiceAdd.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseInvoiceAdd.h"
#import "ReqInvoiceAddModel.h"
#import "RespInvoiceAddModel.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseInvoiceAdd
-(RequestModel *)requestData:(ReqInvoiceAddModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    [self.datas setSafeObject:reqModel.invoice_amount forKey:@"invoice_amount"];
    [self.datas setSafeObject:reqModel.invoice_title forKey:@"invoice_title"];
    [self.datas setSafeObject:reqModel.invoice_receiver forKey:@"invoice_receiver"];
    [self.datas setSafeObject:reqModel.invoice_province forKey:@"invoice_province"];
    [self.datas setSafeObject:reqModel.invoice_city forKey:@"invoice_city"];
    [self.datas setSafeObject:reqModel.invoice_phone forKey:@"invoice_phone"];
    [self.datas setSafeObject:reqModel.invoice_district forKey:@"invoice_district"];
    [self.datas setSafeObject:reqModel.invoice_address forKey:@"invoice_address"];
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_INVOICE_ADD];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqInvoiceAddModel=%@",[self.datas description]);
    return requestModel;
}

-(RespInvoiceAddModel *)parseData:(id)resultData
{
    RespInvoiceAddModel *respModel=[[RespInvoiceAddModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
           
        }
    }
    MQQLog(@"RespInvoiceAddModel=%@",[resultData description]);
    
    return respModel;
}

@end
