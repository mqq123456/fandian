//
//  HJCActionSheet.h
//  wash
//
//  Created by weixikeji on 15/5/11.
//
//

#import <UIKit/UIKit.h>

@class HJCActionSheet;

@protocol HJCActionSheetDelegate <NSObject>

@optional

/**
 *  点击按钮
 */
- (void)actionSheet:(HJCActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface HJCActionSheet : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <HJCActionSheetDelegate> delegate;

/**
 *  创建对象方法
 */
- (instancetype)initWithDelegate:(id<HJCActionSheetDelegate>)delegate CancelTitle:(NSString *)cancelTitle OtherTitles:(NSArray*)otherTitles;

- (void)show;

@end
