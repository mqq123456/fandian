//
//  FDEvaluationCell1.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEvaluationCell1.h"

@implementation FDEvaluationCell1
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDEvaluationCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"FDEvaluationCell1"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDEvaluationCell1" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
