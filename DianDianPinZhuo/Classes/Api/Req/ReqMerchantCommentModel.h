//
//  ReqMerchantCommentModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  评论商户

#import <Foundation/Foundation.h>

@interface ReqMerchantCommentModel : NSObject
///用户标识号
@property (strong,nonatomic) NSString *kid;
///订单序号（如果没有置空，PUSH消息里有订单号需带上）
@property (strong,nonatomic) NSString *order_no;
///评论内容，需要urlencode 编码数据,以防止回车等符号
@property (strong,nonatomic) NSString *content;
///星级：1-5星
@property  int star;
///常用评论ID集，逗号隔开
@property (strong,nonatomic) NSString *cc_ids;
///商家ID
@property  int merchant_id;

@property (strong,nonatomic) NSString *imgs;
@end
