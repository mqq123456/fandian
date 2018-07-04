//
//  FDTSettingCell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTSettingCell.h"

@implementation FDTSettingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTSettingCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDTSettingCell" owner:nil options:nil]lastObject];
        
    }
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineH.constant = 0.5;
    
    [cell layoutIfNeeded];
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
