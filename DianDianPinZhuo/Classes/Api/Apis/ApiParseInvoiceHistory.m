//
//  ApiParseInvoiceHistory.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ApiParseInvoiceHistory.h"
#import "ReqInvoiceHistoryModel.h"
#import "RespInvoiceHistoryModel.h"
#import "RequestModel.h"
#import "InvoicesModel.h"
#import "HQConst.h"
@implementation ApiParseInvoiceHistory
-(RequestModel *)requestData:(ReqInvoiceHistoryModel *)reqModel
{
    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];
    if (reqModel.page) {
        [self.datas setSafeObject:[NSString stringWithFormat:@"%i",reqModel.page] forKey:@"page"];
    }
    
    //加密
    SBJsonWriter* dataWrite = [[SBJsonWriter alloc] init];
    NSString* dataString = [dataWrite stringWithFragment:self.datas];
    dataString=[dataString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSData*encryData=[[dataString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:[HQDefaultTool getKey]];
    NSString* encryptString = [[NSString alloc] initWithData:[NewGTMBase64 encodeData:encryData] encoding:NSUTF8StringEncoding];
    
    [self.params setSafeObject:encryptString forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_INVOICE_HISTORY];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqInvoiceHistoryModel=%@",[self.datas description]);
    return requestModel;
}

-(RespInvoiceHistoryModel *)parseData:(id)resultData
{
    RespInvoiceHistoryModel *respModel=[[RespInvoiceHistoryModel alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            
            NSDictionary *body=[resultData safeObjectForKey:@"body"];
            
            NSMutableArray *invoices =[NSMutableArray array];
            NSMutableArray *items = [body safeObjectForKey:@"invoices"];
            for (NSDictionary *item in items) {
                InvoicesModel *model = [[InvoicesModel alloc]init];
                model.amount = [item safeObjectForKey:@"amount"];
                model.create_time = [item safeObjectForKey:@"create_time"];
                model.state = [item safeObjectForKey:@"state"];
                
                [invoices addObject:model];
            }
            respModel.invoices = invoices;
            
            
        }
    }
    MQQLog(@"RespInvoiceHistoryModel=%@",[resultData description]);
    
    return respModel;
}

@end
