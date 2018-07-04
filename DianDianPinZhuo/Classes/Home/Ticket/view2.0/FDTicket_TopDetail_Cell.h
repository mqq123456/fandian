//
//  FDTicket_TopDetail_Cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXScore.h"

@interface FDTicket_TopDetail_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *merchant_name;
@property (weak, nonatomic) IBOutlet UILabel *merchant_phone;
@property (weak, nonatomic) IBOutlet UIButton *merchant_phoneBtn;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
