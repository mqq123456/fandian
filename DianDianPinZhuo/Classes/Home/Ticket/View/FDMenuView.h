//
//  FDMenuView.h
//  DianDianPinZhuo
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDMenuView : UIView
+(instancetype)menuWithSmall_imagesURL:(NSMutableArray *)small_imagesURL small_categoryArray:(NSMutableArray *)small_categoryArray small_menusArray:(NSMutableArray *)small_menusArray  menuTitle:(NSString *)small_menu_title;
@property (weak, nonatomic) IBOutlet UIView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *menuListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewH;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backRightH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backLeftH;
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;

@end
