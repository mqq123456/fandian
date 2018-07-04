//
//  RespBaseVersionModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//	版本检查接口返回

#import "RespBaseModel.h"

@interface RespBaseVersionModel : RespBaseModel
///是否有版本更新 1有新应用版本号 0没有,如有则取下面对应的更新信息
@property (copy,nonatomic)NSString *is_new;
///标题
@property (strong,nonatomic) NSString *title;
///更新的提示文字信息
@property (strong,nonatomic) NSString *tips;
///下载地址
@property (strong,nonatomic) NSString *url;

@end
