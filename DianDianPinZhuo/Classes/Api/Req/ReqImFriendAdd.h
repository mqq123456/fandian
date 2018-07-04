//
//  ReqImFriendAdd.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqImFriendAdd : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///同意好友邀请的用户
@property (strong,nonatomic) NSString *friend_kid;

@end
