//
//  ReqMerchantDetailModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌详情

#import <Foundation/Foundation.h>

@interface ReqMerchantDetailModel : NSObject
///商户id
@property (copy,nonatomic) NSString *merchant_id;
///用于搜索的纬度，格式：34.12345
@property (copy,nonatomic) NSString *lat;
///用于搜索的经度，格式：116.12345
@property (copy,nonatomic) NSString *lng;
///用户当前纬度，格式：34.12345
@property (copy,nonatomic) NSString *local_lat;
///用户当前经度，格式：116.12345
@property (copy,nonatomic) NSString *local_lng;
///开餐时间ID:(loading接口获取为准)
@property (copy,nonatomic) NSString *meal_id;
@property (copy,nonatomic) NSString *menu_id;

///开餐日期：(loading接口获取为准)
@property (copy,nonatomic) NSString *meal_date;

///经纬度是否需要纠偏标志：IOS赋值1，android可以不用传
@property (copy,nonatomic) NSString *local;
@property (copy,nonatomic) NSString *kid;
@property (copy,nonatomic) NSString *is_bz;


@end
