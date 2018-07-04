//
//  SeckillOrderModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/20.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeckillOrderModel : NSObject
///订单ID
@property int order_id;

///订单序列号
@property (strong,nonatomic) NSString *order_no;

///订单日期
@property (strong,nonatomic) NSString *order_date;

///用餐时段
@property (strong,nonatomic) NSString *meal_time;

///到店人数
@property int people;

///拼桌单价
@property (nonatomic ,copy) NSString * price;

///应付总价
@property (strong,nonatomic) NSString *payable;

///商户名称
@property (strong,nonatomic) NSString *table_name;

///实际应付总价：可能使用优惠券
@property (strong,nonatomic) NSString *paid;


///下订单的时间
@property (nonatomic,strong) NSString *order_time;

///下订单的时间戳
@property (nonatomic,strong) NSString *order_stamp;

///服务器当前时间戳
@property (nonatomic,strong) NSString *server_stamp;



@end
