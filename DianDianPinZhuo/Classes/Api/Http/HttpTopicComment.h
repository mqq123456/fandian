//
//  HttpTopicComment.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDSubjectDetailViewController;
@interface HttpTopicComment : NSObject
+(id)sharedInstance;
- (void)loadTopicCommentWithReply_kid:(NSString *)reply_kid topic_id:(NSString *)topic_id content:(NSString *)content controller:(FDSubjectDetailViewController *)controller;
@end
