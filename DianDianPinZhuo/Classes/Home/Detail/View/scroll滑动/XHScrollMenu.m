//
//  XHScrollMenu.m
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHScrollMenu.h"
#import "FDUtils.h"
#import "UIScrollView+XHVisibleCenterScroll.h"
#import "SVProgressHUD.h"
#import "HQDefaultTool.h"
#import "UIView+Frame.h"

#define kXHMenuButtonBaseTag 100
#define kXHMenuTop 50

@interface XHScrollMenu () <UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) NSMutableArray *menuButtons;
@property (nonatomic, strong) NSMutableArray *menuTime_label;
@property (nonatomic, strong) NSMutableArray *HuiImages;

@end

@implementation XHScrollMenu

#pragma mark - Propertys

- (NSMutableArray *)menuButtons {
    if (!_menuButtons) {
        _menuButtons = [[NSMutableArray alloc] initWithCapacity:self.menus.count];
    }
    return _menuButtons;
}

- (NSMutableArray *)menuTime_label {
    if (!_menuTime_label) {
        _menuTime_label = [[NSMutableArray alloc] initWithCapacity:self.menus.count];
    }
    return _menuTime_label;
}
- (NSMutableArray *)HuiImages{
    if (!_HuiImages) {
        _HuiImages =[[NSMutableArray alloc] initWithCapacity:self.menus.count];
    }
    return _HuiImages;
}
#pragma mark - Action

- (void)managerMenusButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scrollMenuDidManagerSelected:)]) {
        [self.delegate scrollMenuDidManagerSelected:self];
    }
}

- (void)menuButtonSelected:(UIButton *)sender {
    [self.menuButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj == sender) {
            sender.selected = YES;
        } else {
            UIButton *menuButton = obj;
            menuButton.selected = NO;
        }
    }];
    [self setSelectedIndex:sender.tag - kXHMenuButtonBaseTag animated:YES calledDelegate:YES];
}

#pragma mark - Life cycle

- (UIImageView *)getShadowView:(BOOL)isLeft {
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, CGRectGetHeight(self.bounds))];
    shadowImageView.image = [UIImage imageNamed:(isLeft ? @"leftShadow" : @"rightShadow")];

    shadowImageView.hidden = isLeft;
    return shadowImageView;
}

- (void)setup {

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    _selectedIndex = 0;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kXHMenuTop, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds)-kXHMenuTop)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.clipsToBounds = NO;
    _scrollView.layer.borderColor = [FDUtils colorWithHexString:@"#EEEEEE"].CGColor;
    _scrollView.layer.borderWidth = 0.5;
    _indicatorView = [XHIndicatorView initIndicatorView];
    _indicatorView.alpha = 0.;
    [_scrollView addSubview:self.indicatorView];
    UIButton *dateBtn = [[UIButton alloc]init];
    
    [dateBtn setTitle:@" 开餐时间" forState:UIControlStateNormal];
    
    [dateBtn setTitleColor:[FDUtils colorWithHexString:@"222222"] forState:UIControlStateNormal];
    
    [dateBtn setImage:[UIImage imageNamed:@"bow_ico_xzsj"] forState:UIControlStateNormal];
    
    dateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    dateBtn.frame = CGRectMake(4, 0, 100, 50);
    
    [self addSubview:dateBtn];
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 14-12, (50-12)/2, 12, 12)];
    
    imageView.image = [UIImage imageNamed:@"bow_ico_tiqianyuyue"];
    
    [self addSubview:imageView];
    
    UILabel *alertLabel = [[UILabel alloc]init];
    
    alertLabel.textColor = [FDUtils colorWithHexString:@"999999"];
    
    alertLabel.font = [UIFont systemFontOfSize:14];
    
    alertLabel.text = [HQDefaultTool getAdvanced_order_tips_title];
    
    alertLabel.textAlignment = NSTextAlignmentRight;
    
    CGRect  Rect = [[HQDefaultTool getAdvanced_order_tips_title] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    alertLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30-Rect.size.width, 0, Rect.size.width, 50);
    
    [self addSubview:alertLabel];
    
    UIButton *alertBtn = [[UIButton alloc]init];

    alertBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30-Rect.size.width+30, 0, Rect.size.width, 50);
    
    [alertBtn addTarget:self action:@selector(alertBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:alertBtn];
    
    
    [self addSubview:self.scrollView];

}

