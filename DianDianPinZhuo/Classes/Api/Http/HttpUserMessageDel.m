//
//  HttpUserMessageDel.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserMessageDel.h"
#import "FDMessageEditCell.h"
#import "FDMessageEditBottonView.h"
#import "RequestModel.h"
#import "ApiParseMessageList.h"
#import "ReqUserMessageListModel.h"
#import "RespUserMessageListModel.h"
#import "MyMessageModel.h"
#import "MJRefresh.h"
#import "HQHttpTool.h"
#import "ApiPaseUserMessageDel.h"
#import "ReqUserMessageDelModel.h"
#import "RespUserMessageDelModel.h"
#import "FDMessageEditViewController.h"
@implementation HttpUserMessageDel
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

-  (void)loadDeleteMessage:(FDMessageEditViewController *)controller{
    ReqUserMessageDelModel *reqModel=[[ReqUserMessageDelModel alloc]init];
    NSString *ids = [controller.selectArray componentsJoinedByString:@","];
    if ([ids isEqualToString:@""]) {
        [SVProgressHUD showImage:nil status:@"请选择要编辑的消息"];
        return;
    }
    reqModel.ids = ids;
    reqModel.kid = [HQDefaultTool getKid];
    ApiPaseUserMessageDel *request=[[ApiPaseUserMessageDel alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserMessageDelModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            [controller.selectArray removeAllObjects];
            [controller loadMessageList:@"delect"];
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshFDMessageViewController object:nil];
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
    }];


}


@end
