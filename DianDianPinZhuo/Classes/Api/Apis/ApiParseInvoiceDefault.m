//
//  ApiParseInvoiceDefault.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseInvoiceDefault.h"
#import "ReqInvoiceDefaultModel.h"
#import "RespInvoiceDefaultModel.h"
#import "RequestModel.h"
#import "HQConst.h"
@implementation ApiParseInvoiceDefault
-(RequestModel *)requestData:(ReqInvoiceDefaultModel *)reqModel
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
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_INVOICE_DEFAULT];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqInvoiceDefaultModel=%@",[self.datas description]);
    return requestModel;
}

-(RespInvoiceDefaultModel *)parseData:(id)resultData
{
    RespInvoiceDefaultModel *respModel=[[RespInvoiceDefaultModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            respModel.invoice_amount = [body safeObjectForKey:@"invoice_amount"];
            respModel.invoice_title = [body safeObjectForKey:@"invoice_title"];
            respModel.invoice_receiver = [body safeObjectForKey:@"invoice_receiver"];
            respModel.invoice_phone = [body safeObjectForKey:@"invoice_phone"];

            respModel.invoice_province = [body safeObjectForKey:@"invoice_province"];
            respModel.invoice_city = [body safeObjectForKey:@"invoice_city"];
            respModel.invoice_district = [body safeObjectForKey:@"invoice_district"];
            respModel.invoice_address = [body safeObjectForKey:@"invoice_address"];
            respModel.invoice_instruction = [body safeObjectForKey:@"invoice_instruction"];
            
            
        }
    }
    MQQLog(@"RespInvoiceDefaultModel=%@",[resultData description]);
    
    return respModel;
}
@end
