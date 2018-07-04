//
//  FDGuideView.m
//  DianDianPinZhuo
//
//  Created by user on 16/2/24.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDGuideView.h"
#import "HQConst.h"

@implementation FDGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    if (IPhone6||IPHONE5||IPHONE4) {
        self.iconW.constant = 46;
        self.iconH.constant = 46;
        self.iconLeft.constant = -2;
        self.iconTop.constant = -1.5;
        self.people_icon.layer.cornerRadius = 23;
        self.backH.constant = 83.5;
        self.backLeft.constant = 12;
        
        
    }
    [self layoutIfNeeded];
}

- (IBAction)disBtnClick:(id)sender {
    [self removeFromSuperview];
}
@end
