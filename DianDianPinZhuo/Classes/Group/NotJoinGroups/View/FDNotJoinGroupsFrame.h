//
//  FDNotJoinGroupsFrame.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 时间字体
#define name_font [UIFont boldSystemFontOfSize:16]
// 来源字体
#define user_detail_font [UIFont systemFontOfSize:14]

// 正文字体
#define titlefont [UIFont systemFontOfSize:14]

#define active_font [UIFont boldSystemFontOfSize:14]

// cell之间的间距
#define HWStatusCellMargin 15

#define TopicUsersIconWH 32
// cell的边框宽度
#define HWStatusCellBorderW 10


@class NotJoinGroupModel;
@interface FDNotJoinGroupsFrame : NSObject
@property (nonatomic, strong) NotJoinGroupModel *status;

/** 用户头像 */
@property (nonatomic, assign) CGRect iconF;
/** 内容 */
@property (nonatomic, assign) CGRect content_viewF;
/** 用户名 */
@property (nonatomic, assign) CGRect user_nameF;
/** 用户详情 */
@property (nonatomic, assign) CGRect user_detailF;
/** 标题 */
@property (nonatomic, assign) CGRect titleF;

/** 转发配图 */
@property (nonatomic, assign) CGRect follow_sheF;

@property (nonatomic, assign) CGRect line1F;
/** 底部工具条 */
@property (nonatomic, assign) CGRect gap_viewF;
@property (nonatomic, assign) CGRect user_head1F;
@property (nonatomic, assign) CGRect user_head2F;
@property (nonatomic, assign) CGRect user_head3F;
@property (nonatomic, assign) CGRect user_head4F;
@property (nonatomic, assign) CGRect activeF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
