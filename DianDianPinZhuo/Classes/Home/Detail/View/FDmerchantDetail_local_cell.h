//
//  FDmerchantDetail_local_cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXScore.h"

@interface FDmerchantDetail_local_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *local_comment;
@property (weak, nonatomic) IBOutlet UILabel *local_name;
@property (weak, nonatomic) IBOutlet LDXScore *local_star;
@property (weak, nonatomic) IBOutlet UILabel *local_address;
@property (weak, nonatomic) IBOutlet UIView *merchant_BgView;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *merchant_Bg_W;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line1H;

@end
