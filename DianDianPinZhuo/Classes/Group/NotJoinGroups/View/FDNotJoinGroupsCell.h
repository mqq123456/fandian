//
//  FDNotJoinGroupsCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDNotJoinGroupsFrame;
@interface FDNotJoinGroupsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) FDNotJoinGroupsFrame *statusFrame;
@property (nonatomic ,strong) UINavigationController *nav;
@end
