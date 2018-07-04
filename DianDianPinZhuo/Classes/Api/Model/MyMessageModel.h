//
//  MyMessageModel.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/7.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessageModel : NSObject

///我们系统内的消息ID
@property (nonatomic ,copy) NSString *my_id;

///友盟产生的消息序列号
@property (nonatomic ,copy) NSString *msg_id;

///通知标题
@property (nonatomic ,copy) NSString *title;

///通知内容
@property (nonatomic ,copy) NSString *content;

///要跳转的页面
@property (nonatomic ,copy) NSString *page;

///跳转页面所需参数（比如订单ID），用逗号隔开
@property (nonatomic ,copy) NSString *param;

///如果有则点击进URL
@property (nonatomic ,copy) NSString *url;

///图片URL
@property (nonatomic ,copy) NSString *img;

///提示
@property (nonatomic ,copy) NSString *hint;

///创建时间
@property (nonatomic ,copy) NSString *create_time;

///是否选择
@property (nonatomic) BOOL isSelected;

@end
