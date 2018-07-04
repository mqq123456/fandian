//
//  FDGroupMembersCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDGroupMembersFrame;
@interface FDGroupMembersCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDGroupMembersFrame *statusFrame;
/** 图  */
@property (nonatomic, weak) UIImageView *image;

@property (nonatomic ,strong) UINavigationController *nav;
@end