- (void)setupIndicatorFrame:(CGRect)menuButtonFrame animated:(BOOL)animated callDelegate:(BOOL)called {
    [UIView animateWithDuration:(animated ? 0.15 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

    } completion:^(BOOL finished) {
        if (called) {
            XHMenu *menu =[self.menus objectAtIndex:self.selectedIndex];

            if ([menu.state integerValue]==2){
                [SVProgressHUD showImage:nil status:self.meal_time_expired_hint];
            }else if([menu.state integerValue]==3){
                [SVProgressHUD showImage:nil status:self.soldout_hint];
            }else if([menu.state integerValue]==4){
                [SVProgressHUD showImage:nil status:self.meal_time_end_hint];
            }
            else{
                _indicatorView.frame = CGRectMake(CGRectGetMinX(menuButtonFrame), 0, CGRectGetWidth(menuButtonFrame), 60);
                if ([self.delegate respondsToSelector:@selector(scrollMenuDidSelected:menuIndex:)]) {
                    [self.delegate scrollMenuDidSelected:self menuIndex:self.selectedIndex];
                }
            
            }
           
        }
    }];
}

- (UIButton *)getButtonWithMenu:(XHMenu *)menu {

    CGSize buttonSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, self.bounds.size.height-kXHMenuTop);
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];

    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = menu.titleFont;
    button.titleEdgeInsets = UIEdgeInsetsMake(-22, 0, 0, 0);
    [button setTitle:menu.title forState:UIControlStateNormal];
    [button setTitle:menu.title forState:UIControlStateHighlighted];
    [button setTitle:menu.title forState:UIControlStateSelected];
    [button setTitleColor:[FDUtils colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    if (!menu.titleHighlightedColor) {
        menu.titleHighlightedColor = menu.titleNormalColor;
    }
    [button setTitleColor:menu.titleHighlightedColor forState:UIControlStateHighlighted];
    if (!menu.titleSelectedColor) {
        menu.titleSelectedColor = menu.titleNormalColor;
    }
    [button setTitleColor:[FDUtils colorWithHexString:@"#666666"] forState:UIControlStateSelected];
    [button setTitleColor:[FDUtils colorWithHexString:@"#bababa"] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (UILabel *)getTimeLabelWithMenu:(XHMenu *)menu {

    CGRect timeRect = [menu.time_title boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:menu.titleFont} context:nil];
    UILabel *time_label = [[UILabel alloc] initWithFrame:CGRectMake(0,20, timeRect.size.width, 15)];
    
    time_label.textAlignment = NSTextAlignmentCenter;
    time_label.font = menu.titleFont;
    time_label.text = menu.time_title;
    time_label.textColor = [FDUtils colorWithHexString:@"#222222"];

    return time_label;
}

- (UIImageView *)getHuiImageWithMenu:(XHMenu *)menu{
    UIImageView *hui_image = [[UIImageView alloc] initWithFrame:CGRectMake(0,20, 14, 14)];
    
    hui_image.image = [UIImage imageNamed:@"bow_ico_hui"];
    hui_image.hidden = [menu.is_discount integerValue]==1?NO:YES;
    return hui_image;

}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#pragma mark - Public

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index {
    CGRect rect = ((UIView *)self.menuButtons[index]).frame;
    return rect;
}

- (XHMenuButton *)menuButtonAtIndex:(NSUInteger)index {
    return self.menuButtons[index];
}
- (UILabel *)menuTime_label_AtIndex:(NSUInteger)index {
    return self.menuTime_label[index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate {
    _selectedIndex = selectedIndex;

    UIButton *selectedMenuButton = [self menuButtonAtIndex:_selectedIndex];
    XHMenu *menu = [self.menus objectAtIndex:_selectedIndex];
    
    if ([menu.state integerValue]==2||[menu.state integerValue]==3||[menu.state integerValue]==4) {
        [selectedMenuButton setTitleColor:[FDUtils colorWithHexString:@"#bababa"] forState:UIControlStateSelected];
        selectedMenuButton.backgroundColor = [FDUtils colorWithHexString:@"#f9f9f9"];
        
    }
    [self setupIndicatorFrame:selectedMenuButton.frame animated:aniamted callDelegate:calledDelgate];

}

- (void)reloadData {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [((UIButton *)obj) removeFromSuperview];
        }
        if ([obj isKindOfClass:[UILabel class]]) {
            [((UILabel *)obj) removeFromSuperview];
        }
        
        if ([obj isKindOfClass:[UIImageView class]]) {
            [((UIImageView *)obj) removeFromSuperview];
        }
    }];
    if (self.menuButtons.count)
        [self.menuButtons removeAllObjects];
        [self.menuTime_label removeAllObjects];
        [self.HuiImages removeAllObjects];
    // layout subViews
    CGFloat contentWidth = 10;

    
    
    for (XHMenu *menu in self.menus) {
        NSUInteger index = [self.menus indexOfObject:menu];
        UIButton *menuButton = [self getButtonWithMenu:menu];
        UILabel *time_label = [self getTimeLabelWithMenu:menu];
        UIImageView *hui_image = [self getHuiImageWithMenu:menu];
        menuButton.tag = kXHMenuButtonBaseTag + index;
        time_label.tag = kXHMenuButtonBaseTag + index;
        CGRect menuButtonFrame = menuButton.frame;
        CGFloat buttonX = 0;
        if (index) {
            buttonX = kXHMenuButtonPaddingX + CGRectGetMaxX(((UIButton *)(self.menuButtons[index - 1])).frame);
        } else {
            buttonX = kXHMenuButtonStarX;
        }
        
        menuButtonFrame.origin = CGPointMake(buttonX, 0);
        menuButton.frame = menuButtonFrame;
        time_label.frame = CGRectMake(menuButtonFrame.origin.x+(menuButtonFrame.size.width-time_label.width)/2, 30, time_label.width, 20);
        hui_image.frame =  CGRectMake(CGRectGetMaxX(time_label.frame)+5, 33, 14, 14);
        [self.scrollView addSubview:menuButton];
        [self.scrollView addSubview:time_label];
        [self.scrollView addSubview:hui_image];
        [self.menuButtons addObject:menuButton];
        [self.menuTime_label addObject:time_label];
        [self.HuiImages addObject:time_label];
        // scrollView content size width
        if (index == self.menus.count - 1) {
            contentWidth += CGRectGetMaxX(menuButtonFrame);
        }
        
        if (self.selectedIndex == index) {
            menuButton.selected = YES;
            // indicator
            _indicatorView.alpha = 1.;
            _indicatorView.frame = CGRectMake(CGRectGetMinX(menuButtonFrame), 0, CGRectGetWidth(menuButtonFrame), 60);
            [self setupIndicatorFrame:menuButtonFrame animated:NO callDelegate:NO];
        }
        
        
        if ([menu.state integerValue]==2||[menu.state integerValue]==3||[menu.state integerValue]==4) {
//            menuButton.enabled = NO;
            [menuButton setTitleColor:[FDUtils colorWithHexString:@"#bababa"] forState:UIControlStateNormal];
            menuButton.backgroundColor = [FDUtils colorWithHexString:@"#f9f9f9"];
            time_label.textColor = [FDUtils colorWithHexString:@"#bababa"];
        }else{
//            menuButton.enabled = YES;
            time_label.textColor = [FDUtils colorWithHexString:@"#222222"];
        }
        
    }

    
    [self.scrollView setContentSize:CGSizeMake(contentWidth, CGRectGetHeight(self.scrollView.frame))];
//    [self setSelectedIndex:self.selectedIndex animated:NO calledDelegate:YES];
}

#pragma mark -- 点击提示
- (void)alertBtnClick{
    if([self.delegate respondsToSelector:@selector(scrollMenuDidClickAlertBtn:)]){
        [self.delegate scrollMenuDidClickAlertBtn:self];
    }
}
@end
