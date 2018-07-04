//
//  FDBindingViewController.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDBindingViewController.h"

@interface FDBindingViewController ()

@end

@implementation FDBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTitleViewWithTitle:@"绑定手机号"];
    self.label1.text = @"为提供更好的服务，请绑定手机号（仅需绑定一次）";
    self.label1.width =[UIScreen mainScreen].bounds.size.width;
    self.label2.text = @"";
}
- (void)addWeiXinView{
}
#pragma mark - Nav
- (void)setNav{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
