//
//  HttpImJoinGroup.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImJoinGroup.h"
#import "ApiParseImJoinGroup.h"
#import "ReqImJoinGroup.h"
#import "RespImJoinGroup.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQDefaultTool.h"
#import "GroupMembersModel.h"
#import "ChatViewController.h"
#import "FDNotJoinGroupsViewController.h"
#import "FDTopicsViewController.h"

@implementation HttpImJoinGroup
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

- (void)loadImJoinGroupWithGroup_id:(NSString *)group_id controller:(FDNotJoinGroupsViewController *)controller group_name:(NSString *)group_name{
    
    ReqImJoinGroup *reqModel =[[ReqImJoinGroup alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.group_id = group_id;
    [SVProgressHUD showWithStatus:@"正在加入群..."];
    ApiParseImJoinGroup *request=[[ApiParseImJoinGroup alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImJoinGroup *paseData=[request parseData:json];
        [SVProgressHUD dismiss];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            [controller loadFirstMerchantSearch];
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:group_id conversationType:eConversationTypeGroupChat];
            [chatController addTitleViewWithTitle:group_name];
            [controller.navigationController pushViewController:chatController animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}


- (void)loadImJoinGroupWithGroup_id_topicsVC:(NSString *)group_id controller:(FDTopicsViewController *)controller group_name:(NSString *)group_name{
    
    ReqImJoinGroup *reqModel =[[ReqImJoinGroup alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.group_id = group_id;
    [SVProgressHUD showWithStatus:@"正在加入群..."];
    ApiParseImJoinGroup *request=[[ApiParseImJoinGroup alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespImJoinGroup *paseData=[request parseData:json];
        [SVProgressHUD dismiss];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:group_id conversationType:eConversationTypeGroupChat];
            [chatController addTitleViewWithTitle:group_name];
            [controller.navigationController pushViewController:chatController animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}

@end
