//
//  HttpUserBannerNotify.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserBannerNotify.h"
#import "ApiUserBannerNotify.h"
#import "ReqUserBannerNotifyModel.h"
#import "RespuserBannerNotifyModel.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
@implementation HttpUserBannerNotify
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

- (void)loadUserBannerNotifyWithBanner_id:(NSString *)banner_id{
    
    ReqUserBannerNotifyModel *reqModel =[[ReqUserBannerNotifyModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.banner_id = banner_id;
    ApiUserBannerNotify *request=[[ApiUserBannerNotify alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
    }];
    
}
@end
