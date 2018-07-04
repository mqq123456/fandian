//
//  FDFoodCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/30.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDFoodCell.h"

@implementation FDFoodCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDFoodCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDFoodCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
