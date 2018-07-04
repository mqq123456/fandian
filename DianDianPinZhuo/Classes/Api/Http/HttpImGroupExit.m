//
//  HttpImGroupExit.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpImGroupExit.h"
#import "ApiParseImGroupExit.h"
#import "RequestModel.h"
#import "ReqImGroupExitModel.h"
#import "RespImGroupExitModel.h"
#import "SVProgressHUD.h"
#import "HQHttpTool.h"
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import "HQConst.h"
#import "FDGroupDetailTool.h"
#import "ApiParseImGroupDetail.h"
#import "ReqImGroupDetailModel.h"
#import "RespImGroupDetailModel.h"
#import "ChatGroupDetailViewController.h"

@implementation HttpImGroupExit
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

- (void)loadExitGroup:(ChatGroupDetailViewController *)controller{
    [controller.popoverListView dismiss];
    ReqImGroupExitModel *reqModel = [[ReqImGroupExitModel alloc]init];
    reqModel.kid=[HQDefaultTool getKid];
    reqModel.group_id = controller.chatGroup.groupId;
    ApiParseImGroupExit *request =[[ApiParseImGroupExit alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    __weak typeof(controller) weakSelf = controller;
    [weakSelf showHudInView:controller.view hint:@"退出"];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespImGroupExitModel *paseData =[request parseData:json];
        [weakSelf hideHud];
        if ([paseData.code isEqualToString:@"1"]) {
            MQQLog(@"退出成功");

            [[FDGroupDetailTool sharedInstance] removeFromGroup:controller.chatGroup.groupId];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ExitGroup object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
        }else{
            MQQLog(@"退出失败%@",paseData.desc);
            [weakSelf showHint:[NSString stringWithFormat:@"%@",paseData.desc]];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"退出失败%@",error);
        //[weakSelf showHint:@"退出失败"];
    }];
    
}
- (void)loadFetchGroupInfo:(ChatGroupDetailViewController *)controller{
    ReqImGroupDetailModel *reqModel =[[ReqImGroupDetailModel alloc]init];
    reqModel.group_id = controller.chatGroup.groupId;
    
    ApiParseImGroupDetail *request=[[ApiParseImGroupDetail alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImGroupDetailModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {

            [controller reloadDataSource];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];


}
@end
