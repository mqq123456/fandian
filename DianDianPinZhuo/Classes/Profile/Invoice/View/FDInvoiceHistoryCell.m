//
//  FDInvoiceHistoryCell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInvoiceHistoryCell.h"

@implementation FDInvoiceHistoryCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDInvoiceHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDInvoiceHistoryCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDInvoiceHistoryCell" owner:nil options:nil]lastObject];
        
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
