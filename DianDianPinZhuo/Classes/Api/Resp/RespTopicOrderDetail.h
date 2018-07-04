//
//  RespTopicOrderDetail.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespTopicOrderDetail : RespBaseModel
@property (nonatomic ,strong) NSString *content;
///用户上传的图片
@property (strong,nonatomic) NSString *img;
///用户是否要请大家吃饭（0 是，1 否）
@property (assign,nonatomic) int is_eat;
///开餐时间ID:(loading接口获取为准)
@property (strong,nonatomic) NSString *nickname;
///开餐日期：(loading接口获取为准)
@property (strong,nonatomic) NSString *is_free;
///商户id
@property (strong,nonatomic) NSString *merchant_id;
@property (strong,nonatomic) NSString *merchant_name;
@property (strong,nonatomic) NSString *meal_time;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *table_desc;
@property (strong,nonatomic) NSString *table_no;
///是几号桌
@property (strong,nonatomic) NSString *table_name;
///默认提示，已加入的饭友
@property (strong,nonatomic) NSString *rice_friend;
///服务器当前时间戳
@property (nonatomic,strong) NSString *server_stamp;

///服务器当前时间戳
@property (nonatomic,strong) NSString *table_alloc_left_time;
///分桌时间
@property (nonatomic,strong) NSString *table_alloc_time;

@property (strong,nonatomic) NSMutableArray *users;
///用户简单的自我介绍
@property (strong,nonatomic) NSString *myself_desc;
///单价
@property (strong,nonatomic) NSString *price;
///星级
@property (strong,nonatomic) NSString *star;
///日期
@property (strong,nonatomic) NSString *meal_date;
///就餐日期描述
@property (strong,nonatomic) NSString *meal_date_std;
///座位数
@property (strong,nonatomic) NSString *order_seat;
///票号
@property (strong,nonatomic) NSString *order_num;
///二维码
@property (strong,nonatomic) NSString *validation;

///下单前的提示文字
@property (strong,nonatomic) NSMutableArray *order_tips;

///总下单用户人数
@property (strong,nonatomic) NSString *total_order_people;
///总人数
@property (strong,nonatomic) NSString *total_people;

@property (nonatomic ,strong) NSString *lat;

@property (strong,nonatomic) NSString *lng;

@property (nonatomic ,strong) NSString *group_id;

@property (strong,nonatomic) NSString *group_name;
///订单号
@property (strong,nonatomic) NSString *order_no;
@property (strong,nonatomic) NSString *table_id;
///红包Url
@property (strong,nonatomic) NSString *bag_url;
///是否可以退订  ：0否1是
@property (strong,nonatomic) NSString *is_cancel;
///支付总额
@property (strong,nonatomic) NSString *paid;

@property (strong,nonatomic) NSString *meal_id;
@property (strong,nonatomic) NSString *icon;

///2.1
///话题分享标题
@property (strong,nonatomic) NSString *weixin_topic_title;
///话题分享副标题
@property (strong,nonatomic) NSString *weixin_topic_content;
///话题分享url
@property (strong,nonatomic) NSString *weixin_topic_url;
@property (strong,nonatomic) NSString *is_bz;


@end
