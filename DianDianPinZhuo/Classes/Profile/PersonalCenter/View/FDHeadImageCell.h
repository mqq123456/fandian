//
//  FDHeadImageCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDHeadImageCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end
