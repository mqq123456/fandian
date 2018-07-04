//
//  FDConfigFooterView.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/6.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDConfigFooterView.h"
#import "FDUtils.h"
#import "HQConst.h"
@implementation FDConfigFooterView
- (void)layoutSubviews{
    [super layoutSubviews];

    if (IPHONE4) {
        self.quitBtnTop.constant = 20;
    }
    if (IPHONE5) {
         self.quitBtnTop.constant = 40;
    }
    [self layoutIfNeeded];
}
@end
