//
//  OrderModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌纪录

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
///订单ID
@property int order_id;

///订单序列号
@property (strong,nonatomic) NSString *order_no;
///订单序列号
@property (strong,nonatomic) NSString *table_id;

///订单日期描述，如“今天”
@property (strong,nonatomic) NSString *order_date;
///订单日期，如“2016-03-04”
@property (strong,nonatomic) NSString *order_date_std;

///用餐时段
@property (strong,nonatomic) NSString *meal_time;
///
@property (strong,nonatomic) NSString *meal_id;

///到店人数
@property int people;

///拼桌单价
@property (nonatomic ,copy) NSString * price;

///应付总价
@property (strong,nonatomic) NSString *payable;

///商户名称
@property (strong,nonatomic) NSString *table_name;
///话题ID，为0则为普通饭票
@property (strong,nonatomic) NSString *topic_id;

///实际应付总价：可能使用优惠券
@property (strong,nonatomic) NSString *paid;

///订单状态：-2用户取消-1超时取消0已提交1支付成功2已完成
@property int state;

///状态描述
@property (strong,nonatomic) NSString *state_desc;

///商户名称
@property (strong,nonatomic) NSString *merchant_name;

///商户ID
@property int merchant_id;

///商户地址
@property (strong,nonatomic) NSString *address;

///商户电话
@property (strong,nonatomic) NSString *phone;

///商家ICON
@property (strong,nonatomic) NSString *icon;

///下订单的时间
@property (nonatomic,strong) NSString *order_time;

///验证串码:用于二唯码生成
@property (strong,nonatomic) NSString *validation;

///转赠URL
@property (strong,nonatomic) NSString *give_url;

///红包URL如果为已支付状态则有
@property (strong,nonatomic) NSString *bag_url;
@property (strong,nonatomic) NSString *bag_title;
@property (strong,nonatomic) NSString *bag_content;

///是否退订0否1是2退款成功
@property int is_unsubscribe;

///是否已用餐：已被扫0否1是
@property int is_use;

///是否已评价0否1是
@property int is_comment;

///下订单的时间戳
@property (nonatomic,strong) NSString *order_stamp;

///服务器当前时间戳
@property (nonatomic,strong) NSString *server_stamp;

///分桌信息
@property(nonatomic ,strong) NSMutableArray *tables;//tableModel

///
//@property(nonatomic ,strong) NSMutableArray *members;//membersModel

///是否有优惠券：0否1是
@property (nonatomic,strong) NSString *is_voucher;

///是否使用了优惠券：0否1是
@property (nonatomic,strong) NSString *use_voucher;

///如果使用了优惠券，显示优惠券的名称
@property (nonatomic,strong) NSString *voucher_name;

///优惠券面值
@property (nonatomic,strong) NSString *voucher_cash;

///商家纬度
@property (nonatomic,strong) NSString *lat;

///商家经度
@property (nonatomic,strong) NSString *lng;

///这是一个下订单前的提示信息字符串数组
@property (nonatomic ,strong) NSMutableArray *order_tips;

///未分桌（tables为空）时的提示信息
@property (copy,nonatomic)NSString * table_hint;
/**
 *  退款toast
 */
@property (copy,nonatomic)NSString * refund_toast;
/**
 *  转赠toast
 */
@property (copy,nonatomic)NSString * deliver_toast;



//@property (strong,nonatomic) NSString *table_id;
//@property (strong,nonatomic) NSString *voucher_id;
@property (strong,nonatomic) NSString *star;

///订单票号
@property (nonatomic,strong) NSString *order_num;//

@property (nonatomic,strong) NSString *is_cancel;//

///是否使用了积分：0否1是
@property (nonatomic,strong) NSString *is_integral_point;
///使用积分数
@property (nonatomic,strong) NSString *integral_point;
///分桌剩余时间
@property (nonatomic,strong) NSString *table_alloc_left_time;
///分桌时间
@property (nonatomic,strong) NSString *table_alloc_time;

///订单类型，0普通订单，1秒杀，2空位赠送
@property (nonatomic,strong) NSString *order_kind;
///还有几个空位
@property (nonatomic,strong) NSString *eggshell_empty_seat;

@property (nonatomic,strong) NSString *eggshell_window_content;
///空位分享标题
@property (nonatomic,strong) NSString *weixin_empty_seat_title;
///空位分享副标题
@property (nonatomic,strong) NSString *weixin_empty_seat_content;
///空位分享url
@property (nonatomic,strong) NSString *weixin_empty_seat_url;

@property (nonatomic,strong) NSString *is_bz;
///套餐描述，如“四人套餐”
@property (nonatomic,strong) NSString *meal_desc;

///微信饭票分享标题
@property (nonatomic,strong) NSString *weixin_share_title;
///微信饭票分享副标题
@property (nonatomic,strong) NSString *weixin_share_content;
///微信饭票分享url
@property (nonatomic,strong) NSString *weixin_share_url;
@property (nonatomic,strong) NSString *group_share_title;    //群组分享文案，如“XXX预订了洱语的四人套餐”
@property (nonatomic,strong) NSString *group_share_hint;//群组分享动作，如“立即查看”

///话题分享标题
@property (strong,nonatomic) NSString *weixin_topic_title;
///话题分享副标题
@property (strong,nonatomic) NSString *weixin_topic_content;
///话题分享url
@property (strong,nonatomic) NSString *weixin_topic_url;
///扫码验证提示
@property (strong,nonatomic) NSString *scan_code_hint;

@end
