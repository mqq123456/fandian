//
//  HttpUserKid.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserKid.h"
#import "ApiParseUserKid.h"
#import "RespUserKidModel.h"
#import "ReqUserKidModel.h"
#import "UsersModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "SVProgressHUD.h"
#import "HQConst.h"
#import "HQIMFriendsTool.h"
#import "ContactListViewController.h"
@implementation HttpUserKid

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

- (void)userkidWithKids:(NSString *)kids viewController:(ContactListViewController *)viewController{

    ReqUserKidModel*reqModel =[[ReqUserKidModel alloc]init];
    reqModel.kids = kids;
    
    ApiParseUserKid *request=[[ApiParseUserKid alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserKidModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            [viewController _sortDataArray:paseData.users];
            
            for (UsersModel *model  in paseData.users) {
                [[HQIMFriendsTool sharedInstance] addFriendsName:model idString:model.kid];
            }
            
        }else{
            
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [viewController.tableView reloadData];
        [viewController setupTableFooterView];
        [viewController.tableView addSubview:viewController.nullView];
        viewController.nullView.hidden = YES;
        [viewController setupNullImage];
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];

}



- (void)userkidWithKids:(NSString *)kids{
    
    ReqUserKidModel*reqModel =[[ReqUserKidModel alloc]init];
    reqModel.kids = kids;
    
    ApiParseUserKid *request=[[ApiParseUserKid alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserKidModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            for (UsersModel *model  in paseData.users) {
                [[HQIMFriendsTool sharedInstance] addFriendsName:model idString:model.kid];
            }
            
        }else{
            
            [SVProgressHUD showImage:nil status:paseData.desc];
        }

    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];
    
}
@end
