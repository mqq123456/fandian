//
//  FDSection11TableViewCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/26.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDSection11TableViewCell.h"

@implementation FDSection11TableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSection11TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSection11TableViewCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDSection11TableViewCell" owner:nil options:nil]lastObject];
        
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
