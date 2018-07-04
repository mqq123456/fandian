//
//  FDMerchantDetail_comment_cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantDetail_comment_cell.h"

@implementation FDMerchantDetail_comment_cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDMerchantDetail_comment_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDMerchantDetail_comment_cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantDetail_comment_cell" owner:nil options:nil]lastObject];
        
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
