
//
//  FDHeadImageCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDHeadImageCell.h"


@implementation FDHeadImageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDHeadImageCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDHeadImageCell" owner:nil options:nil]lastObject];
        
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
