//
//  HttpMerchantSecKillDetail.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantSecKillDetail.h"
#import "RequestModel.h"
#import "ReqMerchantSeckillDetailModel.h"
#import "RespMerchantSeckillDetailModel.h"
#import "ApiParseMerchantSecKillDetail.h"
#import "HQHttpTool.h"
#import "MenusModel.h"
#import "ImagesModel.h"

@implementation HttpMerchantSecKillDetail
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

#pragma mark - 加载数据

- (void)loadMerchantDetail:(FDKillDetailViewController *)controller{
//    ReqMerchantSeckillDetailModel *reqModel=[[ReqMerchantSeckillDetailModel alloc]init];
//    if (controller.model) {
//        reqModel.merchant_id = [NSString stringWithFormat:@"%d" ,controller.model.merchant_id];
//    }
//    
//    reqModel.local_lat = controller.latString;
//    reqModel.local_lng = controller.lngString;
//    reqModel.local = @"1";
//    reqModel.meal_id = controller.meal_id;
//    
//    ApiParseMerchantSecKillDetail *request=[[ApiParseMerchantSecKillDetail alloc]init];
//    RequestModel *requestModel=[request requestData:reqModel];
//    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
//        
//        RespMerchantSeckillDetailModel *paseData=[request parseData:json];
//        
//        if ([paseData.code isEqualToString:@"1"]) {
//            
//            [controller.imagesURL removeAllObjects];
//            [controller.menuArray removeAllObjects];
//            [controller.commentArray removeAllObjects];
//            [controller.categoryArray removeAllObjects];
//            [controller.merchantArray removeAllObjects];
//            
//            controller.commentArray = paseData.comments;
//            for (MenusModel *model in paseData.menus) {
//                NSArray *array = [model.menu_detail componentsSeparatedByString:@","];
//                [controller.menuArray addObject:array];
//                [controller.categoryArray addObject:model.menu_name];
//                
//            }
//            for (ImagesModel *imageModel in paseData.imgs) {
//                [controller.imagesURL addObject:imageModel.url];
//            }
//            [controller.tableView reloadData];
//        }
//        
//    } failure:^(NSError *error) {
//        MQQLog(@"==%@",[error description]);
//        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
//        
//    }];
    
}

@end
