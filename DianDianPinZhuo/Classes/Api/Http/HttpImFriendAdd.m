//
//  HttpImFriendAdd.m
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpImFriendAdd.h"
#import "ApiPaseImFriendAdd.h"
#import "RespImFriendAdd.h"
#import "ReqImFriendAdd.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "HQConst.h"

@implementation HttpImFriendAdd
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


- (void)addFriendTopush:(NSString *)friend_kid{
    
    ReqImFriendAdd *reqModel =[[ReqImFriendAdd alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.friend_kid = friend_kid;
    ApiPaseImFriendAdd *request=[[ApiPaseImFriendAdd alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {

    } failure:^(NSError *error) {

        MQQLog(@"=======%@======",[error description]);
    }];
}
@end
