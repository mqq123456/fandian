//
//  HttpTopicDetail.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDSubjectDetailViewController;
@interface HttpTopicDetail : NSObject
+(id)sharedInstance;
- (void)loadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller;
- (void)commentBackAndLoadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller;
- (void)commentDeleteBackAndLoadWithTopic_id:(NSString *)topic_id controller:(FDSubjectDetailViewController *)controller;
@end
