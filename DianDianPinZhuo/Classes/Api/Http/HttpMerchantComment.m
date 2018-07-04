//
//  HttpMerchantComment.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantComment.h"
#import "ApiParseMerchantComment.h"
#import "ReqMerchantCommentModel.h"
#import "RespMerchantCommentModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "SVProgressHUD.h"
#import "FDEvaluationViewController.h"
#import "FDEvaluationSuccessView.h"
@implementation HttpMerchantComment
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

- (void)merchantCommentWithMerchant_id:(int)merchant_id content:(NSString *)content star:(int)star cc_ids:(NSString *)ccids viewController:(FDEvaluationViewController *)viewController order_no:(NSString *)order_no imgs:(NSString *)imgs{
    
    ReqMerchantCommentModel *reqModel=[[ReqMerchantCommentModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    if (order_no) {
        reqModel.order_no = order_no;
    }
    reqModel.merchant_id = merchant_id;
    
    reqModel.content = content;
    reqModel.star = star;

    reqModel.cc_ids = ccids;
    reqModel.imgs = imgs;
    
    ApiParseMerchantComment *request=[[ApiParseMerchantComment alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespMerchantCommentModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            
            [HQDefaultTool setBage_url:paseData.bag_url];
            ///评价完成之后刷新详情数据
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshDetailViewController object:self];
            if (viewController.fromOrderList) {
                [[NSNotificationCenter defaultCenter] postNotificationName:RefreshOrderListViewController object:self];
            }
            [viewController.navigationController.view addSubview:viewController.bonusView];
            [viewController.bonusView.sendTo_weixin addTarget:viewController action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
            [viewController.bonusView.bonus_NO addTarget:viewController action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
            
 
//            if (paseData.bag_url &&![paseData.bag_url isEqualToString:@""]) {
//                [viewController.navigationController.view addSubview:viewController.bonusView];
//                
//                [viewController.bonusView.sendTo_weixin addTarget:viewController action:@selector(sendTo_weixin_Click) forControlEvents:UIControlEventTouchUpInside];
//                [viewController.bonusView.bonus_NO addTarget:viewController action:@selector(bonus_NO_Click) forControlEvents:UIControlEventTouchUpInside];
//            }else{
//                [viewController.navigationController popViewControllerAnimated:YES];
//                [SVProgressHUD showImage:nil status:@"评价成功，感谢你的支持"];
//                
//            }
            
            
        }else{
            
            [SVProgressHUD showImage:nil status:paseData.desc];
            
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
    }];

}
@end
