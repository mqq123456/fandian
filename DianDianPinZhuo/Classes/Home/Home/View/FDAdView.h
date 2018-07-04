//
//  FDAdView.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/4.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAdView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIView *adImageView;

+(instancetype)selfAdImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;

@end
