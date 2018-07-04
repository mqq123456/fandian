//
//  FDSubmitOrderSection02Cell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FDSubmitOrderSection02Cell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *accView;
@property (weak, nonatomic) IBOutlet UILabel *yy;

@property (weak, nonatomic) IBOutlet UILabel *price;
@end
