//
//  FDSponsorTopicHeaderCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSponsorTopicHeaderCell.h"

@implementation FDSponsorTopicHeaderCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSponsorTopicHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSponsorTopicHeaderCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDSponsorTopicHeaderCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
