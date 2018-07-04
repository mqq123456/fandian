//
//  TaoCanModel.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaoCanModel : NSObject

///菜单ID
@property(nonatomic,copy) NSString * menu_id;
///商家ID
@property(nonatomic,copy) NSString *merchant_id;
///就餐时间ID
@property(nonatomic,copy) NSString *mt_time;
///包桌套餐价格
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *price_desc;

///套餐人数
@property(nonatomic,copy) NSString *menu_people;
///套餐人数描述
@property(nonatomic,copy) NSString *menu_people_desc;
///菜单是否新的 0否 1是
@property(nonatomic,copy) NSString *menu_is_new;
///是否已订满 0否 1是
@property(nonatomic,copy) NSString *is_soldout;
///imgs是个数组，菜单展示
@property(nonatomic,strong) NSMutableArray *imgs;
///menus是个索引数组
@property(nonatomic,strong) NSMutableArray *menus;
///推荐几人就餐提示
@property(nonatomic,copy) NSString *recommend_hint;

///原价
@property(nonatomic,copy) NSString * original_price;
///饭点价
@property(nonatomic,copy) NSString *jzjg;
///抵扣金额的总和
@property(nonatomic,copy) NSString *total_deduction;
/**
 *  使用抵扣券、活动优惠、积分抵扣后的最终金额
 */
@property(nonatomic,copy) NSString *paid;

@end
