//
//  HttpImageUpLoad.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpImageUpLoad.h"
#import <UIKit/UIKit.h>
#import "HQConst.h"
#import "ApiParseBaseImageUpload.h"
#import "RequestModel.h"
#import "ReqBaseImageUploadModel.h"
#import "RespBaseImageUploadModel.h"
#import "SVProgressHUD.h"
#import "HQHttpTool.h"
#import "ReqUserEditModel.h"
#import "ApiParseUserEdit.h"
#import "RespUserEditModel.h"
@implementation HttpImageUpLoad
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

- (void)imageUpLoadWithImageString:(NSString *)image{
    [SVProgressHUD showWithStatus:@"正在上传，请勿离开"];
    ReqBaseImageUploadModel *reqModel=[[ReqBaseImageUploadModel alloc]init];
    reqModel.img = image;
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
                [SVProgressHUD dismiss];
                
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
@end
