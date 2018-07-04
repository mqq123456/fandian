//
//  ReqOrderDiscountInfoModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqOrderDiscountInfoModel : NSObject
@property (strong,nonatomic) NSString *kid;
@property (strong,nonatomic) NSString *merchant_id;
@property (strong,nonatomic) NSString *meal_id;
@property (strong,nonatomic) NSString *meal_date;
@property (strong,nonatomic) NSString *menu_id;
@property (strong,nonatomic) NSString *people;

@property (strong,nonatomic) NSString *topic_id;

///订单类型，普通订单为0，秒杀为1，空位赠送订单为2
@property (strong,nonatomic) NSString *order_kind;
///是否包桌订单 0否 1是
@property (strong,nonatomic) NSString *is_bz;


@end
