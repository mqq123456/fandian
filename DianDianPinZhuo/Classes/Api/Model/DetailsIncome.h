//
//  DetailsIncome.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailsIncome : NSObject
///积分收入原因（评价获得）
@property (strong,nonatomic) NSString *reason;

///商户名称
@property (strong,nonatomic) NSString *merchant_name;
///就餐方式及人数
@property (strong,nonatomic) NSString *content;

///就餐日期
@property (strong,nonatomic) NSString *order_date;
///积分收入
@property (strong,nonatomic) NSString *point;


@end
