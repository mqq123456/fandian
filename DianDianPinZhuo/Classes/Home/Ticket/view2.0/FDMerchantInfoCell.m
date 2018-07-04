//
//  FDMerchantInfoCell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantInfoCell.h"

@implementation FDMerchantInfoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDMerchantInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDMerchantInfoCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantInfoCell" owner:nil options:nil]lastObject];
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
