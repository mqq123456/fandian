//
//  HQTextView.h
//  DianDianPinZhuo
//
//  Created by user on 15/8/26.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
