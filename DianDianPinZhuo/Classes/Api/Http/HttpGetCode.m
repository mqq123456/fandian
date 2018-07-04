//
//  HttpGetCode.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpGetCode.h"
#import "ApiParseBaseGetCode.h"
#import "RequestModel.h"
#import "ReqBaseGetCodeModel.h"
#import "RespBaseGetCodeModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "RequestModel.h"
@implementation HttpGetCode
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

- (void)getCode:(NSString *)phone{
    ReqBaseGetCodeModel *reqModel=[[ReqBaseGetCodeModel alloc]init];
    reqModel.phone = phone;
    ApiParseBaseGetCode *request=[[ApiParseBaseGetCode alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        MQQLog(@"－＝获取验证码成功＝%@",json);
        
    } failure:^(NSError *error) {
        MQQLog(@"--%@",[error description]);
    }];

}
@end
