//
//  HttpInvoiceHistory.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpInvoiceHistory.h"
#import "FDInvoiceHistoryCell.h"
#import "ApiParseInvoiceHistory.h"
#import "ReqInvoiceHistoryModel.h"
#import "RespInvoiceHistoryModel.h"
#import "InvoicesModel.h"
#import "HQHttpTool.h"
#import "HQConst.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "FDInvoiceHistoryViewController.h"
@interface HttpInvoiceHistory ()

@property (nonatomic ,assign) int page;

@end
@implementation HttpInvoiceHistory
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

- (void)loadFristController:(FDInvoiceHistoryViewController *)controller{
    [controller.activity startAnimating];
    ReqInvoiceHistoryModel *reqModel=[[ReqInvoiceHistoryModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = 1;
    
    ApiParseInvoiceHistory *request =[[ApiParseInvoiceHistory alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespInvoiceHistoryModel *paseData =[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.invoices != nil && [paseData.invoices  count] != 0) {
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.invoices;
                [controller.tableView reloadData];
            }else{
                [controller reloadDataNULL:@"无开票历史" imageName:@"content_ico_kq"];
            }
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        [controller.activity stopAnimating];
        if (paseData.invoices.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
    } failure:^(NSError *error) {
        [controller.activity stopAnimating];
        MQQLog(@"error -%@",error);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];

}
- (void)MJRefreshTopController:(FDInvoiceHistoryViewController *)controller{
    self.page = 1;
    ReqInvoiceHistoryModel *reqModel=[[ReqInvoiceHistoryModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    
    ApiParseInvoiceHistory *request =[[ApiParseInvoiceHistory alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespInvoiceHistoryModel *paseData =[request parseData:json];
     

        if ([paseData.code isEqualToString:@"1"]) {
            controller.datyArray = paseData.invoices;
            if (paseData.invoices.count==0) {
                [controller reloadDataNULL:@"无开票历史" imageName:@"content_ico_kq"];
            }

            [controller.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        [controller.tableView.header endRefreshing];
        if (paseData.invoices.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [controller.tableView.header endRefreshing];
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];

    
}
- (void)MJRefreshMoreController:(FDInvoiceHistoryViewController *)controller{
    self.page+=1;
    ReqInvoiceHistoryModel *reqModel=[[ReqInvoiceHistoryModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    
    ApiParseInvoiceHistory *request =[[ApiParseInvoiceHistory alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespInvoiceHistoryModel *paseData =[request parseData:json];
        [controller.tableView.footer endRefreshing];
        
        if ([paseData.code isEqualToString:@"1"]) {
            
            [controller.datyArray removeAllObjects];
            controller.datyArray=paseData.invoices;
            [controller.tableView reloadData];
            
            if (paseData.invoices.count<8) {
                controller.tableView.footer.hidden = YES;
                
                [controller.view makeToast:@"没有更多了！"];
                
            }else{
                controller.tableView.footer.hidden = NO;
            }
        }else{
            self.page-=1;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [controller.tableView.footer endRefreshing];
        self.page-=1;
        MQQLog(@"error -%@",error);
    }];
    
}
@end
