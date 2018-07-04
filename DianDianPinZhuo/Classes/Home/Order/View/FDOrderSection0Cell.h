//
//  FDOrderSection0Cell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDOrderSection0Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;
@property (weak, nonatomic) IBOutlet UIImageView *merchant_icon;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UILabel *hourTime;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
