//
//  HttpOrderBook.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "HttpOrderBook.h"
#import "ApiParseOrderBook.h"
#import "ReqOrderBookModel.h"
#import "RespOrderBookModel.h"
#import "ReqUserVoucherListModel.h"
#import "RequestModel.h"
#import "ApiParseUserVoucherList.h"
#import "HQHttpTool.h"
#import "RespUserVoucherListModel.h"
#import "VoucherModel.h"
#import "DataSigner.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "PayResultView.h"
#import "UMSocial.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UIKit/UIKit.h>
#import "FDTicket_New_ViewController.h"
#import "FDOrderViewController.h"
@implementation HttpOrderBook
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
 *  去下单
 *
 */
- (void)orderClick:(FDOrderViewController *)controller button:(UIButton *)button{
    ///去支付
    
    [MobClick event:@"click_order_pay"];
    if (controller.payWay==0) {
        [SVProgressHUD showImage:nil status:@" 请选择支付方式 "];
        return;
    }
    if (controller.payWay==2&&![WXApi isWXAppInstalled]) {
        [SVProgressHUD showImage:nil status:@"请下载微信客户端后完成支付"];
        return;
    }
    button.enabled = NO;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.color = [UIColor grayColor];
    activity.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64);
    [controller.view addSubview:activity];
    [activity startAnimating];
    
    if (controller.order_on) {
        [controller orderCancel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ReqOrderBookModel *reqModel=[[ReqOrderBookModel alloc]init];
            reqModel.kid = [HQDefaultTool getKid];
            if (controller.merchant_id) {
                reqModel.merchant_id = [NSString stringWithFormat:@"%@",controller.merchant_id];
            }
            reqModel.meal_id = controller.meal_id;
            reqModel.meal_date = controller.kdate;
            reqModel.people = controller.people;
            reqModel.menu_id = controller.menu_id;
            if (controller.voucherModel) {
                reqModel.voucher_id = [NSString stringWithFormat:@"%d", controller.voucherModel.voucher_id];
            }
            
            reqModel.pay_type = [NSString stringWithFormat:@"%zd",controller.payWay];
            
            
            reqModel.integral_point = controller.integral_point;
           
            reqModel.topic_id = controller.topic_id;
            if (controller.initial_topic) {
                reqModel.initial_topic = controller.initial_topic;
            }
            reqModel.order_kind = controller.order_kind;
            reqModel.vacancy_id = controller.vacancy_id;
            reqModel.activity_id = controller.activity_id;
            reqModel.table_id = controller.table_id;
            reqModel.is_bz = controller.is_bz;
            ApiParseOrderBook *request=[[ApiParseOrderBook alloc]init];
            
            RequestModel *requestModel=[request requestData:reqModel];
            [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
                RespOrderBookModel *paseData=[request parseData:json];
                
                if ([paseData.code isEqualToString:@"1"]) {
                    controller.order_on = paseData.order.order_no;
                    [activity stopAnimating];
                    if (paseData.alOrder) {
                        Order *order = paseData.alOrder;
                        
                        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                        NSString *appScheme = @"DianDianPinZhuo";
                        
                        //将商品信息拼接成字符串
                        NSString *orderSpec = [order description];
                        MQQLog(@"orderSpec = %@",orderSpec);//商品信息打印
                        
                        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
                        id<DataSigner> signer = CreateRSADataSigner(order.privateKey);
                        NSString *signedString = [signer signString:orderSpec];
                        
                        //将签名成功字符串格式化为订单字符串,请严格按照该格式！！！
                        NSString *orderString = nil;
                        if (signedString != nil) {
                            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                           orderSpec, signedString, @"RSA"];
                            //获取支付结果
                            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                                
                                MQQLog(@"reslut = %@",resultDic[@"resultStatus"]);
                                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) { // 支付成功
                                    [MobClick event:@"click_pay_success"];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];

                                        FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc]init];
                                        ticket.order_no = controller.order_on;
                                        ticket.isFromPay = YES;
                                        ticket.isFromPayShowBonus = YES;
                                        [controller.navigationController pushViewController:ticket animated:YES];
                                        
                                }else{//支付失败
                                    [MobClick event:@"click_pay_fail"];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];
                                    if ([controller.navigationController.topViewController isKindOfClass:[controller class]]) {
                                        [controller PayFail];
                                    }
                                    
                                }
                            }];
                        }
                        
                    }
                    if (paseData.wxOrder) {
                        PayReq *request = [[PayReq alloc] init];
                        request.partnerId = paseData.wxOrder.partnerId;
                        request.prepayId= paseData.wxOrder.prepayId;
                        request.package = paseData.wxOrder.package;
                        request.nonceStr= paseData.wxOrder.nonceStr;
                        request.timeStamp= paseData.wxOrder.timeStamp;
                        request.sign= paseData.wxOrder.sign;
                        [WXApi sendReq:request];
                        
                    }
                    button.enabled = YES;
                }else{
                    button.enabled = YES;
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:paseData.desc delegate:controller cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alertView.tag = 3000;
                    [alertView show];
                }
                [activity stopAnimating];
                
            } failure:^(NSError *error) {
                [activity stopAnimating];
                button.enabled = YES;
                MQQLog(@"==%@",[error description]);
                [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
                
            }];
            
        });
        
        
    }else{
        ReqOrderBookModel *reqModel=[[ReqOrderBookModel alloc]init];
        reqModel.kid = [HQDefaultTool getKid];
        if (controller.merchant_id) {
            reqModel.merchant_id = [NSString stringWithFormat:@"%@",controller.merchant_id];
        }
        
        reqModel.meal_id = controller.meal_id;
        reqModel.meal_date = controller.kdate;
        reqModel.people = controller.people;
        reqModel.menu_id = controller.menu_id;
        if (controller.voucherModel) {
            reqModel.voucher_id = [NSString stringWithFormat:@"%d", controller.voucherModel.voucher_id];
        }
        
        reqModel.pay_type = [NSString stringWithFormat:@"%zd",controller.payWay];
        
        
        
        reqModel.integral_point = controller.integral_point;
        reqModel.activity_id = controller.activity_id;
        reqModel.topic_id = controller.topic_id;
        if (controller.initial_topic) {
            reqModel.initial_topic = controller.initial_topic;
        }
        reqModel.order_kind = controller.order_kind;
        reqModel.vacancy_id = controller.vacancy_id;
        reqModel.table_id = controller.table_id;
        reqModel.is_bz = controller.is_bz;
        ApiParseOrderBook *request=[[ApiParseOrderBook alloc]init];
        
        RequestModel *requestModel=[request requestData:reqModel];
        [HQHttpTool post:requestModel.url params:requestModel.parameters success:^(id json) {
            RespOrderBookModel *paseData=[request parseData:json];
            
            if ([paseData.code isEqualToString:@"1"]) {
                controller.order_on = paseData.order.order_no;
                [activity stopAnimating];
                if (paseData.alOrder) {
                    Order *order = paseData.alOrder;
                    
                    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                    NSString *appScheme = @"DianDianPinZhuo";
                    
                    //将商品信息拼接成字符串
                    NSString *orderSpec = [order description];
                    MQQLog(@"orderSpec = %@",orderSpec);//商品信息打印
                    
                    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
                    id<DataSigner> signer = CreateRSADataSigner(order.privateKey);
                    NSString *signedString = [signer signString:orderSpec];
                    
                    //将签名成功字符串格式化为订单字符串,请严格按照该格式！！！
                    NSString *orderString = nil;
                    if (signedString != nil) {
                        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                       orderSpec, signedString, @"RSA"];
                        //获取支付结果
                        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            
                            MQQLog(@"reslut = %@",resultDic[@"resultStatus"]);
                            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) { // 支付成功
                                [MobClick event:@"click_pay_success"];
                                [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];
                                [[NSNotificationCenter defaultCenter] postNotificationName:HiddenHomeBottomTicketView object:nil];

                                    FDTicket_New_ViewController *ticket = [[FDTicket_New_ViewController alloc]init];
                                    ticket.order_no = controller.order_on;
                                    ticket.isFromPay = YES;
                                    ticket.isFromPayShowBonus = YES;
                                    [controller.navigationController pushViewController:ticket animated:YES];
                                    
                            }else{//支付失败
                                [MobClick event:@"click_pay_fail"];
                                [[NSNotificationCenter defaultCenter] postNotificationName:PayFailOrScuessReloadHome object:nil];
                                if ([controller.navigationController.topViewController isKindOfClass:[controller class]]) {
                                    [controller PayFail];
                                }
                                
                            }
                        }];
                    }
                    
                }
                if (paseData.wxOrder) {
                    PayReq *request = [[PayReq alloc] init];
                    request.partnerId = paseData.wxOrder.partnerId;
                    request.prepayId= paseData.wxOrder.prepayId;
                    request.package = paseData.wxOrder.package;
                    request.nonceStr= paseData.wxOrder.nonceStr;
                    request.timeStamp= paseData.wxOrder.timeStamp;
                    request.sign= paseData.wxOrder.sign;
                    [WXApi sendReq:request];
                    
                }
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:paseData.desc delegate:controller cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertView.tag = 3000;
                [alertView show];
            }
            [activity stopAnimating];
            button.enabled = YES;
        } failure:^(NSError *error) {
            [activity stopAnimating];
            button.enabled = YES;
            MQQLog(@"==%@",[error description]);
            [SVProgressHUD showImage:nil status:@"联网失败，请检查网络"];
            
        }];
    }
    
    
    
    
}

@end
