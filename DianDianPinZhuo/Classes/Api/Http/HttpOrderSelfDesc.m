//
//  HttpOrderSelfDesc.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HttpOrderSelfDesc.h"
#import "ApiTopicPersonalDescribe.h"
#import "ReqOrderSelfDescModel.h"
#import "RespTopicPersonalDescribeModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "ApiOrderSelfDesc.h"
#import "FDTicket_New_ViewController.h"
@implementation HttpOrderSelfDesc
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

- (void)loadTopicPersonalDescribe:(NSString *)table_id andMy_Desc:(NSString *)my_desc andOrder_no:(NSString *)order_no viewController:(FDTicket_New_ViewController *)viewController{

    ReqOrderSelfDescModel *reqModel =[[ReqOrderSelfDescModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.table_id = table_id;
    reqModel.order_no = order_no;
    reqModel.self_desc = my_desc;
    
    ApiOrderSelfDesc*request=[[ApiOrderSelfDesc alloc]init];
    
    RequestModel *requestModel =[request requestData:reqModel];
    
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespTopicPersonalDescribeModel *paseData=[request parseData:json];
        if ([paseData.code isEqualToString:@"1"]) {
            [SVProgressHUD showImage:nil status:@"编辑成功"];
            [viewController loadUserOrderDetail];
        }else{
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        
    } failure:^(NSError *error) {
        MQQLog(@"=======%@======",[error description]);
    }];
    


}
@end
