//
//  FDPerfectInfoView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDPerfectInfoView.h"
#import "UIView+Frame.h"

@implementation FDPerfectInfoView

+(instancetype)selfFDPerfectInfoView{

    return [[NSBundle mainBundle] loadNibNamed:@"FDPerfectInfoView" owner:nil options:nil][0];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.width =[UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;
    self.x= 0;
    self.y = 0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePerfectView)];
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *bgViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewTapremovePerfectView)];
    [self.bgView addGestureRecognizer:bgViewTap];
    [super layoutIfNeeded];
  
}

- (void)bgViewTapremovePerfectView{


}
- (void)removePerfectView{

    [self removeFromSuperview];

}

@end
