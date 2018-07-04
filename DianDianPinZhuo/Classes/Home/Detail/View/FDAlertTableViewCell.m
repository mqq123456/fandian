//
//  FDAlertTableViewCell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDAlertTableViewCell.h"

@implementation FDAlertTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDAlertTableViewCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDAlertTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
