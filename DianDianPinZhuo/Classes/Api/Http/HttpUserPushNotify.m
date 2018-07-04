//
//  HttpUserPushNotify.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserPushNotify.h"
#import "ApiPaseUserPushNotify.h"
#import "ReqUserPushNotifyModel.h"
#import "RespUserPushNotifyModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
@implementation HttpUserPushNotify
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

- (void)loadUserPushNotifyWithPush_id:(NSString *)push_id{
    
    ReqUserPushNotifyModel *reqModel =[[ReqUserPushNotifyModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.push_id = push_id;
    
    ApiPaseUserPushNotify*request=[[ApiPaseUserPushNotify alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
    }];
    
}

@end
