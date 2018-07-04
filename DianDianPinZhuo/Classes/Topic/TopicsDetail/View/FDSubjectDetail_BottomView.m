//
//  FDSubjectDetail_BottomView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectDetail_BottomView.h"
#import "UIView+Frame.h"
#import "HQConst.h"
@implementation FDSubjectDetail_BottomView

+(instancetype)subjectDetail_BottomView{
    
    return [[NSBundle mainBundle]loadNibNamed:@"FDSubjectDetail_BottomView" owner:nil options:nil][0];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.03;//阴影透明度，默认0
    self.layer.shadowRadius = 2;//阴影半径，默认3
    self.x= 0;
    self.y = ScreenH - 60-64;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 60;
    self.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.95];
    [self layoutIfNeeded];
}
@end
