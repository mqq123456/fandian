//
//  FDEditInfoHeaderView.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/31.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDEditInfoHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *rotatingView;
@property (weak, nonatomic) IBOutlet UIButton *xingzuoBtn;
@property (weak, nonatomic) IBOutlet UILabel *xingzuoText;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageText;
@property (weak, nonatomic) IBOutlet UILabel *provinceText;
@property (weak, nonatomic) IBOutlet UIButton *provinceBtn;
@property (weak, nonatomic) IBOutlet UILabel *cityText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xingzuoX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *provinceX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *privinceBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xingzuoBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *peopleH;


+(instancetype)editInfoHeaderView;
@end
