//
//  FDUserDetailViewController.h
//  Diandian1.4Test
//
//  Created by lutao on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "UserModel.h"
@interface FDUserDetailViewController : RootViewController
@property (nonatomic , assign) BOOL isUser;
@property (nonatomic , copy) NSString *kid;
@property (nonatomic ,strong) UserModel *user;
@property(nonatomic,weak)UITableView *footerTableView;
- (void)setHeadView;
@end
