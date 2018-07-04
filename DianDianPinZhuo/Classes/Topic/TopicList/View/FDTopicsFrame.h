//
//  FDTopicsFrame.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 昵称字体
#define bottonFont [UIFont systemFontOfSize:14]
// 时间字体
#define user_name_font [UIFont boldSystemFontOfSize:15];
// 来源字体
#define user_detail_font [UIFont systemFontOfSize:14]

#define sex_age_font [UIFont systemFontOfSize:11]

// 正文字体
#define title_font [UIFont systemFontOfSize:16]

// 被转发微博的正文字体
#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell之间的间距
#define HWStatusCellMargin 15

#define FDTopicUsersIconWH 33
// cell的边框宽度
#define HWStatusCellBorderW 10


@class FDTopics;
@interface FDTopicsFrame : NSObject
@property (nonatomic, strong) FDTopics *status;

/** 用户头像 */
@property (nonatomic, assign) CGRect iconF;
/** 内容 */
@property (nonatomic, assign) CGRect content_viewF;
/** 用户名 */
@property (nonatomic, assign) CGRect user_nameF;
/** 用户详情 */
@property (nonatomic, assign) CGRect user_detailF;
/** 免费 */
@property (nonatomic, assign) CGRect freeF;
/** 标题 */
@property (nonatomic, assign) CGRect titleF;
/** 距离 */
@property (nonatomic, assign) CGRect distanceF;
@property (nonatomic, assign) CGRect distance_imageF;

/** 正文 */
@property (nonatomic, assign) CGRect timeF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect imageF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect lineF;
/** 转发配图 */
@property (nonatomic, assign) CGRect yiyouF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect yiyou_peopleF;

/** 来源 */
@property (nonatomic, assign) CGRect people_baomimgF;
/** 正文 */
@property (nonatomic, assign) CGRect remainingF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect remaining_peopleF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect people_kongweiF;
/** 转发配图 */
@property (nonatomic, assign) CGRect chan_shengF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect comment_peopleF;

/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect tiao_pinglunF;
/** 转发配图 */
@property (nonatomic, assign) CGRect follow_sheF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect point1F;
/** 转发配图 */
@property (nonatomic, assign) CGRect point2F;

@property (nonatomic, assign) CGRect line1F;
/** 底部工具条 */
@property (nonatomic, assign) CGRect gap_viewF;
@property (nonatomic, assign) CGRect sex_ageF;
@property (nonatomic, assign) CGRect user_head1F;
@property (nonatomic, assign) CGRect user_head2F;
@property (nonatomic, assign) CGRect user_head3F;
@property (nonatomic, assign) CGRect user_head4F;
@property (nonatomic, assign) CGRect time_imageF;
@property (nonatomic, assign) CGRect end_tipsF;
@property (nonatomic, assign) CGRect left_lineF;
@property (nonatomic, assign) CGRect right_lineF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
