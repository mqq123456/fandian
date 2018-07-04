//
//  CALayer+Extension.m
//  normandyHD
//
//  Created by user on 15/7/7.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)
-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}
-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
