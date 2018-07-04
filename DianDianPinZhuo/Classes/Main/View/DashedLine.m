//
//  DashedLine.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/21.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "DashedLine.h"
#import "UIView+Extension.h"
@implementation DashedLine

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.width > self.height) {
        //横线
        UIGraphicsBeginImageContext(self.frame.size);   //开始画线
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {1,3};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0.0, self.frame.size.height);    //开始画线
        CGContextAddLineToPoint(line, self.frame.size.width, self.frame.size.height);
        CGContextStrokePath(line);
        
        self.image = UIGraphicsGetImageFromCurrentImageContext();
    }else{
        UIGraphicsBeginImageContext(self.frame.size);   //开始画线
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {4,2};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line,[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        
        CGContextMoveToPoint(line,0,0.0);    //开始画线
        CGContextAddLineToPoint(line, 0 , self.frame.size.height);
        
        CGContextStrokePath(line);
        
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    
    
}

@end
