//
//  FDFoodCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/30.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDFoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *food_name;
@property (weak, nonatomic) IBOutlet UILabel *food_count;
@property (weak, nonatomic) IBOutlet UILabel *food_price;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
