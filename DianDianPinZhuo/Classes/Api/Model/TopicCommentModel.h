//
//  TopicCommentModel.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicCommentModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///用户呢称
@property (strong,nonatomic) NSString *nickname;
///用户头像地址
@property (strong,nonatomic) NSString *img;
///评论内容
@property (strong,nonatomic) NSString *character_desc;
///星级：1-5星
@property (strong,nonatomic) NSString *content;

@property (strong,nonatomic) NSString *reply_kid;

@property (strong,nonatomic) NSString *reply_nickname;
///评论ID
@property (strong,nonatomic) NSString *comment_id;

@property (strong,nonatomic) NSString *time_desc;


@end
