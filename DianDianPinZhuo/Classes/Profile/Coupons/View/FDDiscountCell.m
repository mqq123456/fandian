//
//  FDDiscountCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDDiscountCell.h"

@implementation FDDiscountCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDDiscountCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FDDiscountCell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDDiscountCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bgView.layer.cornerRadius = 5;
    
    cell.layer.masksToBounds = YES;

    return cell;
}
- (void)awakeFromNib {

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
