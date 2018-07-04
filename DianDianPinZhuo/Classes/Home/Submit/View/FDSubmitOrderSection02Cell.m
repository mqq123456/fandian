//
//  FDSubmitOrderSection01Cell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDSubmitOrderSection02Cell.h"

@implementation FDSubmitOrderSection02Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    FDSubmitOrderSection02Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"FDSubmitOrderSection02Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDSubmitOrderSection02Cell" owner:self options:nil] lastObject];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
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
