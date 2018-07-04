//
//  RespUserMessageListModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespUserMessageListModel : RespBaseModel

///MessageModel
@property (nonatomic ,strong) NSMutableArray *messages;
@end
