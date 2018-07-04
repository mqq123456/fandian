//
//  ReqMerchantSeckillListModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqMerchantSeckillListModel : NSObject

///用户当前经度，格式：116.12345
@property(nonatomic,copy)NSString *local_lng;

///用户当前纬度，格式：34.12345
@property(nonatomic,copy)NSString *local_lat;

///经纬度是否需要纠偏标志：IOS赋值1，android可以不用传
@property(nonatomic,copy)NSString *local;
///预定时段id
@property(nonatomic,copy)NSString *meal_id;
///页码ID，默认1
@property(nonatomic)int page;

///上一页的最大距离，第一页为0
@property(nonatomic,copy)NSString *max_distance;




@end
