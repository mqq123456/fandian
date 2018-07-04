//
//  ReqUserVoucherListModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  优惠券

#import <Foundation/Foundation.h>

@interface ReqUserVoucherListModel : NSObject

///用户唯一标识
@property (strong,nonatomic) NSString *kid;

///页码默认1
@property int page;

///使用人数：如果为0则全部显示，大于0则显示满足人数条件的优惠券
@property (nonatomic ,copy) NSString *people;

///
@property (nonatomic ,copy) NSString *order_no;

///商家ID，如果商家ID大于0，过滤不满足商家的
@property (nonatomic ,copy) NSString *merchant_id;

///开餐时间ID，如果开餐时间ID大于0，过滤不满足开餐时间的
@property (nonatomic ,copy) NSString *meal_id;

@end
