//
//  FDSection10TableViewCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDSection10TableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *otherPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end
