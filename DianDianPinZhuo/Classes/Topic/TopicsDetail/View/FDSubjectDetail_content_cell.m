//
//  FDSubjectDetail_content_cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectDetail_content_cell.h"

@implementation FDSubjectDetail_content_cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSubjectDetail_content_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSubjectDetail_content_cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDSubjectDetail_content_cell" owner:nil options:nil]lastObject];
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
