//
//  FDGrowingHeadView.h
//  DianDianPinZhuo
//
//  Created by user on 15/11/18.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDGrowingHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *growing_num;
@property (weak, nonatomic) IBOutlet UILabel *growing_hint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numY;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@end
