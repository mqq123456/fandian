//
//  UsersModel.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersModel : NSObject
///用户的唯一标识,需要登录的接口使用，也作为IM用户名
@property (strong,nonatomic) NSString *kid;

///用户的昵称
@property (strong,nonatomic) NSString *nickname;
///用户头像的url链接地址
@property (strong,nonatomic) NSString *url;
@end
