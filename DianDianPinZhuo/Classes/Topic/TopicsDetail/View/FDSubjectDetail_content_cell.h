//
//  FDSubjectDetail_content_cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDSubjectDetail_content_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *content_imageView;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_imageViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_imageViewH;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
