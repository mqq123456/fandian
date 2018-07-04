//
//  ReqImGroupIdModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//2.5.1	群组ID接口

#import <Foundation/Foundation.h>

@interface ReqImGroupIdModel : NSObject

///用户kid号
@property(nonatomic,copy)NSString *kid;

///订单序号
@property(nonatomic,copy)NSString *order_no;
@property(nonatomic,copy)NSString *table_id;

@end
