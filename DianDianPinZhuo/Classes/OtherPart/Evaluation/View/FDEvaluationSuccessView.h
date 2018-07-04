//
//  FDEvaluationSuccessView.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDEvaluationSuccessView : UIView
+(instancetype)selfEvaluationSuccessView;
@property (weak, nonatomic) IBOutlet UIButton *sendTo_weixin;

///给我红包也不要

@property (weak, nonatomic) IBOutlet UIButton *bonus_NO;

@property (weak, nonatomic) IBOutlet UILabel *bonusNum_title;

@end
