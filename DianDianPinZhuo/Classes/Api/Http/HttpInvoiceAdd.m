//
//  HttpInvoiceAdd.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpInvoiceAdd.h"
#import "ApiParseInvoiceAdd.h"
#import "ReqInvoiceAddModel.h"
#import "RespInvoiceAddModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDInvoiceHistoryViewController.h"
#import "HQHttpTool.h"
#import "FDInvoiceViewController.h"

@implementation HttpInvoiceAdd
#pragma mark -  获取单例对象
static id _instace;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

- (void)invoiceAddWithReqInvoiceAddModel:(ReqInvoiceAddModel *)requestModel viewController:(FDInvoiceViewController *)viewController{
    
    ApiParseInvoiceAdd *request =[[ApiParseInvoiceAdd alloc]init];
    
    RequestModel *reqModel =[request requestData:requestModel];
    
    [HQHttpTool post:reqModel.url params:reqModel.parameters success:^(id json) {
        RespInvoiceAddModel *paseData =[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            FDInvoiceHistoryViewController *historyVC=[[FDInvoiceHistoryViewController alloc]init];
            
            [viewController.navigationController pushViewController:historyVC animated:YES];
            [SVProgressHUD showImage:nil status:@" 新增发票成功 "];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"添加发票失败%@",error);
        [SVProgressHUD showImage:nil status:@"新增发票失败！"];
    }];
    
    
}
@end
