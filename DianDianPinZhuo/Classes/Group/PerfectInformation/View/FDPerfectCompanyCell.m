//
//  FDPerfectCompanyCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectCompanyCell.h"

@implementation FDPerfectCompanyCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDPerfectCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDPerfectCompanyCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDPerfectCompanyCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
