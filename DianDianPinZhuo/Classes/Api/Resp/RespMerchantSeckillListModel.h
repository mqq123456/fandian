//
//  RespMerchantSeckillListModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespMerchantSeckillListModel : RespBaseModel


///本页最大距离（单位米），分页时取此值上传，如439
@property(nonatomic,copy)NSString *max_distance;
///距离秒杀开始时间（单位秒，若已开始则为0或负值）
@property(nonatomic,copy)NSString *start_time;
///距离秒杀结束时间（单位秒，若已结束则为0或负值）
@property(nonatomic,copy)NSString *end_time;

///就餐日期
@property(nonatomic,copy)NSString *order_date;
///就餐时段
@property(nonatomic,copy)NSString *meal_time;

@property (strong,nonatomic) NSMutableArray *merchants;//MerchantModel

@end
