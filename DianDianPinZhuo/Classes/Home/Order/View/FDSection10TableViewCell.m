//
//  FDSection10TableViewCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDSection10TableViewCell.h"

@implementation FDSection10TableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSection10TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSection10TableViewCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDSection10TableViewCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
