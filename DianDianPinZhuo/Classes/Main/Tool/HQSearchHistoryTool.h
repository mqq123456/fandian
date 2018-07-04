//
//  HQSearchHistoryTool.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/29.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface HQSearchHistoryTool : NSObject
//获取单例对象
+(id)sharedInstance;
//添加一条记录
-(void)addSearchName:(AMapPOI *)poi idString:(NSString *)idString;

//获取记录列表
-(NSArray *)recordList;

//检查是否被记录
-(BOOL)isExistRecordWithSearchName:(NSString *)name;
//删除所有数据
-(BOOL)removeSelectedHistoryWithName:(NSString *)name;

@end
