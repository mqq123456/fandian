//
//  FDSubjectUsers_View.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BtnH 41
#define singleH 55

#define left 20

#define placeH 13

@class FDSubjectUsers_View;
@protocol SubjectUsers_ViewDelegate <NSObject>

@optional

///点击按钮

- (void)buttonsView:(FDSubjectUsers_View *)buttonsView  clickedButtonAtIndex:(NSInteger)buttonIndex sender:(UIButton *)sender title:(NSArray *)array;

@end

@interface FDSubjectUsers_View : UIView
/**
 *  代理
 */
@property (nonatomic, weak) id <SubjectUsers_ViewDelegate> delegate;
/**
 *  创建对象方法
 */
- (instancetype)initWithDelegate:(id<SubjectUsers_ViewDelegate>)delegate selectedIndex:(NSInteger)index OtherTitles:(NSArray*)otherTitles viewTag:(NSInteger)tag num:(NSInteger)row frame:(CGRect)frame is_order:(NSString *)left_seat people:(NSString *)order_seat state:(NSString *)state;

@end
