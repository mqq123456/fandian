//
//  XBNullView.m
//  XBNullView
//
//  Created by Scarecrow on 15/10/25.
//  Copyright (c) 2015年 XB. All rights reserved.
//

#import "XBNullView.h"
#import "HQConst.h"
@interface XBNullView()



@end
@implementation XBNullView


- (instancetype)initNullViewWithFrame:(CGRect)frame andImage:(NSString *)image andDescription:(NSString *)description
{
    if (self = [super initWithFrame:frame]) {
        self.nullImgView = [[UIImageView alloc]init];

        self.desLabel = [[UILabel alloc]init];
        self.desLabel.textAlignment = NSTextAlignmentCenter;
        self.desLabel.font = [UIFont boldSystemFontOfSize:15];
        self.desLabel.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
        self.desLabel.numberOfLines = 0;
        self.desToImgGap = 20.f;
        [self addSubview:self.nullImgView];
        [self addSubview:self.desLabel];


    }
    return self;
}

- (void)setDesTextFont:(UIFont *)desTextFont
{
    self.desLabel.font = desTextFont;
}

- (void)setDesTextColor:(UIColor *)desTextColor
{
    self.desLabel.textColor = desTextColor;
}
-(void)setImgCenterYGap:(CGFloat)imgCenterYGap{
    _imgCenterYGap = imgCenterYGap;
    CGFloat imgCenterX = self.center.x;
    CGFloat imgCenterY = self.center.y + self.imgCenterYGap;
    CGFloat imgH = 95;
    CGFloat imgW = 113;
    self.nullImgView.frame = CGRectMake(0, 0, imgW, imgH);
    self.nullImgView.center = CGPointMake(imgCenterX, imgCenterY);
    self.desLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.desLabel.font.lineHeight);
    self.desLabel.center = CGPointMake(self.center.x, imgCenterY + imgH * 0.5 + self.desToImgGap);

    
}
- (void)layoutSubviews
{
    self.userInteractionEnabled = NO;
    self.nullImgView.userInteractionEnabled = NO;
    
    CGFloat imgCenterX = self.center.x;
    CGFloat imgCenterY = self.center.y + self.imgCenterYGap;
    CGFloat imgH = 95;
    CGFloat imgW = 113;
    self.nullImgView.frame = CGRectMake(0, 0, imgW, imgH);
    self.nullImgView.center = CGPointMake(imgCenterX, imgCenterY);
    self.desLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.desLabel.font.lineHeight);
    self.desLabel.center = CGPointMake(self.center.x, imgCenterY + imgH * 0.5 + self.desToImgGap);
    self.nullImgView.contentMode = UIViewContentModeScaleAspectFit;
    [super layoutSubviews];
    
    [self layoutIfNeeded];
}
@end
