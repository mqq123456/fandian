//
//  ReqMerchantSearchModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌搜索

#import <Foundation/Foundation.h>

@interface ReqMerchantSearchModel : NSObject
///用于搜索的经度，格式：116.12345
@property (strong,nonatomic) NSString *lng;
///用于搜索的纬度，格式：34.12345
@property (strong,nonatomic) NSString *lat;
///用户当前纬度，格式：34.12345
@property (strong,nonatomic) NSString *local_lat;
///用户当前经度，格式：116.12345
@property (strong,nonatomic) NSString *local_lng;
///开餐时间ID:(loading接口获取为准)
@property (strong,nonatomic) NSString *meal_id;
///开餐日期：(loading接口获取为准)
@property (copy,nonatomic) NSString *meal_date;
///定餐人数：10人视为包桌
@property (strong,nonatomic) NSString *people;
///页码ID，默认1
@property (nonatomic) int page;
///经纬度是否需要纠偏标志：IOS赋值1，android可以不用传
@property (strong,nonatomic) NSString *local;//0
///上一页的最大距离，第一页为0
@property (strong,nonatomic) NSString *max_distance;//0
@property (strong,nonatomic) NSString *is_bz;//0
@property (strong,nonatomic) NSString *kid;//0
@end
