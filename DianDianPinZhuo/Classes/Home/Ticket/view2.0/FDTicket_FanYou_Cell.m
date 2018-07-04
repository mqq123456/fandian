//
//  FDTicket_FanYou_Cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicket_FanYou_Cell.h"

@implementation FDTicket_FanYou_Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTicket_FanYou_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTicket_FanYou_Cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDTicket_FanYou_Cell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineH.constant = 0.5;
    }

    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
