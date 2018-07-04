//
//  FDTopicCommentFrame.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define nick_nameFont  [UIFont systemFontOfSize:14]
#define content_Font [UIFont systemFontOfSize:15]
#define time_font [UIFont systemFontOfSize:13]



@class TopicCommentModel;
@interface FDTopicCommentFrame : NSObject
@property (nonatomic, strong) TopicCommentModel *status;

/** 图片 */
@property (nonatomic, assign) CGRect gap_viewF;

@property (nonatomic, assign) CGRect iconF;
/** 描述，半透明 */
@property (nonatomic, assign) CGRect nick_nameF;

@property (nonatomic, assign) CGRect jiantouF;
/** 几人桌 */
@property (nonatomic, assign) CGRect contentF;
/** logo图 */
@property (nonatomic, assign) CGRect content_viewF;
/** 餐厅名称 */
@property (nonatomic, assign) CGRect timeF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
