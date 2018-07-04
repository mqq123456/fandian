//
//  FDTimeLabel.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTimeLabel.h"

@implementation FDTimeLabel

@synthesize insets=_insets;
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
