//
//  FDInfoSecontion1Cell.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDInfoSecontion1Cell.h"

@implementation FDInfoSecontion1Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDInfoSecontion1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDInfoSecontion1Cell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDInfoSecontion1Cell" owner:nil options:nil]lastObject];
        
    }

    return cell;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.rightText setValue:[UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:186.0/255.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.rightText setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
