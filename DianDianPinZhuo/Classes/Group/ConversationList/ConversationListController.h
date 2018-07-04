//
//  ConversationListController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//
#import "EaseConversationListViewController.h"
#import "EaseMob.h"
@interface ConversationListController : EaseConversationListViewController

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;


@property (copy, nonatomic) NSString *share_title;
///立即查看
@property (copy, nonatomic) NSString *share_hint;

@property (copy, nonatomic) NSString *share_url;

@property (copy, nonatomic) NSString * type;

@end
