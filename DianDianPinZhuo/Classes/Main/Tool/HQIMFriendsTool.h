//
//  HQIMFriendsTool.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsersModel.h"
@interface HQIMFriendsTool : NSObject
//获取单例对象
+(id)sharedInstance;
//添加一条记录
-(void)addFriendsName:(UsersModel *)user idString:(NSString *)kid;

///获取某一条好友信息
- (NSDictionary *)recordFriendDetail:(NSString *)kid;

//获取记录列表
-(NSArray *)recordList;

//检查是否被记录
-(BOOL)isExistRecordWithKid:(NSString *)kid;
//删除某一条记录
-(BOOL)removeSelectedHistoryWithKid:(NSString *)kid;

@end
