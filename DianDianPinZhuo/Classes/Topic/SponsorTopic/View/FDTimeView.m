//
//  FDTimeView.m
//  DianDianPinZhuo
//
//  Created by user on 16/2/19.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTimeView.h"


#import "SVProgressHUD.h"
#import "FDUtils.h"
// 每个按钮的高度
#define BtnHeight 46
// 取消按钮上面的间隔高度
#define Margin 8

#define HJCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:10.0]
// 背景色
#define GlobelBgColor HJCColor(237, 240, 242)
// 分割线颜色
#define GlobelSeparatorColor HJCColor(226, 226, 226)
// 普通状态下的图片
#define normalImage [self createImageWithColor:HJCColor(255, 255, 255)]
// 高亮状态下的图片
#define highImage [self createImageWithColor:HJCColor(242, 242, 242)]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 字体
#define HeitiLight(f) [UIFont fontWithName:@"Helvetica Neue" size:f]

@interface FDTimeView ()
{
    int _tag;
    
}

@property (nonatomic, weak) FDTimeView *timeViewSheet;
@property (nonatomic, weak) UIView *sheetView;

@property (nonatomic, strong) UIButton *sender;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger best_select_index;



@end

@implementation FDTimeView

- (instancetype)initWithDelegate:(id<FDTimeViewDelegate>)delegate index:(NSInteger)index OtherTitles:(NSArray *)otherTitles sender:(UIButton *)sender selectedIndex:(NSInteger)selectIndex best_select_index:(NSInteger)best_select_index
{
    self.sender = sender;
    
    self.titles =otherTitles;
    
    self.index = index;
    
    self.best_select_index = best_select_index;
    
    FDTimeView *timeViewSheet = [self init];
    self.timeViewSheet = timeViewSheet;
    
    timeViewSheet.delegate = delegate;
    
    // 黑色遮盖
    timeViewSheet.frame = [UIScreen mainScreen].bounds;
    timeViewSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:timeViewSheet];
    timeViewSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [timeViewSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha = 1.0;
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
    _tag = 1;
    if (index == 0) {
        [otherTitles enumerateObjectsUsingBlock:^(NSString * curStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self setupBtnWithTitle:curStr index:(NSInteger)sender.tag selected:selectIndex];
        }];
        
    }else{
        
        [otherTitles enumerateObjectsUsingBlock:^(NSString * curStr, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *arr = [curStr componentsSeparatedByString:@" "];
            
            
            NSString *str = [NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
            [self setupBtnWithTitle:str index:(NSInteger)sender.tag selected:selectIndex];
        }];
    }
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = BtnHeight * _tag ;
    sheetView.frame = sheetViewF;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.frame = CGRectMake(0, 0, 70, 46);
    [cancleBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:cancleBtn];
    
    NSString *titleStr;
    if (index==0) {
        titleStr = @"选择人数";
        
        
    }
    if (index==3) {
        titleStr = @"选择时间";
        
    }
    UILabel *titleLabel = [FDUtils createLabel:titleStr withTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46) with:16 withBackColor:[UIColor whiteColor] numberOfLines:1 with:NSTextAlignmentCenter];
    
    [view addSubview:titleLabel];
    
    [self.sheetView addSubview:view];
    
    return timeViewSheet;
}

- (void)show{
    self.sheetView.hidden = NO;
    
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = ScreenHeight - self.sheetView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sheetView.frame = newSheetViewF;
        
        self.timeViewSheet.alpha = 0.3;
    }];
}

- (void)setupBtnWithTitle:(NSString *)title index:(NSInteger)index selected:(NSInteger)selectedIndex{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BtnHeight * (_tag) , ScreenWidth, BtnHeight)];
    [btn setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.font = HeitiLight(17);
    btn.tag = _tag;
    
    if (btn.tag==selectedIndex) {
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    
    else if (btn.tag<self.best_select_index && self.index == 3){
        
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    // 最上面画分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line.backgroundColor = GlobelSeparatorColor;
    [btn addSubview:line];
    
    _tag ++;
}

- (void)coverClick{
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sheetView.frame = sheetViewF;
        self.timeViewSheet.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.timeViewSheet removeFromSuperview];
        [self.sheetView removeFromSuperview];
    }];
}

- (void)sheetBtnClick:(UIButton *)btn{
    self.sender.tag = btn.tag;
    if (btn.tag == 0) {
        [self coverClick];
        return;
    }
    if (btn.tag <self.best_select_index&&self.index == 3) {
        
        [SVProgressHUD showImage:nil status:@"订餐时间已过"];
        return;
    }
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(timeViewSheet:index:clickedButtonAtIndex:sender:title:)]) {
        [self.delegate timeViewSheet:self.timeViewSheet index:self.index clickedButtonAtIndex:btn.tag sender:self.sender title:self.titles];
        
        [self coverClick];
        
        
    }
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
