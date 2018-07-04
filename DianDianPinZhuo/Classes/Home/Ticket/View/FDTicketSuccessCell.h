//
//  FDTicketSuccessCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/5.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTicketSuccessCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewColorLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLeft;

@end
