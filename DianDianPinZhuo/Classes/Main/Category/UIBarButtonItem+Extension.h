//
//  UIBarButtonItem+Extension.h
//  诺曼底
//
//  Created by user on 15/5/20.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
