//
//  MealsModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealsModel : NSObject

///开餐时段ID:用于搜索接口、订单接口等
@property (strong,nonatomic) NSString *meal_id;

///开餐时段描述
@property (strong,nonatomic) NSString *meal_desc;

///是否是最近开餐时段，1为是0为否，2为已过期时段，3为已订满
@property (copy ,nonatomic) NSString *state;
/**
 *  该餐点是否有优惠，1是0否
 */
@property (copy ,nonatomic) NSString *is_discount;


@end
