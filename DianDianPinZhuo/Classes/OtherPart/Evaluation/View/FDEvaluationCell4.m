//
//  FDEvaluationCell4.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEvaluationCell4.h"

@implementation FDEvaluationCell4
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDEvaluationCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"FDEvaluationCell4"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDEvaluationCell4" owner:nil options:nil]lastObject];
        
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
