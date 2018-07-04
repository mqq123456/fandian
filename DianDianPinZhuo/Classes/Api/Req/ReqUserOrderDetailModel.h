//
//  ReqUserOrderDetailModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/1.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserOrderDetailModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///订单序列号
@property (strong,nonatomic) NSString *order_no;


@end
