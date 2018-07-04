//
//  RespUserOrderDetailModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/1.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RespBaseModel.h"
#import "OrderModel.h"
@interface RespUserOrderDetailModel : RespBaseModel

@property (nonatomic,strong) OrderModel *order;//订单
@property (nonatomic,copy) NSString *menu_id;

@end
