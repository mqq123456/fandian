//
//  HttpTopicSearch.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDTopicsViewController;
@interface HttpTopicSearch : NSObject
@property (nonatomic ,assign) int page;
+(id)sharedInstance;
- (void)topicSearchWithLat:(NSString *)latString lng:(NSString *)lngString topic_class_id:(NSString *)topic_class_id viewController:(FDTopicsViewController *)controller;

- (void)MJRefreshTopTopicSearchWithLat:(NSString *)latString lng:(NSString *)lngString topic_class_id:(NSString *)topic_class_id viewController:(FDTopicsViewController *)controller;

- (void)MJRefreshMoreTopicSearchWithLat:(NSString *)latString lng:(NSString *)lngString topic_class_id:(NSString *)topic_class_id viewController:(FDTopicsViewController *)controller;
- (void)topicSearchTapWithLat:(NSString *)latString lng:(NSString *)lngString topic_class_id:(NSString *)topic_class_id viewController:(FDTopicsViewController *)controller;
@end
