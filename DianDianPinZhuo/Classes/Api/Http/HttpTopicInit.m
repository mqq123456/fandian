//
//  HttpTopicInit.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicInit.h"
#import "FDTopicsViewController.h"
#import "ApiParseTopicInit.h"
#import "ReqTopicInit.h"
#import "RespTopicInit.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "FDSponsorTopicViewController.h"
@implementation HttpTopicInit
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

- (void)loadTopicInitWithController:(FDTopicsViewController *)controller button:(UIButton *)sender{
    sender.enabled = NO;
    ReqTopicInit *reqModel =[[ReqTopicInit alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseTopicInit *request=[[ApiParseTopicInit alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        sender.enabled = YES;
        RespTopicInit *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            controller.default_topic_title = paseData.default_topic_title;
            if ([paseData.is_today_finished intValue]==1) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:paseData.today_finished_hint delegate:controller cancelButtonTitle:nil otherButtonTitles:@"取消",@"预定明日", nil];
                [alertView show];
                return;
            }else{
                FDSponsorTopicViewController *makeTopic = [[FDSponsorTopicViewController alloc] init];
                makeTopic.default_topic_title = controller.default_topic_title;
                [controller.navigationController pushViewController:makeTopic animated:YES];
            }
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
        
    } failure:^(NSError *error) {
        sender.enabled = YES;
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
        
    }];
    

    

}
@end
