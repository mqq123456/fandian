//
//  HttpOrderCancel.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpOrderCancel.h"
#import "ReqOrderCancelModel.h"
#import "ApiParseOrderCancel.h"
#import "RespOrderCancelModel.h"
#import "RequestModel.h"
#import "HQHttpTool.h"
#import "RefundFinish.h"
#import "FDOrderViewController.h"
#import "FDTicket_New_ViewController.h"
#import "FDMyOrderViewController.h"

@implementation HttpOrderCancel
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

/**
 *  支付失败
 *
 */
- (void)PayFailWithOrder_no:(NSString *)order_no controller:(FDOrderViewController *)controller{
    
    ReqOrderCancelModel *reqModel=[[ReqOrderCancelModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.order_no = order_no;
    ApiParseOrderCancel *request=[[ApiParseOrderCancel alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespOrderCancelModel *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {
            MQQLog(@"订单取消成功");
            controller.order_on = nil;
        }else{
            MQQLog(@"=========%@",paseData.desc);
        }
    } failure:^(NSError *error) {
        
        MQQLog(@"%@",[error description]);
    }];
}
- (void)loadCancleOrder:(FDTicket_New_ViewController *)controller{
    [controller.popoverListView dismiss];
    [MobClick event:@"click_certificate_cancel"];
    [SVProgressHUD showWithStatus:@"正在退订，请勿离开"];
    ReqOrderCancelModel *reqModel=[[ReqOrderCancelModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.order_no = controller.orderModel.order_no;
    
    ApiParseOrderCancel *request=[[ApiParseOrderCancel alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespOrderCancelModel *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {
            [MobClick event:@"click_cancel_success"];
            
            //退款成功，刷新loading
            [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil];
            
            [SVProgressHUD dismiss];
            
            
            [controller cancleSuccessed];
            
            
        }else{
            [SVProgressHUD dismiss];
            [controller cancleFailed];
        }
    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
    }];
    
}
- (void)loadCancleOrderWithModel:(OrderModel *)model Controller:(FDMyOrderViewController *)controller{
    
    [MobClick event:@"click_certificate_cancel"];
    [SVProgressHUD showWithStatus:@"正在退订，请勿离开"];
    ReqOrderCancelModel *reqModel=[[ReqOrderCancelModel alloc]init];
    reqModel.kid = [HQDefaultTool getKid];
    reqModel.order_no = model.order_no;
    
    ApiParseOrderCancel *request=[[ApiParseOrderCancel alloc]init];
    RequestModel *requestModel=[request requestData:reqModel];
    [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
        RespOrderCancelModel *paseData=[request parseData:json];
        
        if ([paseData.code isEqualToString:@"1"]) {
            [MobClick event:@"click_cancel_success"];
            
            //退款成功，刷新loading
            [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil];
            
            [SVProgressHUD dismiss];
            
            [controller loadUserOrderListFrist];
            
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD showImage:nil status:paseData.desc];
        }
        controller.selected_btn_model = nil;

    } failure:^(NSError *error) {
        MQQLog(@"%@",[error description]);
        controller.selected_btn_model = nil;
        [SVProgressHUD dismiss];
        [SVProgressHUD showImage:nil status:@"网络连接失败"];
    }];

}

@end
