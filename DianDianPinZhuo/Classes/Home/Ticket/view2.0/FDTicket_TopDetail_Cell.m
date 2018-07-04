//
//  FDTicket_TopDetail_Cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicket_TopDetail_Cell.h"

@implementation FDTicket_TopDetail_Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDTicket_TopDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDTicket_TopDetail_Cell"];
    
    if (cell == nil) {
        
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDTicket_TopDetail_Cell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
//    self.topLineView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.topLineView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.topLineView.layer.shadowOpacity = 0.06;//阴影透明度，默认0
//    self.topLineView.layer.shadowRadius = 2;//阴影半径，默认3
//    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
