//
//  HttpUserVoucherList.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserVoucherList.h"
#import "ApiParseUserVoucherList.h"
#import "RespUserVoucherListModel.h"
#import "ReqUserVoucherListModel.h"
#import "VoucherModel.h"
#import "Toast+UIView.h"
#import "FDCouponsViewController.h"
#import "HQCouponsSelectViewController.h"

@implementation HttpUserVoucherList
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

/**
 *  抵扣券列表
 *
 */
- (void)loadUserCouponsListFirst:(FDCouponsViewController *)controller{
    [controller.activity startAnimating];
    ReqUserVoucherListModel *reqModel=[[ReqUserVoucherListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.people = @"0";
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseUserVoucherList *request=[[ApiParseUserVoucherList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserVoucherListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.vouchers != nil && [paseData.vouchers  count] != 0) {
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.vouchers;
                [controller.tableView reloadData];
            }else{
                [controller reloadDataNULL:@"无可用抵扣券" imageName:@"null_coupons"];
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page = 0;
        }
        if (paseData.vouchers.count<8) {
            controller.tableView.footer.hidden = YES;
            
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.activity  stopAnimating];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.activity  stopAnimating];
        controller.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];


}

- (void)loadUserCouponsListTop:(FDCouponsViewController *)controller{
    controller.page = 1;
    ReqUserVoucherListModel *reqModel=[[ReqUserVoucherListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.people = @"0";
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseUserVoucherList *request=[[ApiParseUserVoucherList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserVoucherListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.vouchers != nil && [paseData.vouchers  count] != 0) {
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.vouchers;
                [controller.tableView reloadData];
            }else{
                
            }
            [controller reloadDataNULL:@"无可用抵扣券" imageName:@"null_coupons"];
        }else{
            controller.page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        [controller.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.header endRefreshing];
        controller.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    

}

- (void)loadUserCouponsListMore:(FDCouponsViewController *)controller{
    controller.page += 1;
    ReqUserVoucherListModel *reqModel=[[ReqUserVoucherListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.people = @"0";
    ApiParseUserVoucherList *request=[[ApiParseUserVoucherList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserVoucherListModel *paseData=[request parseData:json];
        [controller.tableView.footer endRefreshing];
        if ([paseData.code isEqualToString:@"1"]) {
            [controller.datyArray addObjectsFromArray:paseData.vouchers];
            [controller.tableView reloadData];
            
            if (paseData.vouchers.count<8) {
                controller.tableView.footer.hidden = YES;
//                [SVProgressHUD showImage:nil status:@"没有更多了！"];
                [controller.view makeToast:@"没有更多抵扣券了！"];
                
            }else{
                controller.tableView.footer.hidden = NO;
            }
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page = 0;
            
        }
        
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
        controller.page = 0;
        
    }];

}

- (void)loadCouponsSelectViewControllerListMore:(HQCouponsSelectViewController *)controller{
    controller.page += 1;
    ReqUserVoucherListModel *reqModel=[[ReqUserVoucherListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.people = controller.people;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.meal_id = controller.meal_id;
    reqModel.merchant_id = controller.merchant_id;
    ApiParseUserVoucherList *request=[[ApiParseUserVoucherList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserVoucherListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.vouchers.count==0||paseData.vouchers==nil) {
                
            }else{
                [controller.dataArray addObjectsFromArray:paseData.vouchers];
                [controller.tableView reloadData];
            }
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page -=1;
        }
        [controller.tableView.footer endRefreshing];
        if (paseData.vouchers.count<8) {
            controller.tableView.footer.hidden = YES;
            //[SVProgressHUD showImage:nil status:@"没有更多抵扣券了！"];
            [controller.view makeToast:@"没有更多抵扣券了！"];
        }else{
            controller.tableView.footer.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        controller.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];
    

}

- (void)loadUserVoucherList:(HQCouponsSelectViewController *)controller{
    ReqUserVoucherListModel *reqModel=[[ReqUserVoucherListModel alloc]init];
    reqModel.page = controller.page;
    reqModel.people = controller.people;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.meal_id = controller.meal_id;
    reqModel.merchant_id = controller.merchant_id;
    ApiParseUserVoucherList *request=[[ApiParseUserVoucherList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserVoucherListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.vouchers.count==0||paseData.vouchers==nil) {
                
            }else{
                [controller.dataArray removeAllObjects];
                
                [controller.dataArray addObjectsFromArray:paseData.vouchers];
                [controller.tableView reloadData];
            }
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.page -=1;
        }
        [controller.tableView.header endRefreshing];
        if (paseData.vouchers.count<8) {
            controller.tableView.footer.hidden = YES;
           
        }else{
            controller.tableView.footer.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.header endRefreshing];
        controller.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];

}

@end
