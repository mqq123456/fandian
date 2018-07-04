//
//  FDUsersCell.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDUsersFrame;
@interface FDUsersCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,assign) FDUsersFrame *usersFrame;

@end
