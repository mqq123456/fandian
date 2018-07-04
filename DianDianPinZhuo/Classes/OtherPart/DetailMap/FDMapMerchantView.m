//
//  FDMapMerchantView.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/19.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMapMerchantView.h"

@implementation FDMapMerchantView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(7, [UIScreen mainScreen].bounds.size.height-185, [UIScreen mainScreen].bounds.size.width-14, 100);
    [self layoutIfNeeded];
    
}

@end
