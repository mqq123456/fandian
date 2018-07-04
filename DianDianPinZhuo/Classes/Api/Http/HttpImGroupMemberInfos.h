//
//  HttpImGroupMemberInfos.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDGroupMemberViewController;
@class ChatViewController;
@interface HttpImGroupMemberInfos : NSObject
+(id)sharedInstance;
- (void)loadImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller;
- (void)loadTopImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller;

- (void)loadMoreImGroupMemberInfoWithController:(FDGroupMemberViewController *)controller;

- (void)loadChatViewImGroupMemberInfoWithController:(ChatViewController *)controller group_id:(NSString *)group_id;
@end
