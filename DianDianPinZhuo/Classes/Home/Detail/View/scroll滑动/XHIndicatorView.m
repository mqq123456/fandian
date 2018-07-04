//
//  XHIndicatorView.m
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHIndicatorView.h"

@implementation XHIndicatorView

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    CGRect indicatorRect = self.frame;
    indicatorRect.size.width = _indicatorWidth;
    self.frame = indicatorRect;
}

+ (instancetype)initIndicatorView {
    XHIndicatorView *indicatorView = [[XHIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, kXHIndicatorViewHeight)];
    return indicatorView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_btn_shijian_dis"]];
        UIView *veiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 58)];
        
        UIImage* original = [UIImage imageNamed:@"tab_btn_shijian_dis"];//refresh_wifiname是一个40*40的图片
        UIImage *stren = [self OriginImage:original scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 60)];
        UIColor *clr = [[UIColor alloc]initWithPatternImage:stren];
        veiw.backgroundColor = clr;
        //self.backgroundColor = clr;
        [self addSubview:veiw];
    }
    return self;
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
