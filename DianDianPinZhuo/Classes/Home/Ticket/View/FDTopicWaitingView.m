//
//  FDTopicWaitingView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicWaitingView.h"
#import "FDUtils.h"
@implementation FDTopicWaitingView


+(instancetype)selfWaitingView{
    
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDTopicWaitingView" owner:nil options:nil][0];

}
- (void)layoutSubviews{
    [super layoutSubviews];

    self.bgView.layer.shadowColor = [FDUtils colorWithHexString:@"#ef2840"].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.4;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 2;//阴影半径，默认3

}
@end
