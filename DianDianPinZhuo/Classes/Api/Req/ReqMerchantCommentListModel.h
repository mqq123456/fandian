//
//  ReqMerchantCommentListModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  评论列表

#import <Foundation/Foundation.h>

@interface ReqMerchantCommentListModel : NSObject
///商户ID号
@property (strong,nonatomic) NSString *merchant_id;
///页码数默认1
@property  int page;

@end
