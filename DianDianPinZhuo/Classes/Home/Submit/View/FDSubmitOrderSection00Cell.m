//
//  FDSubmitOrderSection00Cell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDSubmitOrderSection00Cell.h"

@implementation FDSubmitOrderSection00Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    FDSubmitOrderSection00Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"FDSubmitOrderSection00Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDSubmitOrderSection00Cell" owner:self options:nil] lastObject];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
