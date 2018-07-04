/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "EMRemarkImageView.h"
#import "UIView+Extension.h"
@implementation EMRemarkImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _editing = NO;
        
        CGFloat vMargin = frame.size.height / 6;
        CGFloat hMargin = vMargin / 2;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(hMargin, 0, frame.size.width - vMargin, frame.size.height - vMargin)];
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
        [self addSubview:_imageView];
        
//        UIImageView *bottonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        bottonView.x = CGRectGetMaxX(_imageView.frame)-10;
//        bottonView.y = CGRectGetMaxY(_imageView.frame)-10;
//        [_imageView addSubview:bottonView];
        
        _peopleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _peopleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _peopleBtn.x = CGRectGetMaxX(_imageView.frame)-27;
        _peopleBtn.y = CGRectGetMaxY(_imageView.frame)-14;
        _peopleBtn.width =27;
        _peopleBtn.height =14;
        [_peopleBtn setBackgroundImage:[UIImage imageNamed:@"Im_GroupDetail_people"] forState:UIControlStateNormal];
        [self addSubview:_peopleBtn];
        [self bringSubviewToFront:_peopleBtn];
        
        CGFloat rHeight = _imageView.frame.size.height / 3;
        _remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, CGRectGetHeight(_imageView.frame)+5, _imageView.frame.size.width, rHeight)];
        //_remarkLabel.autoresizesSubviews = UIViewAutoresizingFlexibleTopMargin;
        //_remarkLabel.clipsToBounds = YES;
        //_remarkLabel.numberOfLines = 0;
        _remarkLabel.textAlignment = NSTextAlignmentCenter;
        _remarkLabel.font = [UIFont systemFontOfSize:10.0];
        _remarkLabel.backgroundColor = [UIColor clearColor];
        _remarkLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        [self addSubview:_remarkLabel];
        
    }
    return self;
}

- (void)setRemark:(NSString *)remark
{
    _remark = remark;
    _remarkLabel.text = _remark;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

- (void)setPeople:(NSString *)people{

    _people = people;
    [_peopleBtn setTitle:[NSString stringWithFormat:@" x%@",people] forState:UIControlStateNormal];
}
@end
