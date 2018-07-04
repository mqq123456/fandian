//
//  FDAdView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/4.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDAdView.h"
#import "HQConst.h"
@implementation FDAdView
+(instancetype)selfAdImageView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDAdView" owner:nil options:nil][0];
}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    if (IPhone6Plus) {
        
    }else{
        self.left.constant = 30;
        self.right.constant = 30;
    }
    [self layoutIfNeeded];
}
@end
