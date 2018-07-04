//
//  HttpTopicJoin.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicJoin.h"
#import "ReqTopicJoinModel.h"
#import "RequestModel.h"
#import "ApiPaseTopicJoin.h"
#import "RespTopicJoinModel.h"
#import "HQHttpTool.h"
#import "FDSubjectDetailViewController.h"
@implementation HttpTopicJoin
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

- (void)loadWithTopicJoin:(NSString *)topic_id andPeople:(NSString *)people controller:(FDSubjectDetailViewController *)controller{

    if (controller.model.is_free ==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:joinSuccess object:nil];
        return;
    }
    ReqTopicJoinModel*reqModel =[[ReqTopicJoinModel alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.topic_id = topic_id;
    reqModel.people = people;
    ApiPaseTopicJoin *request=[[ApiPaseTopicJoin alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespTopicJoinModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功

            [[NSNotificationCenter defaultCenter] postNotificationName:joinSuccess object:nil];
        }else{//加载失败
            
//            [SVProgressHUD showImage:nil status:paseData.desc];
            [[NSNotificationCenter defaultCenter] postNotificationName:joinFailed object:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
}

@end
