//
//  FDScoreCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/6.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDScoreCell.h"

@implementation FDScoreCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDScoreCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDScoreCell" owner:nil options:nil]lastObject];
        
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
