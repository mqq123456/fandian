//
//  NotJoinGroupModel.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotJoinGroupModel : NSObject
/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *group_id;

/**	人物的头像 */
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
/**	人物的昵称 */
@property (nonatomic, copy) NSString *group_desc;


/**	对人物昵称的描述（和昵称拼接） */
@property (nonatomic, copy) NSString *notice;

/** 一个话题的跟随关键词（跟随他） */
@property (nonatomic, strong) NSString *group_keyword;
@property (nonatomic, strong)NSMutableArray *active_users;

/**	群组人数 */
@property (nonatomic, copy) NSString *members_count;
@property (nonatomic, assign) BOOL gap_hiden;

@end
