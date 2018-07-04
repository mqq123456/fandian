//
//  FDGrowingCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDGrowingCell.h"

@implementation FDGrowingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDGrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDGrowingCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDGrowingCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
