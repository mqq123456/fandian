//
//  FDSubjectDetail_DateDetail_cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectDetail_DateDetail_cell.h"

@implementation FDSubjectDetail_DateDetail_cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSubjectDetail_DateDetail_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSubjectDetail_DateDetail_cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDSubjectDetail_DateDetail_cell" owner:nil options:nil]lastObject];
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
