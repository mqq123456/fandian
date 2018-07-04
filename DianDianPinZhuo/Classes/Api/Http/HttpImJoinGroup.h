//
//  HttpImJoinGroup.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDNotJoinGroupsViewController;
@class FDTopicsViewController;
@interface HttpImJoinGroup : NSObject
+(id)sharedInstance;
- (void)loadImJoinGroupWithGroup_id:(NSString *)group_id controller:(FDNotJoinGroupsViewController *)controller group_name:(NSString *)group_name;
- (void)loadImJoinGroupWithGroup_id_topicsVC:(NSString *)group_id controller:(FDTopicsViewController *)controller group_name:(NSString *)group_name;
@end
