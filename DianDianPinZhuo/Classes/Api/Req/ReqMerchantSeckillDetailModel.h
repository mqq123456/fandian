//
//  ReqMerchantSeckillDetailModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqMerchantSeckillDetailModel : NSObject

///商户id
@property(nonatomic,copy)NSString *merchant_id;

///用户当前经度，格式：116.12345
@property(nonatomic,copy)NSString *local_lng;

///用户当前纬度，格式：34.12345
@property(nonatomic,copy)NSString *local_lat;

///经纬度是否需要纠偏标志：IOS赋值1，android可以不用传
@property(nonatomic,copy)NSString *local;

///用户唯一标识
@property(nonatomic,copy)NSString *meal_id;

@end
