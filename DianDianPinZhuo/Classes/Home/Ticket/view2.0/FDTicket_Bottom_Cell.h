//
//  FDTicket_Bottom_Cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTicket_Bottom_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *peoples;
@property (weak, nonatomic) IBOutlet UIButton *gotoGroupBtn;
@property (weak, nonatomic) IBOutlet UILabel *haiyou;
@property (weak, nonatomic) IBOutlet UILabel *lurenjia;
@property (weak, nonatomic) IBOutlet UIView *bgView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
