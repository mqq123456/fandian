//
//  ButtonsView.h
//  Diandian1.4Test
//
//  Created by lutao on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonsView;
@protocol ButtonsViewDelegate <NSObject>

@optional

///点击按钮

- (void)buttonsView:(ButtonsView *)buttonsView  clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array;

@end

@interface ButtonsView : UIView
/**
 *  代理
 */
@property (nonatomic, weak) id <ButtonsViewDelegate> delegate;
/**
 *  创建对象方法
 */
- (instancetype)initWithDelegate:(id<ButtonsViewDelegate>)delegate selectedIndex:(NSInteger)index OtherTitles:(NSArray *)otherTitles viewTag:(NSInteger)tag num:(NSInteger)row frame:(CGRect)frame people_hint:(NSString *)hint;

@end
