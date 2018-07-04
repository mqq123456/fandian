//
//  HttpTopicComment.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpTopicComment.h"
#import "ApiPaseTopicomment.h"
#import "ReqTopicComment.h"
#import "RespTopicComment.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "HQHttpTool.h"
#import "FDSubjectDetailViewController.h"
@implementation HttpTopicComment
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

- (void)loadTopicCommentWithReply_kid:(NSString *)reply_kid topic_id:(NSString *)topic_id content:(NSString *)content controller:(FDSubjectDetailViewController *)controller{
    [SVProgressHUD showWithStatus:@"回复中..."];
    ReqTopicComment *reqModel =[[ReqTopicComment alloc]init];
    
    reqModel.kid = [HQDefaultTool getKid];
    if (reply_kid) {
        reqModel.reply_kid = reply_kid;
    }
    reqModel.topic_id = topic_id;
    reqModel.content = content;
    
    ApiPaseTopicomment *request=[[ApiPaseTopicomment alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        [SVProgressHUD dismiss];
        RespTopicComment *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            
            [controller commentBackAndLoadTopicDetail];
            controller.kid = @"";
            
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
            controller.kid = @"";
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        controller.kid = @"";
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];
    
    
}

@end
