//
//  ReqUserOrderListModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  拼桌记录

#import <Foundation/Foundation.h>

@interface ReqUserOrderListModel : NSObject

@property (strong,nonatomic) NSString *kid;
@property int page;
///订单状态：-3已过期-2用户取消-1超时取消0已提交1支付成功2待评价3已完成
@property (nonatomic , copy) NSString *state;

@end
