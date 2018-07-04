//
//  FDSubjectDetail_DateDetail_cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXScore.h"

@interface FDSubjectDetail_DateDetail_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dateDetail_merchantIcon;
@property (weak, nonatomic) IBOutlet UILabel *dateDetail_merchantName;
@property (weak, nonatomic) IBOutlet LDXScore *dateDetail_star;
@property (weak, nonatomic) IBOutlet UIView *dateDetail_time;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *kdate_desc;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
