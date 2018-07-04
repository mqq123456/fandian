//
//  HttpMerchantSearch.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantSearchNear.h"
#import "ApiParseMerchantSearch.h"
#import "ReqMerchantSearchModel.h"
#import "RespMerchantSearchModel.h"
#import "MerchantModel.h"
#import "HQHttpTool.h"
#import "HQConst.h"
#import "FDNearMerchantFrame.h"
#import "Toast+UIView.h"
#import "FDNearMerchantViewController.h"

@interface HttpMerchantSearchNear ()

@property (nonatomic ,assign) int page;
@property (nonatomic ,copy) NSString *max_distance;

@end
@implementation HttpMerchantSearchNear
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

- (void)merchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller{
    controller.tableView.footer.hidden = YES;
    self.page = 1;
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.max_distance = @"0";
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];

    RequestModel *requestModel=[request requestData:reqModel];

    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //显示第0页
        if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] intValue]!=1) {
//            [SVProgressHUD dismiss];
            [FDLoadingGifHUD dismiss];
        }


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
           
            if (paseData.merchants.count<=0) {
                controller.footer.statusLabel.text = @"附近已经没有更多餐厅";
                controller.footer.userInteractionEnabled = NO;
            }else{
                controller.footer.statusLabel.text = @"查看更多餐厅";
                controller.footer.userInteractionEnabled = YES;
            }
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page = 0;
        }
      
        [controller reloadDataNULL:@"附近暂无餐厅 敬请期待" imageName:@"merchantlist_null"];
        
    } failure:^(NSError *error) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //显示第0页
        if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] intValue]!=1) {
            [SVProgressHUD dismiss];
            [FDLoadingGifHUD dismiss];
        }

        
        self.page = 0;
        MQQLog(@"error=%@",[error description]);
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
        
    }];
    
    
}
- (void)MJRefreshTopmerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller{
    
   
    self.page = 1;
    _max_distance = @"0";
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.max_distance = _max_distance;
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];
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
               
            }
            
        }else{
            [controller.tableView.header endRefreshing];
            self.page = 0;
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
      
        [controller.tableView.header endRefreshing];
        if (paseData.merchants.count<=0) {
            controller.footer.statusLabel.text = @"附近已经没有更多餐厅";
            controller.footer.userInteractionEnabled = NO;
        }else{
            controller.footer.statusLabel.text = @"查看更多餐厅";
            controller.footer.userInteractionEnabled = YES;
        }
        [controller reloadDataNULL:@"附近暂无餐厅 敬请期待" imageName:@"merchantlist_null"];
    } failure:^(NSError *error) {
        MQQLog(@"error=%@",[error description]);
        [controller.tableView.header endRefreshing];
        self.page = 0;
        [controller reloadDataNULL:@"联网失败，请检查网络" imageName:@"network_fail_out_nor"];
    }];
    
    
}
- (void)MJRefreshMoremerchantSearchWithLat:(NSString *)lat lng:(NSString *)lng local_lat:(NSString *)local_lat local_lng:(NSString *)local_lng local:(NSString *)local viewController:(FDNearMerchantViewController *)controller{
    
    self.page+=1;
    ReqMerchantSearchModel *reqModel=[[ReqMerchantSearchModel alloc]init];
    reqModel.lng = lng;
    reqModel.lat = lat;
    reqModel.local_lat = local_lat;
    reqModel.local_lng = local_lng;
    reqModel.page = self.page;
    reqModel.local= local;
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.max_distance = _max_distance;
    
    
    ApiParseMerchantSearch *request=[[ApiParseMerchantSearch alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespMerchantSearchModel *paseData=[request parseData:json];
        [controller.tableView.footer endRefreshing];
        [controller.footer endRefreshing];
        if ([paseData.code isEqualToString:@"1"]) {
            _max_distance = paseData.max_distance;
            controller.soldout_hint = paseData.soldout_hint;
            //[controller.datyArray addObjectsFromArray:paseData.merchants];
            NSArray *newFrames = [self stausFramesWithStatuses:paseData.merchants];
            [controller.datyArray addObjectsFromArray:newFrames];
            
            [controller.tableView reloadData];
            
   
            if (paseData.merchants.count<=0) {
                controller.footer.statusLabel.text = @"附近已经没有更多餐厅";
                controller.footer.userInteractionEnabled = NO;
            }else{
                controller.footer.statusLabel.text = @"查看更多餐厅";
                controller.footer.userInteractionEnabled = YES;
            }
        }else{
            
            [SVProgressHUD showImage:nil status:paseData.desc];
            self.page-=1;
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"error=%@",[error description]);
//        [controller.tableView.footer endRefreshing];
        [controller.footer endRefreshing];
        self.page-=1;
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];
    
    
    
}


- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (MerchantModel *status in statuses) {
        FDNearMerchantFrame *f = [[FDNearMerchantFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}



@end
