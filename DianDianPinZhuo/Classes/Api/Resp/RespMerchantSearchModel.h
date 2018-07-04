//
//  RespMerchantSearchModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	拼桌搜索接口返回

#import "RespBaseModel.h"

@interface RespMerchantSearchModel : RespBaseModel

@property (strong,nonatomic) NSMutableArray *merchants;//MerchantModel
///当前开餐状态：1正常开餐，2已过当天第一餐开餐时间，3节假日不开餐,4已过当天第二餐开餐时间
@property (copy,nonatomic) NSString *meal_status;
///开餐状态描述
@property (copy,nonatomic) NSString *meal_desc;
///上一页的最大距离，第一页为0
@property (copy,nonatomic) NSString *max_distance;
///已订满的提示
@property (copy,nonatomic) NSString *soldout_hint;


@end
