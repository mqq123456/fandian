//
//  FDTopicsTool.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDTopicsTool : NSObject
+(id)sharedInstance;
/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param params 请求参数
 */
- (NSArray *)topics;

/**
 *  存储微博数据到沙盒中
 *
 *  @param statuses 需要存储的微博数据
 */
- (void)saveStatuses:(NSArray *)statuses;
@end
