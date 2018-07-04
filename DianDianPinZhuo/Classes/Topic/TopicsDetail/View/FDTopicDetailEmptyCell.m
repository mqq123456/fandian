//
//  FDTopicDetailEmptyCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/28.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicDetailEmptyCell.h"

@implementation FDTopicDetailEmptyCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTopicDetailEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTopicDetailEmptyCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDTopicDetailEmptyCell" owner:nil options:nil]lastObject];
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
