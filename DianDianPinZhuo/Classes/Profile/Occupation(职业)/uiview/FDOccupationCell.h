//
//  FDOccupationCell.h
//  WSDropMenuView
//
//  Created by user on 16/1/6.
//  Copyright © 2016年 Senro Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDOccupationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@end
