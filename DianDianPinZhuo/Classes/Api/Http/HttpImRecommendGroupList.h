//
//  HttpImRecommendGroupList.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDNotJoinGroupsViewController;
@interface HttpImRecommendGroupList : NSObject
+(id)sharedInstance;
- (void)loadRecommendGroupListWithController:(FDNotJoinGroupsViewController *)controller;
@end
