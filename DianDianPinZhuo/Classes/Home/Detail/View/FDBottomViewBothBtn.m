//
//  FDBottomViewBothBtn.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDBottomViewBothBtn.h"
#import "HQConst.h"
#import "UIView+Frame.h"
@implementation FDBottomViewBothBtn

+(instancetype)bottomViewBothBtnView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FDBottomViewBothBtn" owner:nil options:nil]lastObject];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.x= 0;
    self.y = ScreenH-60-64;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 60;

    [super layoutIfNeeded];
}

@end
