//
//  FDPerfectSexCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/31.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectSexCell.h"
#import "HQDefaultTool.h"
@implementation FDPerfectSexCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    FDPerfectSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDPerfectSexCell"];
    
    if (cell == nil) {
        
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FDPerfectSexCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    
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

- (IBAction)nanClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAndReloadTableViewWithSex:)]) {
        [self.delegate selectedAndReloadTableViewWithSex:@"男"];
    }
}

- (IBAction)nvClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAndReloadTableViewWithSex:)]) {
        [self.delegate selectedAndReloadTableViewWithSex:@"女"];
    }
}
@end
