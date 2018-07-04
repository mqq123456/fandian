//
//  FDGroupMembersFrame.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// 时间字体
#define user_name_font [UIFont fontWithName:@"STHeitiSC" size:18]
// 来源字体
#define user_detail_font [UIFont systemFontOfSize:14]

#define sex_age_font [UIFont systemFontOfSize:11]

#define address_font [UIFont systemFontOfSize:13]

#define FDTopicUsersIconWH 76


@class GroupMembersModel;
@interface FDGroupMembersFrame : NSObject
@property (nonatomic, strong) GroupMembersModel *status;

/** 用户头像 */
@property (nonatomic, assign) CGRect iconF;
/** 内容 */
@property (nonatomic, assign) CGRect content_viewF;
/** 用户名 */
@property (nonatomic, assign) CGRect user_nameF;
/** 用户详情 */
@property (nonatomic, assign) CGRect user_detailF;
/** 免费 */
@property (nonatomic, assign) CGRect sex_ageF;
/** 距离 */
@property (nonatomic, assign) CGRect addressF;
@property (nonatomic, assign) CGRect address_imageF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
