//
//  HttpImGroupDetail.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpImGroupDetail.h"
#import "ApiParseImGroupDetail.h"
#import "ReqImGroupDetailModel.h"
#import "RespImGroupDetailModel.h"
#import "RequestModel.h"
#import "MemberModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "SVProgressHUD.h"
#import "ChatGroupDetailViewController.h"
@implementation HttpImGroupDetail
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

- (void)imGroupDetailWithGroupID:(NSString *)group_id viewController:(ChatGroupDetailViewController *)viewController{
    ReqImGroupDetailModel *reqModel =[[ReqImGroupDetailModel alloc]init];
    reqModel.group_id = group_id;
    
    ApiParseImGroupDetail *request=[[ApiParseImGroupDetail alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImGroupDetailModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {

            [viewController reloadDataSource];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];

}
@end
