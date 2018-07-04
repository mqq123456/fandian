//
//  HttpUserEdit.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpUserEdit.h"
#import "FDInfoCell.h"
#import "QQWKImageScale.h"

#import "ReqBaseImageUploadModel.h"

#import "ApiParseBaseImageUpload.h"

#import "RespBaseImageUploadModel.h"

#import "IQKeyboardManager.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "ReqUserEditModel.h"
#import "RespUserEditModel.h"
#import "ApiParseUserEdit.h"

#import "NSString+Verification.h"
#import "FDInformationViewController.h"
#import "FDPerfectInformationViewController.h"
#import "FDGroupMemberViewController.h"

@implementation HttpUserEdit
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

#pragma mark - 图片上传
- (void)loadUpLoadClick:(FDInformationViewController *)controller{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    FDInfoCell *cell = [controller.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.headImage.image == nil) return;
    [SVProgressHUD showWithStatus:@"正在上传，请勿离开"];
    if (cell.headImage.image) {
        UIImage *image=cell.headImage.image;
        //图片压缩;
        image=[QQWKImageScale imageCompressForWidth:image targetWidth:290.00];
        controller.xpl=[QQWKImageScale image2Data:image];
    }
    ReqBaseImageUploadModel *reqModel=[[ReqBaseImageUploadModel alloc]init];
    reqModel.img = controller.xpl;
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseBaseImageUpload *request=[[ApiParseBaseImageUpload alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespBaseImageUploadModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [HQDefaultTool setHead:paseData.url];
            ReqUserEditModel *reqModel=[[ReqUserEditModel alloc]init];
            reqModel.kid = [HQDefaultTool getKid];
            reqModel.avator_id = paseData.pic_id;
            ApiParseUserEdit *request=[[ApiParseUserEdit alloc]init];
            RequestModel *requestModel=[request requestData:reqModel];
            [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
                RespUserEditModel *paseData = [request parseData:json];
                if ([paseData.code isEqualToString:@"1"]) {
                    
                    [SVProgressHUD dismiss];
                    
                    
                    [SVProgressHUD showImage:nil status:@"头像修改成功"];
                    
                    //发送通知修改个人信息，从新加载个人数据
                    [[NSNotificationCenter defaultCenter] postNotificationName:ModifyUserInfo object:nil];

                }else{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showImage:nil status:paseData.desc];
                }
                
                
            } failure:^(NSError *error) {
                [controller.activity stopAnimating];
                [SVProgressHUD showImage:nil status:@"修改失败，请检查你的网路。"];
            }];
            
            
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [SVProgressHUD dismiss];
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = @"上传失败";
        alertView.delegate = self;
        [alertView addButtonWithTitle:@"确定"];
        [alertView show];
        return;
    }];
    
}

- (void)loadUserEditWithIndex:(NSInteger)index content:(NSString *)content{
    ApiParseUserEdit *request=[[ApiParseUserEdit alloc]init];
    ReqUserEditModel *reqModel=[[ReqUserEditModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    
    if (index==1) {//昵称
        reqModel.nick_name = content;
    }
    if (index==1001) {//性别
        reqModel.sex = 1;
    }else if (index==1002){
        reqModel.sex = 2;
    }
    if (index >=10001) {//年龄
        reqModel.ages =content;
    }
    if (index ==10) {
        reqModel.hometown = content;
    }
    if (index==21) {
        reqModel.constellation = content;
    }
    if (index==2) {
        reqModel.company = content;
    }
    if (index==3) {
        reqModel.office_build = content;
    }
    if (index==123) {
        reqModel.self_desc = content;
    }
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserEditModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [SVProgressHUD dismiss];
            
            [SVProgressHUD showImage:nil status:@"修改成功！"];
            
            if (index==1) {
                //发送通知刷新cell
                [HQDefaultTool setNickName:content];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index==1001) {
                //发送通知刷新cell
                [HQDefaultTool setSex:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }else if (index==1002){
                [HQDefaultTool setSex:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index >=10001) {
                [HQDefaultTool setAge:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index == 10) {
                [HQDefaultTool setHometown:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index == 21) {
                [HQDefaultTool setConstellation:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index == 2) {
                [HQDefaultTool setCompany:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index == 3) {
                [HQDefaultTool setOffice_build:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            if (index == 123) {
                [HQDefaultTool setSelf_desc:content];
                [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%zd",index]}];
            }
            
            
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        MQQLog(@"error = %@",[error description]);
        [SVProgressHUD showImage:nil status:@"修改失败，请检查你的网路。"];
    }];

}
- (void)loadUserEditWithIndustry:(NSString *)industry occupation:(NSString *)occupation{
    ApiParseUserEdit *request=[[ApiParseUserEdit alloc]init];
    ReqUserEditModel *reqModel=[[ReqUserEditModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.industry = industry;
    reqModel.occupation = occupation;
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserEditModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showImage:nil status:@"修改成功！"];
            [HQDefaultTool setIndustry:industry];
            [HQDefaultTool setOccupation:occupation];
            [[NSNotificationCenter defaultCenter] postNotificationName:reloadUserEdit object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%d",200]}];
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        MQQLog(@"error = %@",[error description]);
        [SVProgressHUD showImage:nil status:@"修改失败，请检查你的网路。"];
    }];
}

- (void)loadUserEditOffice_build:(NSString *)content{
    ApiParseUserEdit *request=[[ApiParseUserEdit alloc]init];
    ReqUserEditModel *reqModel=[[ReqUserEditModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.office_build = content;
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserEditModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [HQDefaultTool setOffice_build:content];
        }else{
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadUserEditWithSex:(NSString *)sex age:(NSString *)age company:(NSString *)company occupation:(NSString *)occupation controller:(FDPerfectInformationViewController *)controller{
    ApiParseUserEdit *request=[[ApiParseUserEdit alloc]init];
    ReqUserEditModel *reqModel=[[ReqUserEditModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    if ([sex isEqualToString:@"男"] ) {
        reqModel.sex = 1;
    }else if ([sex isEqualToString:@"女"] ){
        reqModel.sex = 2;
    }
    reqModel.ages = age;
    reqModel.company = company;
    reqModel.occupation = occupation;
    
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespUserEditModel *paseData = [request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [HQDefaultTool setAge:age];
            [HQDefaultTool setSex:sex];
            [HQDefaultTool setCompany:company];
            [HQDefaultTool setOccupation:occupation];
            FDGroupMemberViewController *group = [[FDGroupMemberViewController alloc] init];
            group.group_id = controller.group_id;
            [controller.navigationController pushViewController:group animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:controller.navigationController.viewControllers];
                [navigationarray removeObjectAtIndex:navigationarray.count-2];
                controller.navigationController.viewControllers = navigationarray;
                
                
            });
            
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
