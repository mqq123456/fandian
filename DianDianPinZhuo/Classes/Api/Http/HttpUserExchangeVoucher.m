//
//  HttpUserExchangeVoucher.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpUserExchangeVoucher.h"
#import "ReqUserExchangeVoucher.h"
#import "RespUserExchangeVoucher.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "SVProgressHUD.h"
#import "HQDefaultTool.h"
#import "ApiParseUserExchangeVoucher.h"
#import "FDInvitationCodeViewController.h"

@implementation HttpUserExchangeVoucher
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

- (void)userExchangeVoucher_occ_code:(NSString *)occ_code andViewController:(FDInvitationCodeViewController *)viewController sender:(UIButton *)sender{

    [SVProgressHUD show];
    ReqUserExchangeVoucher *reqModel =[[ReqUserExchangeVoucher alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.occ_code = occ_code;
    
    ApiParseUserExchangeVoucher *request=[[ApiParseUserExchangeVoucher alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespUserExchangeVoucher *paseData=[request parseData:json];
        sender.enabled = YES;
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            viewController.model = paseData;
            [viewController exchangeSuccess];
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
//            [viewController exchangeError];
        }
        
    } failure:^(NSError *error) {
        sender.enabled = YES;
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];
    

}
@end
