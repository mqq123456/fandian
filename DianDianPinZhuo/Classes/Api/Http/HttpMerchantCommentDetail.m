//
//  HttpMerchantCommentDetail.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/16.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpMerchantCommentDetail.h"
#import "FDCommentDetailViewController.h"
#import "ApiParseMerchantCommentDetail.h"
#import "ReqMerchantCommentDetail.h"
#import "RespMerchantCommentDetail.h"
#import "RequestModel.h"
#import "HQConst.h"
#import "GroupMembersModel.h"
#import "CommentModel.h"
#import "HQHttpTool.h"

@implementation HttpMerchantCommentDetail
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
- (void)loadUMerchantCommentDetailWithComment_id:(NSString *)comment_id controller:(FDCommentDetailViewController *)controller{
    [controller.activity startAnimating];
    ReqMerchantCommentDetail *reqModel =[[ReqMerchantCommentDetail alloc]init];
    reqModel.comment_id = comment_id;
    ApiParseMerchantCommentDetail *request=[[ApiParseMerchantCommentDetail alloc]init];
    
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        
        RespMerchantCommentDetail *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {//加载成功
            controller.model = paseData.comment;
            controller.respModel = paseData;
        }else{//加载失败
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        [controller.activity stopAnimating];
    } failure:^(NSError *error) {
        [controller.activity stopAnimating];
        [SVProgressHUD showImage:nil status:@"网络连接失败！"];
    }];

}
@end
