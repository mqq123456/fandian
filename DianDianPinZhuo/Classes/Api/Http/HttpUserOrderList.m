//
//  HttpUserOrderList.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserOrderList.h"
#import "ApiParseUserOrderList.h"
#import "RespUserOrderListModel.h"
#import "ReqUserOrderListModel.h"
#import "Toast+UIView.h"
#import "FDMyOrderViewController.h"
#import "FDOrderListFrame.h"
#import "OrderModel.h"
@implementation HttpUserOrderList
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


- (void)loadUserOrderListFirst:(FDMyOrderViewController *)controller{

    [controller.activity startAnimating];
    
    ReqUserOrderListModel *reqModel=[[ReqUserOrderListModel alloc]init];
    if (controller.state) {
        reqModel.state = controller.state;
    }
    [controller.datyArray removeAllObjects];
    reqModel.page = controller.page;
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseUserOrderList *request=[[ApiParseUserOrderList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.orders.count==0||paseData.orders==nil) {
                
                if ([controller.state isEqualToString:@"-2"]) {
                    [controller reloadDataNULL:@"没有退款订单！" imageName:@"null_order"];
                }else if ([controller.state isEqualToString:@"1"]){
                    [controller reloadDataNULL:@"没有待使用订单！" imageName:@"null_order"];
                }else if ([controller.state isEqualToString:@"2"]){
                    [controller reloadDataNULL:@"没有待评价订单！" imageName:@"null_order"];
                }else if ([controller.state isEqualToString:@"3"]){
                    [controller reloadDataNULL:@"没有已完成订单！" imageName:@"null_order"];
                }else if ([controller.state isEqualToString:@"0"]){
                    [controller reloadDataNULL:@"没有待付款订单！" imageName:@"null_order"];
                }else{
                    [controller reloadDataNULL:@"还没下过订单呢，赶紧去试试吧！" imageName:@"null_order"];
                }
                
            }else{
                [controller.datyArray removeAllObjects];
                [controller.datyArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.orders]];
                //controller.datyArray=paseData.orders;
                [controller.tableView reloadData];
                if (paseData.orders.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }
            }
            
        }else{
            controller.page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        [controller.activity stopAnimating];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.activity stopAnimating];
        controller.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];

}

/**
 *  上拉加载
 *
 */
- (void)loadUserOrderMore:(FDMyOrderViewController *)controller{
    controller.page += 1;
    ReqUserOrderListModel *reqModel=[[ReqUserOrderListModel alloc]init];
    reqModel.page = controller.page;
    if (controller.state) {
        reqModel.state = controller.state;
    }
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseUserOrderList *request=[[ApiParseUserOrderList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderListModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            if (paseData.orders.count==0||paseData.orders==nil) {
                //[SVProgressHUD showImage:nil status:@"没有更多订单了！"];
            }else{
                //[controller.datyArray addObjectsFromArray:paseData.orders];
                [controller.datyArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.orders]];
                [controller.tableView reloadData];
            }
            if (paseData.orders.count<8) {
                controller.tableView.footer.hidden = YES;
//                [SVProgressHUD showImage:nil status:@"没有更多订单了！"];
                [controller.view makeToast:@"没有更多了！"];
            }else{
                controller.tableView.footer.hidden = NO;
            }
            
        }else{
            controller.page-=1;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        [controller.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.footer endRefreshing];
        controller.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];

}
/**
 *  下拉加载
 *
 */
- (void)loadUserOrderTop:(FDMyOrderViewController *)controller{
    controller.page = 1;
    if (self.isCommentBack) {
        controller.tableView.footer.hidden = YES;
        [controller.datyArray removeAllObjects];
        [controller.tableView reloadData];
    }
    ReqUserOrderListModel *reqModel=[[ReqUserOrderListModel alloc]init];
    reqModel.page = controller.page;
    if (controller.state) {
        reqModel.state = controller.state;
    }
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseUserOrderList *request=[[ApiParseUserOrderList alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserOrderListModel *paseData=[request parseData:json];
        
        if (paseData.orders.count==0||paseData.orders==nil) {
            [controller.datyArray removeAllObjects];
            
        }else{
            [controller.datyArray removeAllObjects];
            //controller.datyArray=paseData.orders;
            [controller.datyArray addObjectsFromArray:[self stausFramesWithStatuses:paseData.orders]];
            [controller.tableView reloadData];
            
        }
        if (paseData.orders.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }

        [controller.tableView.header endRefreshing];
        if ([controller.state isEqualToString:@"-2"]) {
            [controller reloadDataNULL:@"没有退款订单！" imageName:@"null_order"];
        }else if ([controller.state isEqualToString:@"1"]){
            [controller reloadDataNULL:@"没有待使用订单！" imageName:@"null_order"];
        }else if ([controller.state isEqualToString:@"2"]){
            [controller reloadDataNULL:@"没有待评价订单！" imageName:@"null_order"];
        }else if ([controller.state isEqualToString:@"3"]){
            [controller reloadDataNULL:@"没有已完成订单！" imageName:@"null_order"];
        }else if ([controller.state isEqualToString:@"0"]){
            [controller reloadDataNULL:@"没有待付款订单！" imageName:@"null_order"];
        }else{
            [controller reloadDataNULL:@"还没下过订单呢，赶紧去试试吧！" imageName:@"null_order"];
        }

    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [controller.tableView.header endRefreshing];
        
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    

}

- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (OrderModel *status in statuses) {
        FDOrderListFrame *f = [[FDOrderListFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}



@end
