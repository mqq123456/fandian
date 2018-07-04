//
//  FDTopicWaitingView.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTopicWaitingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *hour;

@property (weak, nonatomic) IBOutlet UIView *bgView;

+(instancetype)selfWaitingView;
@end
