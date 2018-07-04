//
//  FDSubjectDetail_TopUserCell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@interface FDSubjectDetail_TopUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet FDHeadImageView *subject_icon;
@property (weak, nonatomic) IBOutlet UILabel *subject_name;
@property (weak, nonatomic) IBOutlet UILabel *subject_occpution;
@property (weak, nonatomic) IBOutlet UIImageView *subject_free;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
