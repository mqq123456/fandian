//
//  RespUserVoucherListModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	优惠券列表接口返回

#import "RespBaseModel.h"

@interface RespUserVoucherListModel : RespBaseModel

@property (strong,nonatomic) NSMutableArray *vouchers;//VoucherModel

@end
