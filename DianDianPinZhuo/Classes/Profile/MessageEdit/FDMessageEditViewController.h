//
//  FDMessageEditViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootTableViewController.h"

@interface FDMessageEditViewController : RootTableViewController

@property(nonatomic,strong)NSMutableArray *selectArray;

- (void)loadMessageList:(NSString *)delect;

@end
