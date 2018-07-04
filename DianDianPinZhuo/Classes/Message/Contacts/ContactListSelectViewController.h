//
//  ContactListSelectViewController.h
//  ChatDemo-UI2.0
//
//  Created by EaseMob on 15/10/13.
//  Copyright (c) 2015年 EaseMob. All rights reserved.
//
#import "EaseUsersListViewController.h"
#import "EaseMessageModel.h"
@interface ContactListSelectViewController : EaseUsersListViewController

@property (strong ,nonatomic) EaseMessageModel *messageModel;

@end
