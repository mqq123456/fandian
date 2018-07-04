//
//  FDTimeLabel.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/25.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTimeLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;
@end
