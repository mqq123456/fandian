//
//  FDOderWaitingView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDOderWaitingView : UIView

@property (weak, nonatomic) IBOutlet UILabel *peoplesAndDate;

@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (weak, nonatomic) IBOutlet UILabel *hour;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopContains;

@property (weak, nonatomic) IBOutlet UIView *timeBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;

+(instancetype)selfWaitingView;
@end
