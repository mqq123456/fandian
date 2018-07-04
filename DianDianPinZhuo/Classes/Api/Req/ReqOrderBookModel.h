//
//  ReqOrderBookModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  预订

#import <Foundation/Foundation.h>

@interface ReqOrderBookModel : NSObject

///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///商户ID
@property (strong,nonatomic) NSString *merchant_id;
///开餐时间ID:(loading接口获取为准)
@property (strong,nonatomic) NSString *meal_id;

///开餐日期，如2015-10-11(loading接口获取kdate为准)
@property (strong,nonatomic) NSString *meal_date;
///订单人数
@property (strong,nonatomic) NSString *people;
///菜单ID，搜索和详情接口来
@property (strong,nonatomic) NSString *menu_id;
///优惠券ID,优惠券列表可使用的
@property (strong,nonatomic) NSString *voucher_id;
///1支付宝，2微信支付
@property (strong,nonatomic) NSString *pay_type;

///使用抵扣的积分数
@property (strong,nonatomic) NSString *integral_point;
///活动名称
@property (strong,nonatomic) NSString *activity_id;
@property (strong,nonatomic) NSString *table_id;

///话题ID
@property (strong,nonatomic) NSString *topic_id;
///发起话题为1，加入话题为0
@property (strong,nonatomic) NSString *initial_topic;
///订单类型，普通订单为0，秒杀为1，空位赠送订单为2
@property (nonatomic,strong) NSString *order_kind;
@property (nonatomic,copy) NSString *vacancy_id;

@property (strong,nonatomic) NSString *is_bz;
@end
