//
//  FDSubmitOrderSection00Cell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDSubmitOrderSection00Cell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *meiren;

@end
