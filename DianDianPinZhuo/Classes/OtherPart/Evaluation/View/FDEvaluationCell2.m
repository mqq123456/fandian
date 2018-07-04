//
//  FDEvaluationCell2.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEvaluationCell2.h"

@implementation FDEvaluationCell2
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDEvaluationCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"FDEvaluationCell2"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDEvaluationCell2" owner:nil options:nil]lastObject];
        
    }
    cell.star.show_star= 5;
    cell.star.userInteractionEnabled = YES;
    cell.star.space = 10;
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
