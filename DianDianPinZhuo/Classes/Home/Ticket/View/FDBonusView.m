//
//  FDBonusView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDBonusView.h"
#import "FDUtils.h"
#import "HQConst.h"
#define IPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736 ? YES : NO)


@implementation FDBonusView

+(instancetype)selfBounsView{

    return [[NSBundle mainBundle] loadNibNamed:@"FDBonusView" owner:nil options:nil][0];
    
}

- (void)layoutSubviews{

    self.bonus_NO.layer.borderColor=[UIColor colorWithRed:255.0/255.0 green:208.0/255.0 blue:83.0/255.0 alpha:1].CGColor;
    
    self.bonus_NO.layer.borderWidth =1;
    if (IPhone6Plus) {
        self.GongxiTop.constant =  210;
    }else{
        self.GongxiTop.constant =  180;
    
    }
    if (IPHONE4||IPHONE5) {
        self.label1.font = [UIFont systemFontOfSize:13];
        self.label2.font = [UIFont systemFontOfSize:13];
    }

    self.bonus_NO.layer.borderWidth = 0.5;
    self.bonus_NO.layer.borderColor = [FDUtils colorWithHexString:@"#dedede"].CGColor;
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}
@end
