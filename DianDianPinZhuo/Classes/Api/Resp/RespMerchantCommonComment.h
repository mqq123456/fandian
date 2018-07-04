//
//  RespMerchantCommonComment.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/24.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  常用评论列表接口

#import "RespBaseModel.h"

@interface RespMerchantCommonComment : RespBaseModel
@property (nonatomic,strong) NSMutableArray *items;//UsedCommentModel

@end
