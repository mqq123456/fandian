//
//  FDTicketPromptCell.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/4.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTicketPromptCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
