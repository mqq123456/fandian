//
//  HttpUserUpdateDevice.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserUpdateDevice.h"
#import "ApiParseUserUpdateDevice.h"
#import "ReqUserUpdateDevice.h"
#import "RespUserUpdateDevice.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"
#import "HQHttpTool.h"
#import "FDUUidManager.h"
@implementation HttpUserUpdateDevice
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

- (void)loadUserUpdateDeviceWithKid:(NSString *)kid{
    ReqUserUpdateDevice *reqModel =[[ReqUserUpdateDevice alloc]init];
    reqModel.kid = kid;
    reqModel.device_token = [HQDefaultTool getRegistrationID];
    reqModel.cver = APP_VERSION;
    reqModel.imei = [FDUUidManager sharedManager].imei;
    reqModel.platform = @"0";
    reqModel.channel = APP_CHANNEL;

    ApiParseUserUpdateDevice *request=[[ApiParseUserUpdateDevice alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserUpdateDevice *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
        }else{//加载失败
            
        }
        
    } failure:^(NSError *error) {

    }];
}

@end
