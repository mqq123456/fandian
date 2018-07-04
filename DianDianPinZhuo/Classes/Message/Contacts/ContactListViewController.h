//
//  ContactListViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "GroupListViewController.h"
#import "EaseUsersListViewController.h"
#import "XBNullView.h"
@interface ContactListViewController : EaseUsersListViewController

@property (strong, nonatomic) GroupListViewController *groupController;

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//群组变化时，更新群组页面
- (void)reloadGroupView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

- (void)setupUntreatedApplyCount;


/** 空试图 */
@property(nonatomic,strong)XBNullView *nullView;

- (void)setupTableFooterView;
- (void)_sortDataArray:(NSArray *)buddyList;
- (void)setupNullImage;
@end
