//
//  FDSubject_Users_cell.h
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDSubjectDetailViewController.h"
#import "FDSubjectUsers_View.h"
@interface FDSubject_Users_cell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView controller:(FDSubjectDetailViewController *)viewController usersArray:(NSArray *)users views:(FDSubjectUsers_View *)views;

@end
