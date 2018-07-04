//
//  ButtonsView.m
//  Diandian1.4Test
//
//  Created by lutao on 15/12/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "ButtonsView.h"
#import "FDUtils.h"
#import "SeatsModel.h"
#import "HQConst.h"
#define BtnH 41
#define singleH 54

#define left 20

#define placeH 13



@interface ButtonsView ()
{
    NSInteger _row;
    
}
@property (nonatomic, weak) ButtonsView *btnView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic , strong)NSMutableArray *buttonsArray;
@property (nonatomic,strong)UIButton *selectedBtn;

@end

@implementation ButtonsView
- (NSMutableArray *)buttonsArray{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (instancetype)initWithDelegate:(id<ButtonsViewDelegate>)delegate selectedIndex:(NSInteger)index OtherTitles:(NSArray *)otherTitles viewTag:(NSInteger)tag num:(NSInteger)row frame:(CGRect)frame people_hint:(NSString *)hint{
    NSMutableArray *titleArray = [NSMutableArray array];
    for (SeatsModel *model in otherTitles) {
        [titleArray addObject:model.seat_desc];
    }
    _row = row;
    self.titles = titleArray;
    self.selectedIndex = index;
    ButtonsView *btnView = [self init];
    
    self.btnView = btnView;
    btnView.delegate = delegate;
    
    
    UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 64)];
    [titleBtn setTitle:@" 选择人数" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"popup_ico_xzrs"] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    titleBtn.backgroundColor = [UIColor whiteColor];
    titleBtn.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    titleBtn.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    titleBtn.layer.shadowOpacity = 0.03;//阴影透明度，默认0
    titleBtn.layer.shadowRadius = 2;//阴影半径，默认3
    
    [self.btnView addSubview:titleBtn];
    
    //    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
    //    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    [self.btnView addSubview:line];
    //
    
    [otherTitles enumerateObjectsUsingBlock:^(SeatsModel *title, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupBtnWithTitle:title tag:idx selected:index];
    }];
    
    NSInteger h ;
    h = (otherTitles.count-1)/row+1;
    int h1;
    
    if (![hint isEqualToString:@""]) {
        CGSize size = [hint sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(frame.size.width-2*left, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
        UILabel *hintlabel = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width-size.width)/2, 100+singleH*h, size.width, 20)];
        hintlabel.text = hint;
        hintlabel.textAlignment = NSTextAlignmentCenter;
        hintlabel.font = [UIFont systemFontOfSize:14];
        hintlabel.textColor = [FDUtils colorWithHexString:@"#999999"];
        [self.btnView addSubview:hintlabel];
        
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(left, 110+singleH*h, (frame.size.width-size.width -20-2*left)/2, 1)];
        line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.btnView addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2+size.width/2+10, 110+singleH*h, (frame.size.width-size.width -20-2*left)/2,1)];
        line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.btnView addSubview:line2];
        h1 = 215;
        
    }
    else{
        
        h1= 200;
        
    }
    
    
    
    
    
    btnView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, h1 +singleH*h);
    //    btnView.backgroundColor = [FDUtils colorWithHexString:@"#292B8B" alpha:.3];
    btnView.backgroundColor = [FDUtils colorWithHexString:@"#fafafa" alpha:1];
    btnView.layer.cornerRadius = 3;
    btnView.layer.masksToBounds = YES;
    
    
    
    UIButton *confrimBtn = [[UIButton alloc]initWithFrame:CGRectMake(left, btnView.frame.size.height-80, frame.size.width-left*2, 48)];
    [confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confrimBtn setTitleColor:[FDUtils colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    confrimBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    confrimBtn.backgroundColor = [FDUtils colorWithHexString:@"#ef263e"];
    confrimBtn.layer.cornerRadius = 3;
    confrimBtn.layer.masksToBounds = YES;
    [confrimBtn addTarget:self action:@selector(selectedNumber) forControlEvents:UIControlEventTouchUpInside];
    
    btnView.layer.cornerRadius = 3;
    btnView.layer.masksToBounds = YES;
    
    
    [self.btnView addSubview:confrimBtn];
    
    
    
    
    return btnView;
}


///创建button
- (void)setupBtnWithTitle:(SeatsModel *)title tag:(NSInteger)index selected:(NSInteger)selectedIndex{
    NSInteger d = index/_row;
    NSInteger c = index%_row;
    NSInteger x;
    NSInteger y;
    
    NSInteger btnW =([UIScreen mainScreen].bounds.size.width-30 - left*2-placeH*(_row-1))/_row;
    if (c == 0) {///3的倍数
        x = left;
    }else{
        
        x= left+btnW*c+c*placeH;
        
    }
    y = 100+d*singleH ;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnW
                                                              , BtnH)];
    [btn setTitleColor:[FDUtils colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [btn setTitleColor:[FDUtils colorWithHexString:@"#999999"] forState:UIControlStateDisabled];
    [btn setTitle:title.seat_desc forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds= YES;
    btn.layer.borderColor = [FDUtils colorWithHexString:@"#f2f2f2"].CGColor;
    btn.layer.borderWidth = 1;
    btn.selected = NO;
    btn.tag = index;
    btn.enabled = YES;
    if (btn.tag == self.titles.count-1&&self.titles.count>=8) {
        btn.titleLabel.numberOfLines = 2;
        if (IPHONE4 || IPHONE5) {
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        
        //        [btn setTitle:[NSString stringWithFormat:@"%@人\n(包桌)",title.seat_num] forState:UIControlStateNormal];
    }
    
    if ([title.seat_state intValue]==0) {
        btn.enabled = NO;
    }
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonsArray addObject:btn];
    [self.btnView addSubview:btn];
    if (index==0) {
        if ([title.seat_state intValue]==1) {
            btn.selected = YES;
            self.selectedBtn = btn;
            [btn setBackgroundColor:[FDUtils colorWithHexString:@"#ef263e"]];
        }
    }
    
    
}


- (void)BtnClick:(UIButton *)btn{
    if (btn.enabled == NO) {
        return;
    }
    
    for (UIButton * button in self.buttonsArray) {
        
        button.backgroundColor = [UIColor whiteColor];
        button.selected = NO;
        
    }
    
    [btn setBackgroundColor:[FDUtils colorWithHexString:@"#ef263e"]];
    btn.selected = YES;
    self.selectedBtn = btn;
    //    if ([self.delegate respondsToSelector:@selector(buttonsView:clickedButtonAtIndex:sender:title:)]) {
    //        [self.delegate buttonsView:self.btnView clickedButtonAtIndex:btn.tag sender:btn title:self.titles];
    //
    //    }
    
}
-(void)selectedNumber{
    if (self.selectedBtn.enabled == NO) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(buttonsView:clickedButtonAtIndex:sender:title:)]) {
        [self.delegate buttonsView:self.btnView clickedButtonAtIndex:self.selectedBtn.tag sender:self.selectedBtn title:self.titles];
    }
    
}
@end
