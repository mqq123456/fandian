//
//  FDTicketFooterView.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTicketFooterView.h"

@implementation FDTicketFooterView


+(instancetype)selfFooterView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"FDTicketFooterView" owner:nil options:nil][0];
}

@end
