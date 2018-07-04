//
//  FDGroupDetailTool.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/19.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDGroupDetailTool : NSObject

///获取单例对象
+(id)sharedInstance;
///添加一条记录
-(void)addgroupDetail:(NSDictionary *)group group_idString:(NSString *)idString;

///检查是否被记录
-(BOOL)isExistRecordWithGroupDetail:(NSString *)group_id;
///删除所有数据
-(BOOL)removeSelectedHistoryGroupDetail:(NSString *)group_id;
///获取某一条群组信息
- (NSDictionary *)recordGroupDetail:(NSString *)group_id;


//检查某是否被记录
-(BOOL)isExistRecordWithGroupJoined:(NSString *)group_id;

-(void)addGroupJoined:(NSDictionary *)group group_idString:(NSString *)idString;
//退出之后
-(void)removeFromGroup:(NSString *)idString;
@end
