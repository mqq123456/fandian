//
//  FDEvaluationCell1.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDEvaluationCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *merchant_Icon;
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;

@property (weak, nonatomic) IBOutlet UILabel *creat_time;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
