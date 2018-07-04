//
//  FDSponsorTopicContentCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSponsorTopicContentCell.h"

@implementation FDSponsorTopicContentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDSponsorTopicContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSponsorTopicContentCell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDSponsorTopicContentCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.contentLabel.placeholder = @"就想好好吃饭（待定）";
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
