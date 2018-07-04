//
//  HWNewfeatureViewController.m
//
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWNewfeatureViewController.h"
#import "UIView+Extension.h"
#import "AppDelegate.h"
#import "HQConst.h"

#define HWNewfeatureCount 4

@interface HWNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation HWNewfeatureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<HWNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == HWNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(HWNewfeatureCount * scrollW, 0);
    //scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    

}


/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;

    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, ScreenH*0.75, (ScreenW-120), 100)];

    startBtn.userInteractionEnabled = YES;
    [imageView addSubview:startBtn];

    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}


- (void)startClick
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"1" forKey:@"Follow"];
    
    [defaults synchronize];
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate initRootViewController];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    
    if (scrollView.contentOffset.x>(HWNewfeatureCount-1)*ScreenW) {
        
        
        
        [self startClick];
        
        
        
    }
}

@end
