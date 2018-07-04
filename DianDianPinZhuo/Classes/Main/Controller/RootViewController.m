//
//  RootViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [FDLoadingGifHUD dismiss];
}
- (void)addTitleViewWithTitle:(NSString *)title{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 19)];
    label1.textAlignment =NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    label1.text = title;
    //根据字体名称和字号设置字体
    label1.font=[UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = label1;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
