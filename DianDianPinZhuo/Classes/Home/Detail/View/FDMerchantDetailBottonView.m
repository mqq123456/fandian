//
//  FDMerchantDetailBottonView.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantDetailBottonView.h"
#import "HQConst.h"
@interface FDMerchantDetailBottonView ()
/** 已有 */
@property (nonatomic, weak) UILabel *yiyou;
/** 已有人数 */
@property (nonatomic, weak) UILabel *yiyou_people;
/** 人预定 */
@property (nonatomic, weak) UILabel *people_yuding;
/** 剩余 */
@property (nonatomic, weak) UILabel *remaining;
/** 剩余人数 */
@property (nonatomic, weak) UILabel *remaining_people;
/** 个空位 */
@property (nonatomic, weak) UILabel *people_kongwei;
/** 单价 */
@property (nonatomic, weak) UILabel *price;
/** 餐厅距离 */
@property (nonatomic, weak) UILabel *meiren;
@end;

@implementation FDMerchantDetailBottonView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = FDColor(251, 251, 251, 1);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
        line.backgroundColor = FDColor(233, 233, 233, 1);
        [self addSubview:line];
        
        UILabel *price = [[UILabel alloc] init];
        price.textColor = [UIColor redColor];
        price.font = [UIFont systemFontOfSize:21];
        [self addSubview:price];
        self.price = price;
        
        UILabel *meiren = [[UILabel alloc] init];
        meiren.text = @"元/人";
        meiren.font = [UIFont systemFontOfSize:21];
        meiren.textColor = FDColor(51, 51, 51, 1);
        [self addSubview:meiren];
        self.meiren = meiren;
        
        
        /** 已有 */
        UILabel *yiyou = [[UILabel alloc] init];
        yiyou.font = [UIFont systemFontOfSize:14];
        yiyou.textColor = FDColor(153, 153, 153, 1);
        yiyou.text = @"已有";
        [self addSubview:yiyou];
        self.yiyou = yiyou;
        
        /** 已有人数 */
        UILabel *yiyou_people = [[UILabel alloc] init];
        yiyou_people.font = [UIFont systemFontOfSize:14];
        yiyou_people.textColor = FDColor(51, 51, 51, 1);
        
        [self addSubview:yiyou_people];
        self.yiyou_people = yiyou_people;
        
        /** 人预定 */
        UILabel *people_yuding = [[UILabel alloc] init];
        people_yuding.font = [UIFont systemFontOfSize:14];
        people_yuding.text = @"人预定 ";
        people_yuding.textColor = FDColor(153, 153, 153, 1);
        [self addSubview:people_yuding];
        self.people_yuding = people_yuding;
        
        
        /** 剩余 */
        UILabel *remaining = [[UILabel alloc] init];
        remaining.font = [UIFont systemFontOfSize:14];
        remaining.text = @"剩余";
        remaining.textColor = FDColor(153, 153, 153, 1);
        [self addSubview:remaining];
        self.remaining = remaining;
        
        /** 剩余人数 */
        UILabel *remaining_people = [[UILabel alloc] init];
        remaining_people.font = [UIFont systemFontOfSize:14];
        remaining_people.textColor = FDColor(51, 51, 51, 1);
        [self addSubview:remaining_people];
        self.remaining_people = remaining_people;
        
        
        /** 个空位 */
        UILabel *people_kongwei = [[UILabel alloc] init];
        people_kongwei.font = [UIFont systemFontOfSize:14];
        people_kongwei.text = @"个空位";
        people_kongwei.textColor = FDColor(153, 153, 153, 1);
        [self addSubview:people_kongwei];
        self.people_kongwei = people_kongwei;
        
        _orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _orderBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-110, 13, 100, 47);
