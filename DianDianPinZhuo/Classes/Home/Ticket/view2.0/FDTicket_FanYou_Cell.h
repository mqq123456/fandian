//
//  FDTicket_FanYou_Cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDHeadImageView.h"
@interface FDTicket_FanYou_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet FDHeadImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *desc_label;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UIButton *sexAndAge;
@property (weak, nonatomic) IBOutlet UILabel *occupation_industry;
@property (weak, nonatomic) IBOutlet UIButton *age_sex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *occupation_industryWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *age_sexWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *age_sexLeft;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
