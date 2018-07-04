//
//  FDInfoCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInfoCell.h"

@implementation FDInfoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDInfoCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDInfoCell" owner:nil options:nil]lastObject];
        
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
