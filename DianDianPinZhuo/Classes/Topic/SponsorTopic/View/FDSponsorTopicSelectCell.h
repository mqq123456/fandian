//
//  FDSponsorTopicSelectCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDSponsorTopicSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *left_icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *desc;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
