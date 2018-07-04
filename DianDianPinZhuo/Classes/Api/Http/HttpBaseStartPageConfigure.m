//
//  HttpBaseStartPageConfigure.m
//  DianDianPinZhuo
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpBaseStartPageConfigure.h"
#import "ApiBaseStartPageConfigure.h"
#import "ReqBaseStartPageConfigure.h"
#import "RespBaseStartPageConfigure.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "AFNetworking.h"

@implementation HttpBaseStartPageConfigure
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

-(void)loadBaseStartPageConfigure
{
    ReqBaseStartPageConfigure *reqModel=[[ReqBaseStartPageConfigure alloc]init];
    reqModel.kid=[HQDefaultTool getKid];
    ApiBaseStartPageConfigure *request=[[ApiBaseStartPageConfigure alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    
    [HttpBaseStartPageConfigure post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespBaseStartPageConfigure *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"start_img"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"start_url"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"start_h5_title"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"start_expire_time"];

            [HQDefaultTool setStart_img:paseData.img];
            [HQDefaultTool setStart_url:paseData.url];
            [HQDefaultTool setStart_h5_title:paseData.h5_title];
            [HQDefaultTool setStart_expire_time:paseData.end_stamp];
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
    }];
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
