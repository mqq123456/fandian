//
//  FDInvocieCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInvocieCell.h"

@implementation FDInvocieCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDInvocieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDInvocieCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDInvocieCell" owner:nil options:nil]lastObject];
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.inputTextfiled.adjustsFontSizeToFitWidth = YES;
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
