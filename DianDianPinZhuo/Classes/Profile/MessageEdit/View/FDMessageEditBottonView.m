//
//  FDMessageEditBottonView.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMessageEditBottonView.h"
#import "UIView+Extension.h"
@implementation FDMessageEditBottonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.x = 0;
    self.y = [UIScreen mainScreen].bounds.size.height-64-50;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 50;

    [self layoutIfNeeded];
}

@end
