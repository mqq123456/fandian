//
//  HttpUserIndustryCategory.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserIndustryCategory.h"
#import "ApiUserIndustryCategory.h"
#import "ReqUserIndustryCategoryModel.h"
#import "RespUserIndustryCategoryModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "OccupationModel.h"
#import "HQHttpTool.h"
#import "FDOccupationViewController.h"
#import "FDInfoSecontion1Cell.h"
#import "FDInformationViewController.h"
#import "FDPerfectInformationViewController.h"

@implementation HttpUserIndustryCategory
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

- (void)loadUserIndustryCategoryWithViewController:(FDInformationViewController *)controller{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    ReqUserIndustryCategoryModel *reqModel =[[ReqUserIndustryCategoryModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiUserIndustryCategory *request=[[ApiUserIndustryCategory alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespUserIndustryCategoryModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            FDOccupationViewController *vc=[[FDOccupationViewController alloc]init];
            vc.dataArray = paseData.occupation;
            [controller.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        FDInfoSecontion1Cell *cell = [controller.tableView cellForRowAtIndexPath:index];
        cell.userInteractionEnabled = YES;

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        FDInfoSecontion1Cell *cell = [controller.tableView cellForRowAtIndexPath:index];
        cell.userInteractionEnabled = YES;
    }];
    
}
- (void)loadUserIndustryCategoryWithFDPerfectInformationViewController:(FDPerfectInformationViewController *)controller{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    ReqUserIndustryCategoryModel *reqModel =[[ReqUserIndustryCategoryModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiUserIndustryCategory *request=[[ApiUserIndustryCategory alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespUserIndustryCategoryModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            FDOccupationViewController *vc=[[FDOccupationViewController alloc]init];
            vc.dataArray = paseData.occupation;
            [controller.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
    
}
@end
