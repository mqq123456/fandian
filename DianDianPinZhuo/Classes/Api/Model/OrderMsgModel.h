//
//  OrderMsgModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMsgModel : NSObject
///点击文字如：去看看
@property (strong,nonatomic) NSString *title;
///饭票的话题ID数组，如果是普通饭票则为0
@property (strong,nonatomic) NSMutableArray *topic_ids;
///消息描述如：你有未使用的订单，点击查看
@property (strong,nonatomic) NSString *order_desc;
@property (strong,nonatomic) NSString *desc;
///这是一个订单序列的数组如：{‘2015...’,’2015....’}
@property (strong,nonatomic) NSMutableArray *order_nos;
@end
