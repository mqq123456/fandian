//
//  FDLoginWeiXinView.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDLoginWeiXinView.h"

@implementation FDLoginWeiXinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-152-64, [UIScreen mainScreen].bounds.size.width, 152);
    [self layoutIfNeeded];
}
@end
