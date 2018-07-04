//
//  UIBarButtonItem+Extension.m
//  诺曼底
//
//  Created by user on 15/5/20.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
   // btn.size = btn.currentBackgroundImage.size;
   // btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    //btn.frame = CGRectMake(-10, 0, 30, 30);
    btn.size = CGSizeMake(30, 30);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
