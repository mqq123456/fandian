//
//  ReqOrderCancelModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  取消订单

#import <Foundation/Foundation.h>

@interface ReqOrderCancelModel : NSObject

@property (strong,nonatomic) NSString *kid;
///订单序号
@property (strong,nonatomic) NSString *order_no;

@end
