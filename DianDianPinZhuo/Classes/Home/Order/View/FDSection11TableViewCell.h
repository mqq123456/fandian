//
//  FDSection11TableViewCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDSection11TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payView;
@property (weak, nonatomic) IBOutlet UILabel *pay_name;
//@property (weak, nonatomic) IBOutlet UILabel *pay_description;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIButton *pay_Select;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
