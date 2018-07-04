//
//  GrowUpDetailModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrowUpDetailModel : NSObject
///商家名称
@property (nonatomic,strong) NSString *merchant_name;
///消费方式及人数
@property (nonatomic,strong) NSString *content;
///就餐日期
@property (nonatomic,strong) NSString *order_date;
///成长值收入
@property (nonatomic,strong) NSString *income;

@end
