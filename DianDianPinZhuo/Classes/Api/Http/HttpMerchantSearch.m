//
//  HttpMerchantSearch.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantSearch.h"
#import "ApiParseMerchantSearch.h"
#import "ReqMerchantSearchModel.h"
#import "RespMerchantSearchModel.h"
#import "MerchantModel.h"
#import "HQHttpTool.h"
#import "HQConst.h"
#import "AdsModel.h"
#import "AdView.h"
#import "FDWebViewController.h"
#import "FDTopicMerchantListFram.h"
#import "HttpUserBannerNotify.h"
#import "Toast+UIView.h"
#import "FDMerchantListViewController.h"

@interface HttpMerchantSearch ()

@property (nonatomic ,assign) int page;
@property (nonatomic ,copy) NSString *max_distance;

@end
@implementation HttpMerchantSearch
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

- (void)merchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller{
//  controller.tableView.footer.hidden = YES;
    self.page = 1;
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.meal_id = meal_id;
    reqModel.meal_date = meal_date;
    reqModel.people = people;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.max_distance = @"0";
    
    reqModel.is_bz = [NSString stringWithFormat:@"%d",controller.is_bz];
    
    
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];
    request.ApiUrl = self.ApiUrl;
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespMerchantSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            controller.soldout_hint = paseData.soldout_hint;
            if (paseData.merchants!=nil&&paseData.merchants.count!=0) {//如果数组不为空
                _max_distance = paseData.max_distance;
                [controller.datyArray removeAllObjects];
                
                //                [controller.datyArray addObjectsFromArray:paseData.merchants];
                
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.merchants];
                [controller.datyArray addObjectsFromArray:newFrames];
                
                
                [controller.tableView reloadData];
                
            }else{
                
            }
            if (paseData.merchants.count<8) {
                controller.tableView.footer.hidden = YES;
            }else{
                controller.tableView.footer.hidden = NO;
            }
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page = 0;
        }
        if ([paseData.meal_status intValue]>1) {
            
            [SVProgressHUD showImage:nil status:paseData.meal_desc];
            
        }
        [controller reloadDataNULL:@"没有找到符合条件的餐厅" imageName:@"merchantlist_null"];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.page = 0;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
        
    }];
    
    
}
- (void)MJRefreshTopmerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller{
    self.page = 1;
    _max_distance = @"0";
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.meal_id = meal_id;
    reqModel.meal_date = meal_date;
    reqModel.people = people;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.max_distance = _max_distance;
    
    reqModel.is_bz = [NSString stringWithFormat:@"%d",controller.is_bz];
    
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];
    request.ApiUrl = self.ApiUrl;
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespMerchantSearchModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            controller.soldout_hint = paseData.soldout_hint;
            
            if (paseData.merchants!=nil&&paseData.merchants.count!=0) {
                [controller.datyArray removeAllObjects];
                //                [controller.datyArray addObjectsFromArray:paseData.merchants];
                NSArray *newFrames = [self stausFramesWithStatuses:paseData.merchants];
                [controller.datyArray addObjectsFromArray:newFrames];
                
                _max_distance = paseData.max_distance;
                [controller.tableView reloadData];
                
            }else{
                [controller reloadDataNULL:@"没有找到符合条件的餐厅" imageName:@"merchantlist_null"];
            }
            
        }else{
            [controller.tableView.header endRefreshing];
            self.page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.tableView.header endRefreshing];
        if (paseData.merchants.count<8) {
            controller.tableView.footer.hidden = YES;
        }else{
            controller.tableView.footer.hidden = NO;
        }
        if ([paseData.meal_status intValue]>1) {
            
            [SVProgressHUD showImage:nil status:paseData.meal_desc];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"error=%@",[error description]);
        [controller.tableView.header endRefreshing];
        self.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    
    
}
- (void)MJRefreshMoremerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng meal_id:(NSString *)meal_id people:(NSString *)people meal_date:(NSString *)meal_date local:(NSString *)local viewController:(FDMerchantListViewController *)controller{
    
    self.page+=1;
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.meal_id = meal_id;
    reqModel.meal_date = meal_date;
    reqModel.people = people;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.max_distance = _max_distance;
    
    reqModel.is_bz = [NSString stringWithFormat:@"%d",controller.is_bz];
    
    
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];
    request.ApiUrl = self.ApiUrl;
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespMerchantSearchModel *paseData=[request parseData:json];
        [controller.tableView.footer endRefreshing];
        if ([paseData.code isEqualToString:@"1"]) {
            _max_distance = paseData.max_distance;
           controller.soldout_hint = paseData.soldout_hint;
            //[controller.datyArray addObjectsFromArray:paseData.merchants];
            NSArray *newFrames = [self stausFramesWithStatuses:paseData.merchants];
            [controller.datyArray addObjectsFromArray:newFrames];
            
            [controller.tableView reloadData];
            if (paseData.merchants.count<8) {
                controller.tableView.footer.hidden = YES;
                //[SVProgressHUD showImage:nil status:@"没有更多了！"];
                
                [controller.view makeToast:@"没有更多了！"];
                
            }else{
                controller.tableView.footer.hidden = NO;
            }
        }else{
            
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page-=1;
        }
        if ([paseData.meal_status intValue]>1) {
            
            [SVProgressHUD showImage:nil status:paseData.meal_desc];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"error=%@",[error description]);
        [controller.tableView.footer endRefreshing];
        self.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];
    
    
    
}


//- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
//{
//    NSMutableArray *frames = [NSMutableArray array];
//    for (MerchantModel *status in statuses) {
//        FDNearMerchantFrame *f = [[FDNearMerchantFrame alloc] init];
//        f.status = status;
//        [frames addObject:f];
//    }
//    return frames;
//}
//

- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (MerchantModel *status in statuses) {
        FDTopicMerchantListFram *f = [[FDTopicMerchantListFram alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

@end
