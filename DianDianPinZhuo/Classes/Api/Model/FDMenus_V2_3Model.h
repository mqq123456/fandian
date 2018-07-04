//
//  FDMenus_V2_3Model.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/16.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDMenus_V2_3Model : NSObject
///菜单ID
@property(nonatomic,copy) NSString * dish_name;
///商家ID
@property(nonatomic,copy) NSString *part_num;
///就餐时间ID
@property(nonatomic,copy) NSString *dish_price;
///包桌套餐价格
@property(nonatomic,copy) NSString *sort;

@end
