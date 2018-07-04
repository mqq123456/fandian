//
//  CommentModel.h
//  pinzhuo
//
//  Created by user on 15/8/5.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//  评论

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///用户呢称
@property (strong,nonatomic) NSString *nick_name;
///用户头像地址
@property (strong,nonatomic) NSString *icon;
///评论内容
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *service_response;

///星级：1-5星
@property (strong,nonatomic) NSString *star;
///评论时间
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSMutableArray *imgs;//图片数组
@property (strong,nonatomic) NSString *comment_id;//
@end
