//
//  FDTicketHeadView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicketHeadView.h"
#import "FDUtils.h"
@implementation FDTicketHeadView

+(instancetype)selfTicketHeadView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDTicketHeadView" owner:nil options:nil][0];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}
@end
