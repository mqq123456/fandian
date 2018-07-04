//
//  SeatMealArrModel.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatMealArrModel : NSObject //套餐种类 是个数组

///套餐价格
@property(nonatomic,copy) NSString * price;
///套餐人数
@property(nonatomic,copy) NSString *menu_people;
///是否新菜单 0否 1是
@property(nonatomic,copy) NSString *menu_is_new;
///价格+套餐人数字符串
@property(nonatomic,copy) NSAttributedString *price_people_num_desc;
@property(nonatomic,copy) NSString *original_price;
@property(nonatomic,copy) NSString *jzjg;
@end
