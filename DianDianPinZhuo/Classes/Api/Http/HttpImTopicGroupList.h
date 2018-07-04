//
//  HttpImTopicGroupList.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDTopicsViewController;
@interface HttpImTopicGroupList : NSObject
+(id)sharedInstance;
- (void)loadImGroupListWithController:(FDTopicsViewController *)controller;
- (void)loadFristImGroupListWithController:(FDTopicsViewController *)controller;
@end
