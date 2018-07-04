//
//  FDEvaluationCell3.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDEvaluationCell3.h"
#import "HQConst.h"
@implementation FDEvaluationCell3
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDEvaluationCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"FDEvaluationCell3"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDEvaluationCell3" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.environmentBtn.layer.borderWidth = .5;
    cell.environmentBtn.layer.borderColor = Background_Color.CGColor;
    cell.diffentBtn.layer.borderWidth = .5;
    cell.diffentBtn.layer.borderColor = Background_Color.CGColor;
    
    cell.speetBtn.layer.borderWidth = .5;
    cell.speetBtn.layer.borderColor = Background_Color.CGColor;
    
    cell.healthBtn.layer.borderWidth = .5;
    cell.healthBtn.layer.borderColor = Background_Color.CGColor;
    
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
