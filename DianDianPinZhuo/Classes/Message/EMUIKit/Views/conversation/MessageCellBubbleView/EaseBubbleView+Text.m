//
//  EaseBubbleView+Text.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/7/2.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseBubbleView+Text.h"
#import "FDUtils.h"

@implementation EaseBubbleView (Text)

#pragma mark - private

- (void)_setupTextBubbleMarginConstraints
{
    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    
    NSLayoutConstraint *marginTopConstraintBgView = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *marginBottomConstraintBgView = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *marginLeftConstraintBgView = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraintBgView = [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];

    NSLayoutConstraint *marginTopConstraintIconImage = [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top+10];
    
    NSLayoutConstraint *marginLeftConstraintIconImage = [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    NSLayoutConstraint *marginWidthConstraintIconImage = [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *marginHeightConstraintIconImage = [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:31];
    
    
    NSLayoutConstraint *marginTopConstraintContent = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top+10];

    NSLayoutConstraint *marginLeftConstraintContent = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    //-self.margin.right
    
    NSLayoutConstraint *marginRightConstraintContent = [NSLayoutConstraint constraintWithItem:self.content attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left+35];
    
    

    
    NSLayoutConstraint *marginBottomConstraintLineView = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-36];
    
    NSLayoutConstraint *marginLeftConstraintLineView = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraintLineView = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    
    NSLayoutConstraint *marginHeightConstraintLineView = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1];
    
    
    
    NSLayoutConstraint *marginBottomConstraintConfirmBtn = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *marginRightConstraintConfirmBtn = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginWidthConstraintConfirmBtn = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80];
    
    NSLayoutConstraint *marginHeightConstraintConfirmBtn = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    
    
    
    
    NSLayoutConstraint *marginBottomConstraintArrowImage = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom-6];
    NSLayoutConstraint *marginRightConstraintArrowImage = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginWidthConstraintArrowImage = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:6];
    
    NSLayoutConstraint *marginHeightConstraintArrowImage = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10];
    
    
    
    
    
    [self.marginConstraints removeAllObjects];
    [self.marginConstraints addObject:marginTopConstraint];
    [self.marginConstraints addObject:marginBottomConstraint];
    [self.marginConstraints addObject:marginLeftConstraint];
    [self.marginConstraints addObject:marginRightConstraint];
    
    [self.marginConstraints addObject:marginTopConstraintBgView];
    [self.marginConstraints addObject:marginBottomConstraintBgView];
    [self.marginConstraints addObject:marginLeftConstraintBgView];
    [self.marginConstraints addObject:marginRightConstraintBgView];
    
    [self.marginConstraints addObject:marginTopConstraintContent];
    [self.marginConstraints addObject:marginLeftConstraintContent];
    [self.marginConstraints addObject:marginRightConstraintContent];
    
    
    [self.marginConstraints addObject:marginTopConstraintIconImage];
    [self.marginConstraints addObject:marginWidthConstraintIconImage];
    [self.marginConstraints addObject:marginHeightConstraintIconImage];
    [self.marginConstraints addObject:marginLeftConstraintIconImage];
    
    [self.marginConstraints addObject:marginBottomConstraintLineView];
    [self.marginConstraints addObject:marginHeightConstraintLineView];
    [self.marginConstraints addObject:marginLeftConstraintLineView];
    [self.marginConstraints addObject:marginRightConstraintLineView];
    
    [self.marginConstraints addObject:marginWidthConstraintConfirmBtn];
    [self.marginConstraints addObject:marginBottomConstraintConfirmBtn];
    [self.marginConstraints addObject:marginRightConstraintConfirmBtn];
    [self.marginConstraints addObject:marginHeightConstraintConfirmBtn];
    
    
    [self.marginConstraints addObject:marginWidthConstraintArrowImage];
    [self.marginConstraints addObject:marginBottomConstraintArrowImage];
    [self.marginConstraints addObject:marginRightConstraintArrowImage];
    [self.marginConstraints addObject:marginHeightConstraintArrowImage];
    
    
    
    [self addConstraints:self.marginConstraints];
}

- (void)_setupTextBubbleConstraints
{
    [self _setupTextBubbleMarginConstraints];
}

#pragma mark - public

- (void)setupTextBubbleView
{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.userInteractionEnabled = NO;
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.userInteractionEnabled = NO;
    
    ///自定义
    self.confirmBtn = [[UIButton alloc]init];
    self.confirmBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.confirmBtn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    self.confirmBtn.userInteractionEnabled = NO;
    
    self.content = [[UILabel alloc] init];
    self.content.translatesAutoresizingMaskIntoConstraints = NO;
    self.content.textColor = [FDUtils colorWithHexString:@"#666666"];
    self.content.font = [UIFont systemFontOfSize:16];
    self.content.numberOfLines = 2;
    self.content.userInteractionEnabled = NO;
//    self.content.backgroundColor = [UIColor redColor];
    
    
    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconImage.userInteractionEnabled = NO;
    
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"message_ico_arrows_nor"];
    self.arrowImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.arrowImage.userInteractionEnabled = NO;

    self.lineView = [[UIImageView alloc] init];
    self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView.backgroundColor = [FDUtils colorWithHexString:@"#000000" alpha:0.15];
    self.lineView.userInteractionEnabled = NO;
    
    
    [self.backgroundImageView addSubview:self.textLabel];
    
    [self.backgroundImageView addSubview:self.bgView];
    [self.backgroundImageView addSubview:self.content];
    [self.backgroundImageView addSubview:self.iconImage];
    [self.backgroundImageView addSubview:self.arrowImage];
    [self.backgroundImageView addSubview:self.lineView];
    [self.backgroundImageView addSubview:self.confirmBtn];
    self.backgroundImageView.userInteractionEnabled = NO;
    
    self.bgView.hidden = YES;
    self.content.hidden = YES;
    self.iconImage.hidden = YES;
    self.lineView.hidden = YES;
    self.confirmBtn.hidden = YES;
    self.arrowImage.hidden = YES;
    
    
    [self _setupTextBubbleConstraints];
}

- (void)updateTextMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    
    
    [self removeConstraints:self.marginConstraints];
    [self _setupTextBubbleMarginConstraints];
}

@end
