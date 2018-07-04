//
//  ZJSliderView.m
//  MyDamai
//
//  Created by mac on 14-10-18.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "ZJSliderView.h"
#import "FDUtils.h"
#import "UIView+Extension.h"
#import "HQConst.h"
#define TOP_TAG 200
#define CONTENT_TAG 201

@interface ZJSliderView ()<UIScrollViewDelegate>
{
    UIScrollView *_topScrollView;
    NSMutableArray *_labelArray;
    UIScrollView *_contentScrollView;
    NSArray *titleArray;
    BOOL first;
    
}
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,weak)UILabel *label1;
@property (nonatomic ,weak)UILabel *label2;
@end

@implementation ZJSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        titleArray = [[NSArray alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewClick:) name:Html5PoPHome object:nil];
    }
    return self;
}
- (void)scrollViewClick:(NSNotification *)no{
        if ([no.userInfo[@"index"] intValue]==0) {
            self.label1.textColor = [FDUtils colorWithHexString:@"#e83140"];
            self.label2.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
            [UIView animateWithDuration:0.2 animations:^{
                self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4-49, 34 , 100, 2);
            }];
            
        }else{
            
            self.label2.textColor = [FDUtils colorWithHexString:@"#e83140"];
            self.label1.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
            [UIView animateWithDuration:0.2 animations:^{
                self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4*3-49, 34,100, 2);
                
            }completion:^(BOOL finished) {
                if (!first) {
                    first = YES;
                    [[NSNotificationCenter defaultCenter]postNotificationName:firstScrollNumber object:nil];
                }
            }];
        }
        
        [self topScrollViewShowPage:[no.userInfo[@"index"] intValue]];
        [self contentScrollViewShowPage:[no.userInfo[@"index"] intValue]];
    
}
//执行执行此方法之前必须要设定ZJSliderView的frame
-(void)setViews:(NSArray *)views names:(NSArray *)names;
{
    
    //
    if(_labelWidth == 0)
    {
        _labelWidth = 80;
    }
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 36)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35.5, ScreenW, 0.5)];
    line.backgroundColor = FDColor(233, 233, 233, 1);
    [topView addSubview:line];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-49, 34, 100, 2)];
    self.lineView.backgroundColor = [FDUtils colorWithHexString:@"#e83140"];
    [topView addSubview:self.lineView];
    
    _labelArray = [[NSMutableArray alloc] init];
    float width = _labelWidth;
    
    for (int i=0; i<names.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, 0, width, 30)];
        label.text = names[i];
        label.font = [UIFont systemFontOfSize:16];
        label.userInteractionEnabled = YES;
        label.tag = i+100;
        label.textColor = [FDUtils colorWithHexString:@"#e83140"];
        label.textAlignment = NSTextAlignmentCenter;
        [_labelArray addObject:label];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [label addGestureRecognizer:tap];
        [topView addSubview:label];
        if (i==0) {
            self.label1 = label;
        }else{
            self.label2 = label;
        }
        titleArray = names;
        
    }
  
    
    //创建view
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, [UIScreen mainScreen].bounds.size.width, self.frame.size.height-36)];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.tag = CONTENT_TAG;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.delegate = self;
    [self addSubview:_contentScrollView];
    
    for (int i=0; i<views.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*_contentScrollView.frame.size.width, 0, _contentScrollView.frame.size.width, _contentScrollView.frame.size.height)];
        [view addSubview:views[i]];
        
        //NSArray *array = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
        //view.backgroundColor = array[i%3];
        
        [_contentScrollView addSubview:view];
    }
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * views.count, _contentScrollView.frame.size.height);

    if (self.left) {
        CGPoint offSet = CGPointMake(0, 0);
        _contentScrollView.contentOffset = offSet;
    }else{

        CGPoint offSet = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        _contentScrollView.contentOffset = offSet;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //显示第0页
    if ([[defaults objectForKey:@"sliderViewLeftOrRight" ] isEqualToString:@"1"]) {
        [self topScrollViewShowPage:1];
        [self contentScrollViewShowPage:1];
    }else{
    
        [self topScrollViewShowPage:0];
        [self contentScrollViewShowPage:0];
    }
    
    
}

#pragma mark - 处理动画结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.tag == CONTENT_TAG)
    {
        //注意0除
        int page = scrollView.contentOffset.x / self.frame.size.width;
        if(page == 1){
        
            if (!first) {
                first = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:firstScrollNumber object:nil];
            }
        }
        [self topScrollViewShowPage:page];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [defaults setObject:[NSString stringWithFormat:@"%d",page] forKey:@"sliderViewLeftOrRight"];
        
        [defaults synchronize];
    }
    
}


-(void)dealTap:(UITapGestureRecognizer *)tap
{
    int page = (int)tap.view.tag - 100;
    

    if (page==0) {
        self.label1.textColor = [FDUtils colorWithHexString:@"#e83140"];
        self.label2.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4-49, 34 , 100, 2);
        }];
        
    }else{

        self.label2.textColor = [FDUtils colorWithHexString:@"#e83140"];
        self.label1.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4*3-49, 34,100, 2);
            
        }completion:^(BOOL finished) {
            if (!first) {
                first = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:firstScrollNumber object:nil];
            }
        }];
    }

    
    [self topScrollViewShowPage:page];
    [self contentScrollViewShowPage:page];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%d",page] forKey:@"sliderViewLeftOrRight"];
    [defaults synchronize];
}
-(void)topScrollViewShowPage:(int)page
{
//    for (UILabel *label in _labelArray) {
//        label.textColor = [UIColor blackColor];
//    }
//    UILabel *selectLabel = _labelArray[page];
//    selectLabel.textColor = [UIColor redColor];
    
    //
    //获取当前显示范围
    int currentPage = _topScrollView.contentOffset.x / _labelWidth;
    //NSLog(@"--> %d %d %d %d",currentPage,currentPage+1,currentPage+2,currentPage+3);
    if (page == 0) {
        self.label1.textColor = [FDUtils colorWithHexString:@"#e83140"];
        self.label2.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4-49, 34 , 100, 2);
            
            
        }];
    }else{
        self.label2.textColor = [FDUtils colorWithHexString:@"#e83140"];
        self.label1.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0  blue:51.0/255.0  alpha:1];
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/4*3-49, 34, 100, 2);
            
        }];
    }
   
    
    //
    if(page > currentPage+3)
    {
        [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentOffset.x + _labelWidth, 0) animated:YES];
    }
    if(page < currentPage)
    {
        [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentOffset.x - _labelWidth, 0) animated:YES];
    }
    
    
}
-(void)contentScrollViewShowPage:(int)page
{
    [_contentScrollView setContentOffset:CGPointMake(page * _contentScrollView.frame.size.width, 0) animated:YES];
//    if (first) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        
//        [defaults setObject:[NSString stringWithFormat:@"%d",page] forKey:@"sliderViewLeftOrRight"];
//        [defaults synchronize];
//    }

}


@end
