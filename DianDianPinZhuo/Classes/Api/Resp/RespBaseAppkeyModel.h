//
//  RespBaseAppkeyModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  加密串请求返回

#import "RespBaseModel.h"

@interface RespBaseAppkeyModel : RespBaseModel

///加密串
@property (strong,nonatomic) NSString *key;

@end
