//
//  FDDetailImageCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdView;
@interface FDDetailImageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView imagesURL:(NSArray *)imagesURL;
- (void)imageClick:(UITapGestureRecognizer *)tap;
@property (nonatomic,strong) AdView *view;
@end
