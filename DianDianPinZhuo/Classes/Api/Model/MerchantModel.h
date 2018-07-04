//
//  MerchantModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌搜索

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject
///商户ID
@property  int merchant_id;

///商户名称
@property (strong,nonatomic) NSString *merchant_name;
///商户地址
@property (strong,nonatomic) NSString *address;
///商户图片地址：无则用默认的
@property (strong,nonatomic) NSString *icon;

@property (strong,nonatomic) NSString *is_order;

@property (strong,nonatomic) NSString *img;
///星级
@property (strong,nonatomic) NSString *star;
///拼桌价格
@property (strong,nonatomic) NSNumber *price;
///用于搜索的纬度，格式：34.12345
@property (strong,nonatomic) NSString *lat;
///用于搜索的经度，格式：116.12345
@property (strong,nonatomic) NSString *lng;
///距离
@property (strong,nonatomic) NSString *distance;

@property (strong,nonatomic) NSString *food;
@property int vacancy;//空位数
///商家特色描述如：特色：东坡肉 盘锦米饭（直接显示）
@property (strong,nonatomic) NSString *dishes;
///赠送：水果拼盘：内容多个则英文逗号隔开
@property (strong,nonatomic) NSString *give;
///菜品搭配：五荤五素一汤：内容多个则英文逗号隔开
@property (strong,nonatomic) NSString *collocation;
///其它菜单：内容多个则英文逗号隔开
@property (strong,nonatomic) NSString *others;
///品尝人数
@property  int tastes;//tastes
///是否已经评价：0否1是
@property int is_comment;
///是否已售完：0否1是
@property (strong,nonatomic) NSString *sold_out;
///菜单ID
@property (strong,nonatomic) NSString *menu_id;
///距离段：500，1000...加下面字段，有的时候表示开始分段
@property (strong,nonatomic) NSString *segment;
///距离段描述：以下餐厅距您500米以上，
@property (strong,nonatomic) NSString *segment_desc;
///
@property (strong,nonatomic) NSString *payable;
///标签名
@property (strong,nonatomic) NSMutableArray *tags;
@property (strong,nonatomic) NSMutableArray *set_meal_arr;

///是否热门：0否1是
@property (nonatomic, copy) NSString *hot;
///是否新上线：0否1是
@property (nonatomic, copy) NSString *isNew;
/// 已经预订座位数
@property (nonatomic, copy) NSString *order_seat;
/// 曾经同桌人数
@property (nonatomic, copy) NSString *tablemate;
/// 已经预订座位数和曾经同桌人数的描述
@property (nonatomic, copy) NSString *people_desc;
/// 附近就餐人数
@property (nonatomic, copy) NSString *nearby_people;
///座位数描述 ，如“十人桌”“八人桌”
@property (nonatomic, copy) NSString *table_desc;
///商家描述，如“无辣不欢，特色水煮牛肉”
@property (nonatomic, copy) NSString *description_desc;
///附近就餐人数描述
@property (nonatomic, copy) NSString *nearby_people_desc;
///今日限包桌，0否1是
@property (nonatomic, copy) NSString *only_bz;
///今日限拼桌，0否1是
@property (nonatomic, copy) NSString *only_pz;

@end
