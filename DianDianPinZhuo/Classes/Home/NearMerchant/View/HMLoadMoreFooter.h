//
//  HMLoadMoreFooter.h
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLoadMoreFooter : UIView
+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2;
@end
