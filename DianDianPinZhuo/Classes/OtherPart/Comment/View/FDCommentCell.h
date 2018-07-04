//
//  FDCommentCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@class FDCommentFrame;
@interface FDCommentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDCommentFrame *statusFrame;
/** 头像 */
@property (nonatomic, weak) FDHeadImageView *icon;
@end
