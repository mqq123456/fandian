//
//  FDBottomViewBothBtn.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/4/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDBottomViewBothBtn : UIView

@property (weak, nonatomic) IBOutlet UIButton *tableBtn;
@property (weak, nonatomic) IBOutlet UIButton *groupBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
+(instancetype)bottomViewBothBtnView;
@end
