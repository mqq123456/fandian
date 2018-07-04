//
//  FDInformationViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootGroupTableViewController.h"

@interface FDInformationViewController : RootGroupTableViewController
@property(nonatomic,copy) NSString *xpl;
@property (nonatomic ,strong)UIActionSheet * actionSheet;
@property(nonatomic,copy)NSString *constellationStr;
- (void)coverClickIndex:(NSInteger)index title:(NSString *)star;
@end
