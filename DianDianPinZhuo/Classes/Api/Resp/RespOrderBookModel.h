//
//  RespOrderBookModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	预订接口返回

#import "RespBaseModel.h"
#import "OrderModel.h"
#import "Order.h"
#import "WXApiObject.h"
@interface RespOrderBookModel : RespBaseModel

///订单序号
@property (nonatomic,strong) NSString *is_order;
///还需支付的费用
@property (nonatomic,strong) NSString *ca_se;
///还需支付的费用
@property (nonatomic,strong) OrderModel *order;

@property (nonatomic,strong) Order *alOrder;//支付宝

@property (nonatomic,strong) PayReq *wxOrder;//微信

@end
