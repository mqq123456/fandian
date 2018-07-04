//
//  FDCommentFrame.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define nick_nameFont  [UIFont systemFontOfSize:14]
#define content_Font [UIFont systemFontOfSize:15]
#define time_font [UIFont systemFontOfSize:12]



@class CommentModel;
@interface FDCommentFrame : NSObject
@property (nonatomic, strong) CommentModel *status;

/** 图片 */
@property (nonatomic, assign) CGRect gap_viewF;

@property (nonatomic, assign) CGRect iconF;
/** 描述，半透明 */
@property (nonatomic, assign) CGRect nick_nameF;
/** 描述文字 */
@property (nonatomic, assign) CGRect starF;
@property (nonatomic, assign) CGRect jiantouF;
/** 几人桌 */
@property (nonatomic, assign) CGRect contentF;
/** logo图 */
@property (nonatomic, assign) CGRect content_viewF;
/** 餐厅名称 */
@property (nonatomic, assign) CGRect timeF;
@property (nonatomic, assign) CGRect replyF;

@property (nonatomic, assign) CGRect imageF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
