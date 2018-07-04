//
//  EaseMessageTimeCell.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseMessageTimeCell.h"

CGFloat const EaseMessageTimeCellPadding = 5;

@interface EaseMessageTimeCell()


@end

@implementation EaseMessageTimeCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseMessageTimeCell *cell = [self appearance];
    cell.titleLabelColor = [UIColor whiteColor];
    cell.titleLabelFont = [UIFont systemFontOfSize:12];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - setup subviews

- (void)_setupSubview
{
    
    _title_bgView = [[UIView alloc]init];
    _title_bgView.translatesAutoresizingMaskIntoConstraints = NO;    
    _title_bgView.layer.cornerRadius = 3;
    _title_bgView.layer.masksToBounds = YES;
    _title_bgView.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1];
    [self.contentView addSubview:_title_bgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1];
    _titleLabel.textColor = _titleLabelColor;
    _titleLabel.font = _titleLabelFont;
    _titleLabel.layer.cornerRadius = 10;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    [self _setupTitleLabelConstraints];
    [self _setupTitle_bgViewConstraints];
}

#pragma mark - Setup Constraints

- (void)_setupTitleLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageTimeCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseMessageTimeCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:240]];
    
    
    
    
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseMessageTimeCellPadding]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseMessageTimeCellPadding]];
}
- (void)_setupTitle_bgViewConstraints{

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title_bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageTimeCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title_bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseMessageTimeCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title_bgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:260]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title_bgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//
//    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:[UIScreen mainScreen].bounds.size.width-140]];
    
    
    
}
#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = _titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    _titleLabel.textColor = _titleLabelColor;
}

#pragma mark - public

+ (NSString *)cellIdentifier
{
    return @"MessageTimeCell";
}

@end
