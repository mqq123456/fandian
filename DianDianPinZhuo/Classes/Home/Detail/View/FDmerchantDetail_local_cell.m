//
//  FDmerchantDetail_local_cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDmerchantDetail_local_cell.h"

@implementation FDmerchantDetail_local_cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDmerchantDetail_local_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDmerchantDetail_local_cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDmerchantDetail_local_cell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
   
}
-  (void)layoutSubviews{

    [super layoutSubviews];
    self.line1H.constant = 0.5;
    self.line2H.constant = 0.5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
