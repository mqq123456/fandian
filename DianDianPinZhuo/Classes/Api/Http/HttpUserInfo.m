//
//  HttpUserInfo.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/11.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserInfo.h"
#import "ApiParseUserInfo.h"
#import "RespUserInfoModel.h"
#import "ReqUserInfoModel.h"
#import "HQConst.h"
#import "UserModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "UIView+WZLBadge.h"
#import "HttpUserEdit.h"
#import "FDPersonalCenterViewController.h"
#import "FDUserDetailViewController.h"

#import "FDLoginViewController.h"
#import "SVProgressHUD.h"

#import "ChatViewController.h"
#import "HttpUserLogin.h"
#import "FDHuanXinLoginTool.h"

@implementation HttpUserInfo
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

- (void)loadUserInfoWithViewController:(FDPersonalCenterViewController *)viewController {
    ReqUserInfoModel *reqModel =[[ReqUserInfoModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseUserInfo *request=[[ApiParseUserInfo alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserInfoModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            
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
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"self_desc"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"complete_info"];
            viewController.model = paseData.user;
            
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
            [HQDefaultTool setSelf_desc:paseData.user.self_desc];
            [HQDefaultTool setComplete_info:paseData.user.complete_info];
            
            if ([paseData.user.sex isEqualToString:@"1"]) {
                [HQDefaultTool setSex:@"男"];
            }else if ([paseData.user.sex isEqualToString:@"2"]){
                [HQDefaultTool setSex:@"女"];
            }
            if (paseData.user.is_msg>0&&![[HQDefaultTool getKid] isEqualToString:@""]) {
                [viewController.notice showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
            }
            
            [viewController setHeadView];
            [viewController.tableView reloadData];
            
            if(![paseData.user.office_build isEqualToString:@""]){
            //如果有了写字楼
               [HQDefaultTool setOffice_build:paseData.user.office_build];
            
            }else{
            //没有写字楼
                if(![HQDefaultTool getAddress] || [[HQDefaultTool getAddress] isEqualToString:@""]){//没定位到
                
                
                }else{//定位到了
                    
                        HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
                        [userEdit loadUserEditOffice_build:[HQDefaultTool getAddress]];
                }
                
            }

            
        }
    } failure:^(NSError *error) {
        
        MQQLog(@"error -----%@------",error);
    }];
    
}
- (void)loadUserDetailViewController:(FDUserDetailViewController *)viewController kid:(NSString *)kid{
    ReqUserInfoModel *reqModel =[[ReqUserInfoModel alloc]init];
    reqModel.kid = kid;
    ApiParseUserInfo *request=[[ApiParseUserInfo alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserInfoModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            viewController.user = paseData.user;
            [viewController.footerTableView reloadData];
            
            [viewController setHeadView];
            
        }
    } failure:^(NSError *error) {
        
        MQQLog(@"error -----%@------",error);
    }];
}

- (void)loadWithLoginViewController:(FDLoginViewController *)controller kid:(NSString *)kid{
    ReqUserInfoModel *reqModel =[[ReqUserInfoModel alloc]init];
    reqModel.kid = kid;
    ApiParseUserInfo *request=[[ApiParseUserInfo alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserInfoModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
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
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"self_desc"];
            
            
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
            [HQDefaultTool setSelf_desc:paseData.user.self_desc];
            [HQDefaultTool setComplete_info:paseData.user.complete_info];
            
            if ([paseData.user.sex isEqualToString:@"1"]) {
                [HQDefaultTool setSex:@"男"];
            }else if ([paseData.user.sex isEqualToString:@"2"]){
                [HQDefaultTool setSex:@"女"];
            }
           
            if(![paseData.user.office_build isEqualToString:@""]){
                //如果有了写字楼
                [HQDefaultTool setOffice_build:paseData.user.office_build];
                
            }else{
                //没有写字楼
                if(![HQDefaultTool getAddress] || [[HQDefaultTool getAddress] isEqualToString:@""]){//没定位到
                    
                    
                }else{//定位到了
                    
                    HttpUserEdit *userEdit = [HttpUserEdit sharedInstance];
                    [userEdit loadUserEditOffice_build:[HQDefaultTool getAddress]];
                }
                
            }
            
            [controller dismissViewControllerAnimated:YES completion:nil];
            
            //异步登陆账号
            
            FDHuanXinLoginTool *tool = [FDHuanXinLoginTool sharedInstance];
            [tool huanxinLogin:controller];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil userInfo:nil];
            //发送通知，刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:JoinInOrOutGroup object:nil];

            HttpUserLogin  *login= [HttpUserLogin sharedInstance];
            [login delegateWithController:controller];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
        MQQLog(@"error -----%@------",error);
    }];
    
}

- (void)loadUserInfoInGroupWithViewController:(ChatViewController *)viewController{
    [SVProgressHUD showWithStatus:@"加载中..."];
    ReqUserInfoModel *reqModel =[[ReqUserInfoModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    ApiParseUserInfo *request=[[ApiParseUserInfo alloc]init];
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespUserInfoModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {

            if ([paseData.user.complete_info isEqualToString:@"1"]) {///资料齐全可以查看群组成员
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"complete_info"];
                [HQDefaultTool setComplete_info:paseData.user.complete_info];
                [viewController lookGroupMembers];
                
            }else
            {
                [viewController addPerfectView];
            }
           
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络加载失败！"];
        MQQLog(@"error -----%@------",error);

    }];

}


@end
