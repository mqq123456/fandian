//
//  ReqBaseVersionModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  版本检查

#import <Foundation/Foundation.h>

@interface ReqBaseVersionModel : NSObject
///应用版本号
@property (strong,nonatomic) NSString *cver;
///平台类型0:ios,1:android
@property (strong,nonatomic) NSString *platform;
@end
