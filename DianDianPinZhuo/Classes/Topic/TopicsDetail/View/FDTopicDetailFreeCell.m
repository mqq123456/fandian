//
//  FDTopicDetailFreeCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/2/1.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicDetailFreeCell.h"

@implementation FDTopicDetailFreeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTopicDetailFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTopicDetailFreeCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDTopicDetailFreeCell" owner:nil options:nil]lastObject];
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
