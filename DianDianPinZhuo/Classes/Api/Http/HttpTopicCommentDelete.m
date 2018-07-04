//
//  HttpTopicCommentDelete.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicCommentDelete.h"
#import "ApiPaseTopicCommentDelete.h"
#import "ReqTopicCommentDelete.h"
#import "RespTopicCommentDelete.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "FDSubjectDetailViewController.h"
@implementation HttpTopicCommentDelete
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

- (void)loadTopicCommentDeleteWithController:(FDSubjectDetailViewController *)controller comment_id:(NSString *)comment_id{
    [SVProgressHUD showWithStatus:@"删除中..."];
    ReqTopicCommentDelete *reqModel =[[ReqTopicCommentDelete alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.comment_id = comment_id;

    ApiPaseTopicCommentDelete *request=[[ApiPaseTopicCommentDelete alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespTopicCommentDelete *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            [controller commentDeleteBackAndLoadTopicDetail];
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];
    
    
}
@end
