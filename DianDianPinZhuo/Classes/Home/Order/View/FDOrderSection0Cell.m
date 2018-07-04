//
//  FDOrderSection0Cell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/25.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDOrderSection0Cell.h"

@implementation FDOrderSection0Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDOrderSection0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDOrderSection0Cell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDOrderSection0Cell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.lineW.constant = 0.5;
    
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
