//
//  FDUserDetailHeaderView.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/31.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDUserDetailHeaderView.h"
#import "HQConst.h"
#import "UIView+Frame.h"

@implementation FDUserDetailHeaderView

+(instancetype)editInfoHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:@"FDUserDetailHeaderView" owner:self options:nil][0];
    

}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.height = ScreenW;
    self.xingzuoX.constant = -[UIScreen mainScreen].bounds.size.width*.33;
    self.xingzuoBottom.constant = [UIScreen mainScreen].bounds.size.width*.71;
    self.ageX.constant = -[UIScreen mainScreen].bounds.size.width*.242;
    if (IPHONE4||IPHONE5) {
        self.head_with.constant = 100;
        self.rotatingView.layer.cornerRadius = 46;
        self.circleView.layer.cornerRadius = 50;
        self.self_descT.constant = 10;
        
    }
//    if (IPHONE4||IPHONE5) {
//        
//        self.self_desc.numberOfLines = 2;
//    }
    if (IPhone6) {
        self.head_with.constant = 120;
        self.rotatingView.layer.cornerRadius = 56;
        self.circleView.layer.cornerRadius = 60;
        
    }
//    self.rotatingViewW.constant = [UIScreen mainScreen].bounds.size.width*0.3;
//    self.provinceX.constant = [UIScreen mainScreen].bounds.size.width*.24;
//
//    self.provinceY.constant = [UIScreen mainScreen].bounds.size.width*.24;
//
    [self layoutIfNeeded];
//
    
}
@end
