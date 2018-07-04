//
//  XHScrollMenu.h
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHIndicatorView.h"
#import "XHMenu.h"
#import "XHMenuButton.h"

#define kXHMenuButtonPaddingX 0
#define kXHMenuButtonStarX 0

@class XHScrollMenu;

@protocol XHScrollMenuDelegate <NSObject>

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex;
- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu;

- (void)scrollMenuDidClickAlertBtn:(XHScrollMenu *)scrollMenu;

@end

@interface XHScrollMenu : UIView

@property (nonatomic, assign) id <XHScrollMenuDelegate> delegate;

// UI
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XHIndicatorView *indicatorView;


///已订满的提示，对应上面状态3
@property (nonatomic , copy)NSString * soldout_hint;
///餐厅未开餐餐点已过的提示，对应上面状态4
@property (nonatomic , copy)NSString * meal_time_end_hint;
///已过期时段的提示，对应上面状态2
@property (nonatomic , copy)NSString * meal_time_expired_hint;

// DataSource
@property (nonatomic, strong) NSArray *menus;

// select
@property (nonatomic, assign) NSUInteger selectedIndex; // default is 0
@property (nonatomic, assign) NSUInteger best_selectedIndex; // default is 0

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index;

- (XHMenuButton *)menuButtonAtIndex:(NSUInteger)index;

// reload dataSource
- (void)reloadData;

@end
