//
//  HttpMerchantCommonComment.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpMerchantCommonComment.h"
#import "ReqMerchantCommonComment.h"
#import "ApiParseMerchantCommonComment.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "RespMerchantCommonComment.h"
#import "UsedCommentModel.h"
#import "FDEvaluationViewController.h"
@implementation HttpMerchantCommonComment
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

- (void)commentWithViewController:(FDEvaluationViewController *)controller{
    ReqMerchantCommonComment *reqModel=[[ReqMerchantCommonComment alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    
    ApiParseMerchantCommonComment *request=[[ApiParseMerchantCommonComment alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespMerchantCommonComment *paseData=[request parseData:json];
        controller.itemArray = paseData.items;
        
        for (int i=0;i<controller.itemArray.count;i++) {
            UsedCommentModel *model = controller.itemArray[i];
            if ([model.star isEqualToString:@"1"]) {
                [controller.star1 addObject:model];
            }else if ([model.star isEqualToString:@"2"]){
                [controller.star2 addObject:model];
            }else if ([model.star isEqualToString:@"3"]){
                [controller.star3 addObject:model];
            }else if ([model.star isEqualToString:@"4"]){
                [controller.star4 addObject:model];
            }else{
                
                [controller.star5 addObject:model];
                
            }
            
        }
        
        [controller.tableView reloadData];
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [SVProgressHUD showImage:nil status:@"获取餐厅存在问题失败"];
    }];
    

}
@end
