//
//  FDMerchantDetail_comment_cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXScore.h"

@interface FDMerchantDetail_comment_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *comment_icon;
@property (weak, nonatomic) IBOutlet UILabel *comment_name;
@property (weak, nonatomic) IBOutlet UILabel *comment_occupation;
@property (weak, nonatomic) IBOutlet LDXScore *comment_star;
@property (weak, nonatomic) IBOutlet UIView *comment_bgView;
@property (weak, nonatomic) IBOutlet UILabel *comment_coment;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
