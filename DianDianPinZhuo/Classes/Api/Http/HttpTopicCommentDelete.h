//
//  HttpTopicCommentDelete.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDSubjectDetailViewController;
@interface HttpTopicCommentDelete : NSObject
+(id)sharedInstance;
- (void)loadTopicCommentDeleteWithController:(FDSubjectDetailViewController *)controller comment_id:(NSString *)comment_id;
@end
