//
//  HttpUserLogin.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserLogin.h"
#import "NSString+Verification.h"
#import "ApiParseUserLogin.h"
#import "ReqUserLoginModel.h"
#import "RespUserLoginModel.h"
#import "UserModel.h"
#import "ApiParseBaseGetCode.h"
#import "ReqBaseGetCodeModel.h"
#import "RespBaseGetCodeModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "FDCouponsViewController.h"
#import "EaseMob.h"
#import "HttpUserKid.h"
#import "FDLoginViewController.h"
#import "HQConst.h"
#import "FDUUidManager.h"
#import "FDHuanXinLoginTool.h"
@implementation HttpUserLogin
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

- (void)loadLoginClick:(id)sender weixin_account:(NSString *)weixin_account Controller:(FDLoginViewController *)controller{

    ReqUserLoginModel *reqModel=[[ReqUserLoginModel alloc]init];
    reqModel.phone = controller.phone.text;
    reqModel.vcode = controller.vcode.text;
    reqModel.local_lat = [HQDefaultTool getLat];
    reqModel.local_lng = [HQDefaultTool getLng];
//    reqModel.device_token = [HQDefaultTool getDevice_token];
    reqModel.device_token = [HQDefaultTool getRegistrationID];
    reqModel.cver = APP_VERSION;
    reqModel.imei = [FDUUidManager sharedManager].imei;
    reqModel.platform = @"0";
    reqModel.channel = APP_CHANNEL;
    reqModel.weixin_account =weixin_account;
    reqModel.weixin_nickname = controller.weixin_nickname;
    reqModel.weixin_head = controller.weixin_head;
    [(UIButton *)sender setTitle:@"登录中..." forState:UIControlStateDisabled];
    UIButton *start = (UIButton *)sender;
    start.enabled=NO;
    [controller.phone resignFirstResponder];
    [controller.vcode resignFirstResponder];
    ApiParseUserLogin *request=[[ApiParseUserLogin alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        start.enabled=YES;
        [start setTitle:@"开始" forState:UIControlStateNormal];
        RespUserLoginModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            [SVProgressHUD dismiss];

            [HQDefaultTool setKid:paseData.user.kid];
            [HQDefaultTool setNickName:paseData.user.nick_name];
            [HQDefaultTool setBrith:paseData.user.birth];
            [HQDefaultTool setPhone:paseData.user.phone];
            [HQDefaultTool setHead:paseData.user.head];
            [HQDefaultTool setOccupation:paseData.user.occupation];
            [HQDefaultTool setIndustry:paseData.user.industry];
            [HQDefaultTool setIm_passWord:paseData.user.im_password];
            [HQDefaultTool setAge:paseData.user.ages];
            [HQDefaultTool setHometown:paseData.user.hometown];
            [HQDefaultTool setOffice_build:paseData.user.office_build];
            [HQDefaultTool setCompany:paseData.user.company];
            [HQDefaultTool setConstellation:paseData.user.constellation];
            [HQDefaultTool setWeixin_invite_url:paseData.user.weixin_invite_url];
            [HQDefaultTool setApp_invite_url:paseData.user.app_invite_url];
            [HQDefaultTool setWeixin_invite_title:paseData.user.weixin_invite_title];
            [HQDefaultTool setWeixin_invite_content:paseData.user.weixin_invite_content];
            [HQDefaultTool setGrowup_point:paseData.user.growup_point];
            [HQDefaultTool setIntegral_point:paseData.user.integral_point];
            [HQDefaultTool setVoucher_count:paseData.user.voucher_count];
            [HQDefaultTool setOrderSum:paseData.user.orderSum];
            
            [HQDefaultTool setAges_hint:paseData.user.ages_hint];
            [HQDefaultTool setOccupation_hint:paseData.user.occupation_hint];
            [HQDefaultTool setHometown_hint:paseData.user.hometown_hint];
            [HQDefaultTool setCompany_hint:paseData.user.company_hint];
            [HQDefaultTool setConstellation_hint:paseData.user.constellation_hint];
            
            [HQDefaultTool setAges_default:paseData.user.ages_default];
            [HQDefaultTool setOccupation_default:paseData.user.occupation_default];
            [HQDefaultTool setHometown_default:paseData.user.hometown_default];
            [HQDefaultTool setCompany_default:paseData.user.company_default];
            [HQDefaultTool setConstellation_default:paseData.user.constellation_default];
            
            if ([paseData.user.sex isEqualToString:@"1"]) {
                [HQDefaultTool setSex:@"男"];
            }else if ([paseData.user.sex isEqualToString:@"2"]){
                [HQDefaultTool setSex:@"女"];
            }
            
            FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
            [tool huanxinLogin:controller];
            
            [self delegateWithController:controller];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil userInfo:nil];
            //发送通知，刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];
            

            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        start.enabled=YES;
        [start setTitle:@"开始" forState:UIControlStateNormal];
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
        
        MQQLog(@"--%@",[error description]);
    }];
    
}
- (void)delegateWithController:(FDLoginViewController *)controller{
        
    
    if (controller.delegate &&[controller.delegate respondsToSelector:@selector(isToOrder)]) {
        [controller.delegate isToOrder];
    }
    
    
    if (controller.delegate &&[controller.delegate respondsToSelector:@selector(dismissWithIndex:)]) {
        [controller.delegate dismissWithIndex:controller.info_index];
    }
    ///跳转到发起话题页面
    if (controller.delegate &&[controller.delegate respondsToSelector:@selector(pushToMakeTopic)]) {
        [controller.delegate pushToMakeTopic];
    }
    
    
    if (controller.isFirst) {
        
        FDCouponsViewController *coupons = [[FDCouponsViewController alloc] init];
        coupons.isFirst = YES;
        [controller.navigationController pushViewController:coupons animated:YES];
        
        
    }else{
        if (controller.isFromUserInfo) {
            [[NSNotificationCenter defaultCenter] postNotificationName:userInfoLogin object:nil];
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
        [controller.navigationController removeFromParentViewController];
        
    }
    
}

@end
