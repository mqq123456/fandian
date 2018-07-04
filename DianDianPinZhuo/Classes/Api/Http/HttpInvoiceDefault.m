//
//  HttpInvoiceDefault.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpInvoiceDefault.h"
#import "ApiParseInvoiceDefault.h"
#import "ReqInvoiceDefaultModel.h"
#import "RespInvoiceDefaultModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "FDInvoiceViewController.h"
@implementation HttpInvoiceDefault
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

- (void)invoiceDefaultWithViewController:(FDInvoiceViewController *)viewController{
    [viewController.activity startAnimating];
    ReqInvoiceDefaultModel *reqModel=[[ReqInvoiceDefaultModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseInvoiceDefault *request =[[ApiParseInvoiceDefault alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        viewController.defaultModel =[request parseData:json];
        if ([viewController.defaultModel.code isEqualToString:@"1"]) {
            
            viewController.invoice_amount = viewController.defaultModel.invoice_amount;
            [viewController.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:viewController.defaultModel.desc];
        }
        
        [viewController.activity stopAnimating];
        
    } failure:^(NSError *error) {
        [viewController.activity stopAnimating];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
        MQQLog(@"error -%@",error);
    }];
    
}
@end
