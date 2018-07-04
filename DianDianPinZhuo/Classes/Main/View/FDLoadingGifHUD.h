//
//  FDLoadingGifHUD.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/3.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

extern NSString * const FDLoadingGifHUDDidReceiveTouchEventNotification;
extern NSString * const FDLoadingGifHUDWillDisappearNotification;
extern NSString * const FDLoadingGifHUDDidDisappearNotification;

extern NSString * const FDLoadingGifHUDStatusUserInfoKey;

enum {
    FDLoadingGifHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    FDLoadingGifHUDMaskTypeClear, // don't allow
    FDLoadingGifHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    FDLoadingGifHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};
typedef NSUInteger FDLoadingGifHUDMaskType;

@interface FDLoadingGifHUD : UIView

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 50000
@property (readwrite, nonatomic, retain) UIColor *hudBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudForegroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIColor *hudStatusShadowColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIFont *hudFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIImage *hudSuccessImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (readwrite, nonatomic, retain) UIImage *hudErrorImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
#endif

//+ (void)show;
//+ (void)showWithMaskType:(FDLoadingGifHUDMaskType)maskType;
//+ (void)showWithStatus:(NSString*)status;
//+ (void)showWithStatus:(NSString*)status maskType:(FDLoadingGifHUDMaskType)maskType;
//
//+ (void)showProgress:(CGFloat)progress;
//+ (void)showProgress:(CGFloat)progress status:(NSString*)status;
//+ (void)showProgress:(CGFloat)progress status:(NSString*)status maskType:(FDLoadingGifHUDMaskType)maskType;
//
//+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing
//
//// stops the activity indicator, shows a glyph + status, and dismisses HUD 1s later
//+ (void)showSuccessWithStatus:(NSString*)string;
//+ (void)showErrorWithStatus:(NSString *)string;
//+ (void)showImage:(UIImage*)image status:(NSString*)status; // use 28x28 white pngs
//
//+ (void)popActivity;
+ (void)dismiss;

//+ (BOOL)isVisible;

+ (void)showLoadingGifHUD;
@end
