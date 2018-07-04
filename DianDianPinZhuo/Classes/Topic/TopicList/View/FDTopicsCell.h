//
//  FDTopicsCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDTopicsFrame;

@interface FDTopicsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDTopicsFrame *statusFrame;
/** 图  */
@property (nonatomic, weak) UIImageView *image;

@property (nonatomic ,strong) UINavigationController *nav;
@end
