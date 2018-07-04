//
//  FDUserDetailTableViewCell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDUserDetailTableViewCell.h"
#import "UIView+Frame.h"

@implementation FDUserDetailTableViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(20, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    
    self.detailTextLabel.x = self.detailTextLabel.frame.origin.x-5;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
