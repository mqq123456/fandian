//
//  FDTopicDetailFreeCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/2/1.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXScore.h"
@interface FDTopicDetailFreeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet LDXScore *star;
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *only_people;



@end
