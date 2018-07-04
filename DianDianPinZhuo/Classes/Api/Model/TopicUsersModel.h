//
//  TopicUsersModel.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

///话题饭票详情里的users
#import <Foundation/Foundation.h>

@interface TopicUsersModel : NSObject

///同桌人的昵称
@property(nonatomic,copy)NSString *nickname;
///同桌人的头像
@property(nonatomic,copy)NSString *img;
///同桌人的描述
@property(nonatomic,copy)NSString *myself_desc;

@end
