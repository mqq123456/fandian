//
//  FDQRCodeView.h
//  DianDianPinZhuo
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDQRCodeView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *CodeImageView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *order_num;

@end
