//
//  FDTopicCommentCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@class FDTopicCommentFrame;

@interface FDTopicCommentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDTopicCommentFrame *statusFrame;
@property (nonatomic, weak) UIView *content_view;
/** 头像 */
@property (nonatomic, weak) FDHeadImageView *icon;
@end
