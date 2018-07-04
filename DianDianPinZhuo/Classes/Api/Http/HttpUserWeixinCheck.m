//
//  HttpUserWeixinCheck.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserWeixinCheck.h"
#import "ReqUserWeixinCheck.h"
#import "RespUserWeixinCheck.h"
#import "FDLoginViewController.h"
#import "ApiPaseUserWeixinCheck.h"
#import "RequestModel.h"
#import "HQHttpTool.h"

@implementation HttpUserWeixinCheck
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

- (void)weixinCheckWithController:(FDLoginViewController *)controller{
    ReqUserWeixinCheck*reqModel =[[ReqUserWeixinCheck alloc]init];
    reqModel.weixin_account = controller.openid;
//    reqModel.

    ApiPaseUserWeixinCheck*request=[[ApiPaseUserWeixinCheck alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserWeixinCheck *paseData=[request parseData:json];
        [SVProgressHUD dismiss];
        if ([paseData.code isEqualToString:@"1"]) {

            [controller weixinCheck:paseData.kid];
        }else{
            //[SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"微信授权失败"];
    }];
    


}

@end
