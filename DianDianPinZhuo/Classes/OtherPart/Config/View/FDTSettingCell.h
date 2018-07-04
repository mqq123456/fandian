//
//  FDTSettingCell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *left_label;
@property (weak, nonatomic) IBOutlet UILabel *right_label;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
