//
//  ChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"
#import "EaseMessageViewController.h"
#import "EaseMob.h"
@class ChatViewHeaderView;
@interface ChatViewController : EaseMessageViewController
- (void)addTitleViewWithTitle:(NSString *)title;
@property (nonatomic,strong) ChatViewHeaderView *headView;
@property (nonatomic,copy) NSString *notice;
///资料齐全；跳到群组成员页面

- (void)lookGroupMembers;

- (void)addPerfectView;
@end
