//
//  FDTimeView.h
//  DianDianPinZhuo
//
//  Created by user on 16/2/19.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDTimeView;

@protocol FDTimeViewDelegate <NSObject>

@optional

/**
 *  点击按钮
 */
- (void)timeViewSheet:(FDTimeView *)timeViewSheet index:(NSInteger)index clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array;

@end

@interface FDTimeView : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <FDTimeViewDelegate> delegate;

/**
 *  创建对象方法
 */
- (instancetype)initWithDelegate:(id<FDTimeViewDelegate>)delegate index:(NSInteger)index OtherTitles:(NSArray*)otherTitles sender:(UIButton *)sender selectedIndex:(NSInteger)selectIndex best_select_index:(NSInteger)best_select_index;

- (void)show;

@end
