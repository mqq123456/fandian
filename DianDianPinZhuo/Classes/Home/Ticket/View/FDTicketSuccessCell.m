//
//  FDTicketSuccessCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/5.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicketSuccessCell.h"
#import "HQConst.h"
@implementation FDTicketSuccessCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTicketSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTicketSuccessCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDTicketSuccessCell" owner:nil options:nil]lastObject];
        
    }
    if (IPHONE4||IPHONE5) {
        cell.detail.font = [UIFont systemFontOfSize:13];
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
