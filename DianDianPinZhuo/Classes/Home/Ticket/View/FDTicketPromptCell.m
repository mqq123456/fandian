//
//  FDTicketPromptCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/4.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicketPromptCell.h"

@implementation FDTicketPromptCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTicketPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTicketPromptCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDTicketPromptCell" owner:nil options:nil]lastObject];
        
    }
    cell.userInteractionEnabled = NO;

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
