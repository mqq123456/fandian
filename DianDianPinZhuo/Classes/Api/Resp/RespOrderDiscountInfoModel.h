//
//  RespOrderDiscountInfoModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespOrderDiscountInfoModel : RespBaseModel
@property (strong,nonatomic) NSString *voucher_id;
@property (strong,nonatomic) NSString *voucher_type;
@property (strong,nonatomic) NSString *discount;
///开餐日期：(loading接口获取为准)
@property (strong,nonatomic) NSString *voucher_cash;
@property (strong,nonatomic) NSString *most_discount_cash;
///商户id
@property (strong,nonatomic) NSString *integral_point_point;
@property (strong,nonatomic) NSString *integral_point_hint_a;
@property (strong,nonatomic) NSString *integral_point_hint_b;
@property (strong,nonatomic) NSString *integral_point_deduction_point;
@property (strong,nonatomic) NSString *integral_point_deduction_cash;
@property (strong,nonatomic) NSString *activity_name;
@property (strong,nonatomic) NSString *activity_cash;
@property (strong,nonatomic) NSString *activity_id;
@property (strong,nonatomic) NSString *paid;

///明日预订提示
@property (strong,nonatomic) NSString *order_hint;

@end
