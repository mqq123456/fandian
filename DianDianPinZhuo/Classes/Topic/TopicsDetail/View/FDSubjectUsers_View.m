//
//  FDSubjectUsers_View.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubjectUsers_View.h"
#import "HQConst.h"
#import "FDUtils.h"
#import "MemberModel.h"
#import "UIButton+WebCache.h"



@interface FDSubjectUsers_View ()
{
    int _tag;
    NSInteger _row;
    
}
@property (nonatomic, weak) FDSubjectUsers_View *btnView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic , strong)NSMutableArray *buttonsArray;
@property (nonatomic,strong)UIButton *selectedBtn;

@end

@implementation FDSubjectUsers_View
- (NSMutableArray *)buttonsArray{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (instancetype)initWithDelegate:(id<SubjectUsers_ViewDelegate>)delegate selectedIndex:(NSInteger)index OtherTitles:(NSArray*)otherTitles viewTag:(NSInteger)tag num:(NSInteger)row frame:(CGRect)frame is_order:(NSString *)left_seat people:(NSString *)order_seat state:(NSString *)state{

    _row = row;
    NSMutableArray *array = [NSMutableArray array];
    for (MemberModel *model in otherTitles) {
        [array addObject:model.img];
    }
    self.titles = array;
//    self.selectedIndex = index;
    FDSubjectUsers_View *btnView = [self init];
    
    self.btnView = btnView;
    btnView.delegate = delegate;
    
    _tag = 0;

    
    NSInteger h ;
    h = (otherTitles.count-1)/row+1;
    
    if (otherTitles.count == 0) {
            btnView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,38);
    }else{
        btnView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,40+singleH*h);
        
        [otherTitles enumerateObjectsUsingBlock:^(MemberModel *title, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setupBtnWithTitle:title.img tag:idx selected:index];
        }];
    }
    


    btnView.backgroundColor = [FDUtils colorWithHexString:@"#ffffff" alpha:1];
    if ([state intValue]==1) {
        UILabel *hasOrder = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW-65,  ([UIScreen mainScreen].bounds.size.width- left*2-placeH*(row-1))/row+placeH*2, 65, 18)];
        if (otherTitles.count == 0) {
            hasOrder.frame = CGRectMake(ScreenW-65,10, 65, 18);
        }
        hasOrder.text = @"已结束";
        hasOrder.textAlignment = NSTextAlignmentLeft;
        hasOrder.textColor = [FDUtils colorWithHexString:@"#666666"];
        hasOrder.font = [UIFont systemFontOfSize:14];
        [btnView addSubview:hasOrder];
        
    }else{
        if([left_seat intValue]==0){//10人预订
            UILabel *hasOrder = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW-80,  ([UIScreen mainScreen].bounds.size.width- left*2-placeH*(row-1))/row+placeH*2, 80, 18)];
            if (otherTitles.count == 0) {
                hasOrder.frame = CGRectMake(ScreenW-80,10, 80, 18);
            }
            hasOrder.text = @"人数已满";
            hasOrder.textAlignment = NSTextAlignmentLeft;
            hasOrder.textColor = [FDUtils colorWithHexString:@"#666666"];
            hasOrder.font = [UIFont systemFontOfSize:14];
            [btnView addSubview:hasOrder];
//            UILabel *dot = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 80-4,  placeH *2+singleH*h+8, 3, 3)];
//            
//            dot.layer.cornerRadius = 1.5;
//            dot.layer.masksToBounds = YES;
//            [btnView addSubview:dot];
//            UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW - 80-4 - 120, placeH *2+singleH*h, 120, 18)];
//            numberLabel.text =  [NSString stringWithFormat:@"已有%@人预订",order_seat];
//            numberLabel.textAlignment = NSTextAlignmentRight;
//            numberLabel.textColor = [FDUtils colorWithHexString:@"#999999"];
//            numberLabel.font = [UIFont systemFontOfSize:14];
//            [btnView addSubview:numberLabel];
            
        }else{
            
            UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW -20- 200, ([UIScreen mainScreen].bounds.size.width- left*2-placeH*(row-1))/row+placeH*2 , 200, 18)];
            if (otherTitles.count == 0) {
                numberLabel.frame = CGRectMake(ScreenW -20- 200, 10, 200, 18);
            }
            numberLabel.text = [NSString stringWithFormat:@"%@人预订・%@个空位",order_seat,left_seat];
            numberLabel.textColor = [FDUtils colorWithHexString:@"#666666"];
            numberLabel.font = [UIFont systemFontOfSize:14];
            numberLabel.textAlignment = NSTextAlignmentRight;
            [btnView addSubview:numberLabel];
            
            
        }

    }
   

//    UIButton *confrimBtn = [[UIButton alloc]initWithFrame:CGRectMake(left, btnView.frame.size.height-80, frame.size.width-left*2, 48)];
//    [confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [confrimBtn setTitleColor:[FDUtils colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//    confrimBtn.titleLabel.font = [UIFont systemFontOfSize:20];
//    confrimBtn.backgroundColor = [FDUtils colorWithHexString:@"#ef263e"];
//    confrimBtn.layer.cornerRadius = 3;
//    confrimBtn.layer.masksToBounds = YES;
//    [confrimBtn addTarget:self action:@selector(selectedNumber) forControlEvents:UIControlEventTouchUpInside];
//    
//    btnView.layer.cornerRadius = 3;
//    btnView.layer.masksToBounds = YES;
//    
//    
//    [self.btnView addSubview:confrimBtn];

    return btnView;
}


///创建button
- (void)setupBtnWithTitle:(NSString *)title tag:(NSInteger)index selected:(NSInteger)selectedIndex{
    NSInteger d = index/_row;
    NSInteger c = index%_row;
    NSInteger x;
    NSInteger y;
    
    NSInteger btnW =([UIScreen mainScreen].bounds.size.width- 15*2-(placeH+5)*(_row-1))/_row;
    if (c == 0) {///3的倍数
        x = 15;
    }else{
        
        x= 15+btnW*c+c*(placeH+5);
        
    }
    y = 10+d*singleH ;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnW
                                                              , btnW)];

    [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:title] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
    btn.layer.cornerRadius = btnW/2;
    btn.layer.masksToBounds= YES;

    btn.selected = NO;
    btn.tag = _tag;
    _tag ++;
    if (btn.tag==selectedIndex) {
        btn.selected = YES;
        self.selectedBtn = btn;
    }
    
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonsArray addObject:btn];
    [self.btnView addSubview:btn];
}


- (void)BtnClick:(UIButton *)btn{
    
    for (UIButton * button in self.buttonsArray) {

        button.selected = NO;
        
    }
    
    btn.selected = YES;
    self.selectedBtn = btn;
    if ([self.delegate respondsToSelector:@selector(buttonsView:clickedButtonAtIndex:sender:title:)]) {
            [self.delegate buttonsView:self.btnView clickedButtonAtIndex:btn.tag sender:btn title:self.titles];
    
        }
    
}
//-(void)selectedNumber{
//    if ([self.delegate respondsToSelector:@selector(buttonsView:clickedButtonAtIndex:sender:title:)]) {
//        [self.delegate buttonsView:self.btnView clickedButtonAtIndex:self.selectedBtn.tag sender:self.selectedBtn title:self.titles];
//    }
//    
//}
@end

