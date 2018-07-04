//
//  HttpUserLogout.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserLogout.h"
#import "ApiParseUserLogout.h"
#import "ReqUserLogoutModel.h"
#import "RespUserLogoutModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "EaseMob.h"
#import "FDConfigViewController.h"
@implementation HttpUserLogout
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


- (void)loadUserLogOutBtnClick:(UIButton *)button Controller:(FDConfigViewController *)controller{

    ReqUserLogoutModel *reqModel = [[ReqUserLogoutModel alloc]init];
    reqModel.kid=[HQDefaultTool getKid];
    
    ApiParseUserLogout *request =[[ApiParseUserLogout alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserLogoutModel *paseData =[request parseData:json];
        button.enabled = YES;
        if ([paseData.code isEqualToString:@"1"]) {
            
            [controller.popoverListView dismiss];
            [SVProgressHUD showImage:nil status:@" 退出成功 "];
            [controller.navigationController popViewControllerAnimated:YES];
            
            MQQLog(@"退出成功");
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kid"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nick_name"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"birth"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"head"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"occupation"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"industry"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"im_password"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ages"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hometown"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"office_build"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"company"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"constellation"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"weixin_invite_url"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"app_invite_url"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"weixin_invite_title"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"weixin_invite_content"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"growup_point"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"integral_point"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"voucher_count"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderSum"];
            
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ages_hint"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"occupation_hint"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hometown_hint"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"company_hint"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"constellation_hint"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ages_default"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"occupation_default"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hometown_default"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"company_default"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"constellation_default"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sex"];
        
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil userInfo:nil];
            
            //退出环信
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                if (error && error.errorCode != EMErrorServerNotLogin) {//退出失败
                    
                }
                else{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                }
            } onQueue:nil];
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                if (!error && info) {
                    MQQLog(@"退出成功");
                }
            } onQueue:nil];
            //发送通知，刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
            
        }else{
            [controller.popoverListView dismiss];
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"退出失败%@",error);
        button.enabled = YES;
        [controller.popoverListView dismiss];
        [SVProgressHUD showImage:nil status:@" 退出失败！ "];
    }];
    

}
@end
