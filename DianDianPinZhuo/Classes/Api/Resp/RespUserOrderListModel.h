//
//  RespUserOrderListModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌记录列表接口返回

#import "RespBaseModel.h"

@interface RespUserOrderListModel : RespBaseModel

@property (strong,nonatomic) NSMutableArray *orders;//OrderModel

@end
