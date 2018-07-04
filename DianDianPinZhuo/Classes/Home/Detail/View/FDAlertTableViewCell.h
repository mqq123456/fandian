//
//  FDAlertTableViewCell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAlertTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
