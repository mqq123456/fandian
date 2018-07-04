//
//  RespBaseModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespBaseModel : NSObject
///1表示成功，0表示失败
@property (strong,nonatomic) NSString *code;
///成功或失败原因
@property (strong,nonatomic) NSString *desc;

@end
