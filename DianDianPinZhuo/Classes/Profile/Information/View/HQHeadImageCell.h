//
//  HQHeadImageCell.h
//  normandy
//
//  Created by user on 15/6/24.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQHeadImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;

@end
