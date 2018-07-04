//
//  FDGuideView.h
//  DianDianPinZhuo
//
//  Created by user on 16/2/24.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGuideView : UIView
@property (weak, nonatomic) IBOutlet UIButton *disBtn;
@property (weak, nonatomic) IBOutlet UIImageView *people_icon;
- (IBAction)disBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backLeft;

@end
