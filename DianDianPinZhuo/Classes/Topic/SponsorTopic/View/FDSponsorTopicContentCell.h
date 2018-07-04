//
//  FDSponsorTopicContentCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQTextView.h"
@interface FDSponsorTopicContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet HQTextView *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *content_Image;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
