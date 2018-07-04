//
//  HMLoadMoreFooter.m
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMLoadMoreFooter.h"

@interface HMLoadMoreFooter()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@end

@implementation HMLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMLoadMoreFooter" owner:nil options:nil] lastObject];
    
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    //self.statusLabel.text = @"查看更多餐厅";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.line1.constant = 0.5;
    self.line2.constant = 0.5;
    [self layoutIfNeeded];
}

@end
