//
//  FDGrowingCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGrowingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *merchant;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *growingNum;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
