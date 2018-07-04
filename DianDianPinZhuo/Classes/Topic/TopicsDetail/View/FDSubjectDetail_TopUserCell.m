//
//  FDSubjectDetail_TopUserCell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectDetail_TopUserCell.h"

@implementation FDSubjectDetail_TopUserCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSubjectDetail_TopUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSubjectDetail_TopUserCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDSubjectDetail_TopUserCell" owner:nil options:nil]lastObject];
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
