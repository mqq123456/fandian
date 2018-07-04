//
//  FDPersonalCenterViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"

#import "UserModel.h"
@interface FDPersonalCenterViewController : RootGroupTableViewController
@property (nonatomic ,strong) UserModel *model;
- (void)setHeadView;
@property (nonatomic ,weak) UIButton *notice;
@property (nonatomic ,copy) NSString *integral_tip;
@end
