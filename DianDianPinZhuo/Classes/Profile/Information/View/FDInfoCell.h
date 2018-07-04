//
//  FDInfoCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDInfoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UIImageView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@end
