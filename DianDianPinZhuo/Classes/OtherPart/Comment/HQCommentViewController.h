//
//  HQCommentViewController.h
//  normandy
//
//  Created by user on 15/6/25.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//  评论

#import "RootViewController.h"

@interface HQCommentViewController : RootViewController

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,copy) NSString *merchant_id;

@end
