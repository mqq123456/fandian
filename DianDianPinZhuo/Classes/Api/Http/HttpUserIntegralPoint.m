//
//  HttpUserIntegralPoint.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserIntegralPoint.h"
#import "RespUserIntegralPoint.h"
#import "ReqUserIntegralPoint.h"
#import "ApiUserIntegralPoint.h"
#import "RequestModel.h"
#import "FDIntegralViewController.h"
@interface HttpUserIntegralPoint ()

@property (nonatomic ,assign) int page;

@end
@implementation HttpUserIntegralPoint

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


- (void)MJRefreshTopPage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left{
    self.page = 1;
    ReqUserIntegralPoint *reqModel =[[ReqUserIntegralPoint alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = page;
     ApiUserIntegralPoint*request=[[ApiUserIntegralPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserIntegralPoint *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text=[NSString stringWithFormat:@"%@",paseData.point];
            if (left == 1) {
                if (paseData.incomeArray != nil && [paseData.incomeArray  count] != 0) {
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.incomeArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无收入记录" imageName:@"content_ico_czz"];

                }else{
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.incomeArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无收入纪录" imageName:@"content_ico_czz"];
                }
                
                if (paseData.incomeArray.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }

            }else{
                if (paseData.defrayArray != nil && [paseData.defrayArray  count] != 0) {
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.defrayArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无支出记录" imageName:@"content_ico_czz"];
                    
                }else{
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.defrayArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无支出纪录" imageName:@"content_ico_czz"];
                }
                
                if (paseData.defrayArray.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }

            
            }
            
            [controller.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page=0;
        }
        [controller.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        self.page=0;
        [controller.tableView.header endRefreshing];
        MQQLog(@"%@",error);
        if (IPHONE4) {
            controller.nullView.nullImgView.y = 270;
            controller.nullView.desLabel.y = 375;
        }else if (IPhone6Plus){
            controller.nullView.nullImgView.y = 360;
            controller.nullView.desLabel.y = 465;
        }else{
            controller.nullView.nullImgView.y = 320;
            controller.nullView.desLabel.y = 425;
        }
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
}

- (void)loadFristPage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left{
    [controller.activity startAnimating];
    ReqUserIntegralPoint *reqModel =[[ReqUserIntegralPoint alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = page;
    
    ApiUserIntegralPoint *request=[[ApiUserIntegralPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserIntegralPoint *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text=[NSString stringWithFormat:@"%@",paseData.point];

            if (left == 1) {
                if (paseData.incomeArray != nil && [paseData.incomeArray  count] != 0) {
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.incomeArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无收入记录" imageName:@"content_ico_czz"];
                    
                }else{
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.incomeArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    [controller reloadDataNULL:@"无收入纪录" imageName:@"content_ico_czz"];
                }
                
                if (paseData.incomeArray.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }
                
            }else{
                if (paseData.defrayArray != nil && [paseData.defrayArray  count] != 0) {
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.defrayArray;
                    [controller reloadDataNULL:@"无支出记录" imageName:@"content_ico_czz"];
                    
                }else{
                    [controller.datyArray removeAllObjects];
                    controller.datyArray=paseData.defrayArray;
                    if (IPHONE4) {
                        controller.nullView.nullImgView.y = 270;
                        controller.nullView.desLabel.y = 375;
                    }else if (IPhone6Plus){
                        controller.nullView.nullImgView.y = 360;
                        controller.nullView.desLabel.y = 465;
                    }else{
                        controller.nullView.nullImgView.y = 320;
                        controller.nullView.desLabel.y = 425;
                    }
                    
                    [controller reloadDataNULL:@"无支出纪录" imageName:@"content_ico_czz"];
                }
                
                if (paseData.defrayArray.count<8) {
                    controller.tableView.footer.hidden = YES;
                }else{
                    controller.tableView.footer.hidden = NO;
                }
                
                
            }
            
            [controller.tableView reloadData];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }

        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        [controller.activity stopAnimating];
        if (IPHONE4) {
            controller.nullView.nullImgView.y = 270;
            controller.nullView.desLabel.y = 375;
        }else if (IPhone6Plus){
            controller.nullView.nullImgView.y = 360;
            controller.nullView.desLabel.y = 465;
        }else{
            controller.nullView.nullImgView.y = 320;
            controller.nullView.desLabel.y = 425;
        }
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
        MQQLog(@"%@",error);
    }];
}
- (void)MJRefreshMorePage:(int)page controller:(FDIntegralViewController *)controller income:(NSInteger)left{
    self.page += 1;
    ReqUserIntegralPoint *reqModel =[[ReqUserIntegralPoint alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.page = self.page;
    ApiUserIntegralPoint *request=[[ApiUserIntegralPoint alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserIntegralPoint *paseData = [request parseData:json];
        [controller.tableView.footer endRefreshing];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.tableViewHeader.growing_num.text=[NSString stringWithFormat:@"%@",paseData.point];

            
            if (left == 1) {
                if (paseData.incomeArray != nil && [paseData.incomeArray  count] != 0) {
                    [controller.datyArray addObjectsFromArray:paseData.incomeArray];
                    [controller.tableView reloadData];
                    [controller reloadDataNULL:@"无收入记录" imageName:@"content_ico_czz"];
                    if (paseData.incomeArray.count<8) {
                        controller.tableView.footer.hidden = YES;
                    }else{
                        controller.tableView.footer.hidden = NO;
                    }
                }else{
                    if (paseData.incomeArray.count<8) {
                        controller.tableView.footer.hidden = YES;
                    }else{
                        controller.tableView.footer.hidden = NO;
                    }
                }

                
            }else{
                if (paseData.defrayArray != nil && [paseData.defrayArray  count] != 0) {

                    [controller.datyArray addObjectsFromArray:paseData.incomeArray];
                    [controller.tableView reloadData];
                    [controller reloadDataNULL:@"无支出记录" imageName:@"content_ico_czz"];
                    if (paseData.defrayArray.count<8) {
                        controller.tableView.footer.hidden = YES;
                    }else{
                        controller.tableView.footer.hidden = NO;
                    }
                }else{
                    if (paseData.defrayArray.count<8) {
                        controller.tableView.footer.hidden = YES;
                    }else{
                        controller.tableView.footer.hidden = NO;
                    }
                    
                }
                
     
                
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
