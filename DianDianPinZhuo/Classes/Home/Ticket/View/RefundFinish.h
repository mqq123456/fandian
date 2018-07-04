//
//  RefundFinish.h
//  DianDianPinZhuo
//
//  Created by user on 15/9/9.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundFinish : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (copy) void (^doneBtnClick)();
@end
