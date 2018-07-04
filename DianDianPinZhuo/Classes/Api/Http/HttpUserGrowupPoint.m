//
//  HttpUserGrowupPoint.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserGrowupPoint.h"
#import "FDGrowingCell.h"
#import "ApiParseUserGrowupPoint.h"
#import "ReqUserGrowupPointModel.h"
#import "RespUserGrowupPointModel.h"
#import "GrowUpDetailModel.h"
#import "FDGrowingHeadView.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "MJRefresh.h"
#import "Toast+UIView.h"
#import "FDGrowingViewController.h"
@interface HttpUserGrowupPoint ()

@property (nonatomic ,assign) int page;

@end

@implementation HttpUserGrowupPoint
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

- (void)MJRefreshTopPage:(int)page controller:(FDGrowingViewController *)controller{
    self.page = 1;
    ReqUserGrowupPointModel *reqModel =[[ReqUserGrowupPointModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = page;
    ApiParseUserGrowupPoint *request=[[ApiParseUserGrowupPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserGrowupPointModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text = [NSString stringWithFormat:@"%@",paseData.point];
            controller.tableViewHeader.growing_hint.text = paseData.hint;
            if (paseData.details != nil && [paseData.details  count] != 0) {
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.details;
                [controller.tableView reloadData];
                [controller reloadDataNULL:@"无成长值记录" imageName:@"content_ico_czz"];
                
            }else{
                
                [controller reloadDataNULL:@"无成长值记录" imageName:@"content_ico_czz"];
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page=0;
        }
        [controller.tableView.header endRefreshing];
        if (paseData.details.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        self.page=0;
        [controller.tableView.header endRefreshing];
        MQQLog(@"%@",error);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
}

- (void)loadFristPage:(int)page controller:(FDGrowingViewController *)controller{
    [controller.activity startAnimating];
    ReqUserGrowupPointModel *reqModel =[[ReqUserGrowupPointModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = page;
    
    ApiParseUserGrowupPoint *request=[[ApiParseUserGrowupPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserGrowupPointModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text = [NSString stringWithFormat:@"%@",paseData.point];
            controller.tableViewHeader.growing_hint.text = paseData.hint;
            if (paseData.details != nil && [paseData.details  count] != 0) {
                [controller.datyArray removeAllObjects];
                controller.datyArray=paseData.details;
                [controller.tableView reloadData];
                
            }else{
                
                controller.nullView.nullImgView.y += 150;
                controller.nullView.desLabel.y += 150;
                
                [controller reloadDataNULL:@"无成长值记录" imageName:@"content_ico_czz"];
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        if (paseData.details.count<8) {
            controller.tableView.footer.hidden = YES;
            
        }else{
            controller.tableView.footer.hidden = NO;
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        [controller.activity stopAnimating];
        controller.nullView.nullImgView.y += 150;
        controller.nullView.desLabel.y += 150;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
        MQQLog(@"%@",error);
    }];
}
- (void)MJRefreshMorePage:(int)page controller:(FDGrowingViewController *)controller{
    self.page += 1;
    ReqUserGrowupPointModel *reqModel =[[ReqUserGrowupPointModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    ApiParseUserGrowupPoint *request=[[ApiParseUserGrowupPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserGrowupPointModel *paseData = [request parseData:json];
        [controller.tableView.footer endRefreshing];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text = [NSString stringWithFormat:@"%@",paseData.point];
            controller.tableViewHeader.growing_hint.text = paseData.hint;
            if (paseData.details != nil && [paseData.details  count] != 0) {
                
                [controller.datyArray addObjectsFromArray:paseData.details];
                [controller.tableView reloadData];
                
            }else{
                
            }
            if (paseData.details.count<8) {
                controller.tableView.footer.hidden = YES;
//                [SVProgressHUD showImage:nil status:@"没有更多了！"];
                [controller.view makeToast:@"没有更多了！"];
                
            }else{
                controller.tableView.footer.hidden = NO;
            }
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page-=1;
        }
    } failure:^(NSError *error) {
        self.page-=1;
        [controller.tableView.footer endRefreshing];
        MQQLog(@"%@",error);
    }];
}

@end
