//
//  HttpTopicJoin.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDSubjectDetailViewController;
@interface HttpTopicJoin : NSObject
+(id)sharedInstance;
- (void)loadWithTopicJoin:(NSString *)topic_id andPeople:(NSString *)people controller:(FDSubjectDetailViewController *)controller;

@end
