//
//  FDBonusView.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDBonusView : UIView
///红包背景
@property (weak, nonatomic) IBOutlet UIImageView *bonusView;
///恭喜获得10个红包
@property (weak, nonatomic) IBOutlet UILabel *bonusNum_title;
///副标题
@property (weak, nonatomic) IBOutlet UILabel *sub_title;
///分享到微信
@property (weak, nonatomic) IBOutlet UIButton *sendTo_weixin;
///给我红包也不要
@property (weak, nonatomic) IBOutlet UIButton *bonus_NO;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GongxiTop;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

+(instancetype)selfBounsView;

@end
