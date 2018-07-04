//
//  FDMerchantDetailBottomView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/2/23.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantDetailBottomView.h"
#import "HQConst.h"
#import "UIView+Frame.h"
@implementation FDMerchantDetailBottomView


+(instancetype)detailBottomView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantDetailBottomView" owner:nil options:nil]lastObject];

}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.x= 0;
    self.y = ScreenH-62-64;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 62;
    self.bgView.backgroundColor = FDColor(251, 251, 251, 1);
    
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.05;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 2;//阴影半径，默认3

    [super layoutIfNeeded];
}
@end
