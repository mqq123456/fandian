//
//  FDEvaluationSuccessView.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDEvaluationSuccessView.h"
#import "FDUtils.h"
@implementation FDEvaluationSuccessView
+(instancetype)selfEvaluationSuccessView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDEvaluationSuccessView" owner:nil options:nil][0];
    
}

- (void)layoutSubviews{
    
    self.bonus_NO.layer.borderColor=[UIColor colorWithRed:255.0/255.0 green:208.0/255.0 blue:83.0/255.0 alpha:1].CGColor;
    
    self.bonus_NO.layer.borderWidth =1;
    
    self.bonus_NO.layer.borderWidth = 0.5;
    self.bonus_NO.layer.borderColor = [FDUtils colorWithHexString:@"#dedede"].CGColor;
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}

@end
