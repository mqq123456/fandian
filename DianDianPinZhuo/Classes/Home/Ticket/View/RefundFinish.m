//
//  RefundFinish.m
//  DianDianPinZhuo
//
//  Created by user on 15/9/9.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RefundFinish.h"

@implementation RefundFinish

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    // Initialization code
    [self.doneBtn addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)touchAction:(id)sender{
    self.doneBtnClick();
}
@end
