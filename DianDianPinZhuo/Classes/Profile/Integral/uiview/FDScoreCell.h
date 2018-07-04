//
//  FDScoreCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/6.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *merchant_detail;
@property (weak, nonatomic) IBOutlet UILabel *eat_time;
@property (weak, nonatomic) IBOutlet UILabel *score_detail;
@property (weak, nonatomic) IBOutlet UILabel *score_point;
@property (weak, nonatomic) IBOutlet UILabel *score_left;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
