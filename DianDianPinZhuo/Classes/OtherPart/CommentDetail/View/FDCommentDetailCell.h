//
//  FDCommentDetailCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/2.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"

@class FDCommentDetailFrame;
@interface FDCommentDetailCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) FDCommentDetailFrame *statusFrame;
/** 头像 */
@property (nonatomic, weak) FDHeadImageView *icon;
@end