//        _orderBtn.backgroundColor = FDButtonColor;
        [_orderBtn setTitle:@"我要预订" forState:UIControlStateNormal];
        _orderBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 6, 0);
        [_orderBtn setBackgroundImage:[UIImage imageNamed:@"bow_btn_wyyd_nor"] forState:UIControlStateNormal];
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//        _orderBtn.layer.cornerRadius = 3;
        _orderBtn.clipsToBounds = YES;
        [self addSubview:_orderBtn];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    CGRect priceRect = [self.price_str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]} context:nil];
    _price.frame =  CGRectMake(15, 10, priceRect.size.width, priceRect.size.height);
    
    _meiren.frame = CGRectMake(CGRectGetMaxX(_price.frame), 10, 100, priceRect.size.height);
    
    UIFont *bottonFont = [UIFont systemFontOfSize:14];
    CGFloat bottomH = CGRectGetMaxY(_price.frame);
    CGFloat labelH = 22;
    CGRect  yiyouRect = [@"已有" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou.frame = CGRectMake(15, bottomH, yiyouRect.size.width, labelH);
    /** originalViewF */
    
    CGRect  yiyou_peopleRect = [[NSString stringWithFormat:@"%@",self.yuding_people_str]  boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou_people.frame = CGRectMake(CGRectGetMaxX(_yiyou.frame), bottomH, yiyou_peopleRect.size.width, labelH);
    /** originalViewF */
    
    CGRect  people_yudingRect = [@"人预定 " boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _people_yuding.frame = CGRectMake(CGRectGetMaxX(_yiyou_people.frame), bottomH, people_yudingRect.size.width, labelH);
    if ([self.yuding_people_str intValue]==0) {
        CGRect  people_yudingRect = [@"还没有人预定" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_yuding.frame = CGRectMake(15, bottomH, people_yudingRect.size.width, labelH);
        _yiyou_people.frame  = CGRectMake(0, 0, 0, 0);
        _yiyou.frame = CGRectMake(0, 0, 0, 0);
        self.people_yuding.text = @"还没有人预定";
    }
    /** originalViewF */
    if ([self.kongwei_people_str intValue]>10) {
        _remaining.frame = CGRectMake(0, 0, 0, 0);
        _remaining_people.frame =CGRectMake(0, 0, 0, 0);
        _people_kongwei.frame =CGRectMake(0, 0, 0, 0);
    }else{
        CGRect  remainingRect = [@"剩余" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        _remaining.frame =  CGRectMake(CGRectGetMaxX(_people_yuding.frame), bottomH, remainingRect.size.width, labelH);
        
        /** originalViewF */
        CGRect  remaining_peopleRect = [self.kongwei_people_str boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _remaining_people.frame = CGRectMake(CGRectGetMaxX(_remaining.frame), bottomH, remaining_peopleRect.size.width, labelH);
        CGRect  people_kongweiRect = [@"个空位" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_kongwei.frame = CGRectMake(CGRectGetMaxX(_remaining_people.frame), bottomH, people_kongweiRect.size.width, labelH);
        
    }

    _price.text = self.price_str;
    _yiyou_people.text = self.yuding_people_str;
    _remaining_people.text = self.kongwei_people_str;
    
    
}
-(void)setNeedsDispaly{
    [super setNeedsDisplay];
    CGRect priceRect = [self.price_str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]} context:nil];
    _price.frame =  CGRectMake(15, 10, priceRect.size.width, priceRect.size.height);
    
    _meiren.frame = CGRectMake(CGRectGetMaxX(_price.frame), 10, 100, priceRect.size.height);
    
    UIFont *bottonFont = [UIFont systemFontOfSize:14];
    CGFloat bottomH = CGRectGetMaxY(_price.frame);
    CGFloat labelH = 22;
    CGRect  yiyouRect = [@"已有" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou.frame = CGRectMake(15, bottomH, yiyouRect.size.width, labelH);
    /** originalViewF */
    CGRect  yiyou_peopleRect = [[NSString stringWithFormat:@"%@",self.yuding_people_str]  boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou_people.frame = CGRectMake(CGRectGetMaxX(_yiyou.frame), bottomH, yiyou_peopleRect.size.width, labelH);
    /** originalViewF */
    
    CGRect  people_yudingRect = [@"人预定 " boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _people_yuding.frame = CGRectMake(CGRectGetMaxX(_yiyou_people.frame), bottomH, people_yudingRect.size.width, labelH);
    if ([self.yuding_people_str intValue]==0) {
        CGRect  people_yudingRect = [@"还没有人预定" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_yuding.frame = CGRectMake(15, bottomH, people_yudingRect.size.width, labelH);
        _yiyou_people.frame  = CGRectMake(0, 0, 0, 0);
        _yiyou.frame = CGRectMake(0, 0, 0, 0);
        self.people_yuding.text = @"还没有人预定";
    }
    /** originalViewF */
    if ([self.kongwei_people_str intValue]>10) {
        _remaining.frame = CGRectMake(0, 0, 0, 0);
        _remaining_people.frame =CGRectMake(0, 0, 0, 0);
        _people_kongwei.frame =CGRectMake(0, 0, 0, 0);
    }else{
        CGRect  remainingRect = [@"剩余" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        _remaining.frame =  CGRectMake(CGRectGetMaxX(_people_yuding.frame), bottomH, remainingRect.size.width, labelH);
        
        /** originalViewF */
        CGRect  remaining_peopleRect = [self.kongwei_people_str boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _remaining_people.frame = CGRectMake(CGRectGetMaxX(_remaining.frame), bottomH, remaining_peopleRect.size.width, labelH);
        CGRect  people_kongweiRect = [@"个空位" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_kongwei.frame = CGRectMake(CGRectGetMaxX(_remaining_people.frame), bottomH, people_kongweiRect.size.width, labelH);
        
    }

    _price.text = self.price_str;
    _yiyou_people.text = self.yuding_people_str;
    _remaining_people.text = self.kongwei_people_str;
    
}
- (void)drawRect:(CGRect)rect
{
    CGRect priceRect = [self.price_str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]} context:nil];
    _price.frame =  CGRectMake(15, 10, priceRect.size.width, priceRect.size.height);
    
    _meiren.frame = CGRectMake(CGRectGetMaxX(_price.frame), 10, 100, priceRect.size.height);
    
    UIFont *bottonFont = [UIFont systemFontOfSize:14];
    CGFloat bottomH = CGRectGetMaxY(_price.frame);
    CGFloat labelH = 22;
    CGRect  yiyouRect = [@"已有" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou.frame = CGRectMake(15, bottomH, yiyouRect.size.width, labelH);
    /** originalViewF */
    CGRect  yiyou_peopleRect = [[NSString stringWithFormat:@"%@",self.yuding_people_str]  boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _yiyou_people.frame = CGRectMake(CGRectGetMaxX(_yiyou.frame), bottomH, yiyou_peopleRect.size.width, labelH);
    /** originalViewF */
    
    CGRect  people_yudingRect = [@"人预定 " boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
    _people_yuding.frame = CGRectMake(CGRectGetMaxX(_yiyou_people.frame), bottomH, people_yudingRect.size.width, labelH);
    if ([self.yuding_people_str intValue]==0) {
        
        CGRect  people_yudingRect = [@"还没有人预定" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_yuding.frame = CGRectMake(15, bottomH, people_yudingRect.size.width, labelH);
        _yiyou_people.frame  = CGRectMake(0, 0, 0, 0);
        _yiyou.frame = CGRectMake(0, 0, 0, 0);
        self.people_yuding.text = @"还没有人预定";
    }else{
        self.people_yuding.text = @"人预定 ";
    }
    /** originalViewF */
    if ([self.kongwei_people_str intValue]>10) {
        _remaining.frame = CGRectMake(0, 0, 0, 0);
        _remaining_people.frame =CGRectMake(0, 0, 0, 0);
        _people_kongwei.frame =CGRectMake(0, 0, 0, 0);
    }else{
        CGRect  remainingRect = [@"剩余" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        _remaining.frame =  CGRectMake(CGRectGetMaxX(_people_yuding.frame), bottomH, remainingRect.size.width, labelH);
        
        /** originalViewF */
        CGRect  remaining_peopleRect = [self.kongwei_people_str boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _remaining_people.frame = CGRectMake(CGRectGetMaxX(_remaining.frame), bottomH, remaining_peopleRect.size.width, labelH);
        CGRect  people_kongweiRect = [@"个空位" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        _people_kongwei.frame = CGRectMake(CGRectGetMaxX(_remaining_people.frame), bottomH, people_kongweiRect.size.width, labelH);

    }
    _price.text = self.price_str;
    _yiyou_people.text = self.yuding_people_str;
    _remaining_people.text = self.kongwei_people_str;
    
    
}
@end
