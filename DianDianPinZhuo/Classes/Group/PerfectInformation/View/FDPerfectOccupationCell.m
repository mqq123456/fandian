//
//  FDPerfectOccupationCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectOccupationCell.h"

@implementation FDPerfectOccupationCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDPerfectOccupationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDPerfectOccupationCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDPerfectOccupationCell" owner:nil options:nil]lastObject];
        
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
