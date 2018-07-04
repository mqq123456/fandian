//
//  FDOrderListCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDOrderListCell.h"
#import "UIView+Extension.h"
#import "HQConst.h"
#import "FDOrderListFrame.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"
#import "FDUtils.h"

@interface FDOrderListCell ()
/**	时间 */
@property (nonatomic, weak) UILabel *time;
/**	状态 */
@property (nonatomic, weak) UILabel *state;
/**  */
@property (nonatomic, weak) UIView *content_view;
/**	头像 */
@property (nonatomic, weak) UIImageView *icon;
/** 餐厅名称 */
@property (nonatomic, weak) UILabel *merchant_name;
/** 就餐人数 */
@property (nonatomic, weak) UILabel *people_num;


@property (nonatomic, weak) UIView *gap_view;
@end

@implementation FDOrderListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDOrderListCell";
    FDOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化动态
        [self setupOriginal];
    }
    return self;
}
/**
 * 初始化动态
 */
- (void)setupOriginal
{
    UIView *gap_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    gap_view.backgroundColor = [FDUtils colorWithHexString:@"#f2f2f2"];
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
    /** time */
    UILabel *time = [[UILabel alloc] init];
    time.textColor = [FDUtils colorWithHexString:@"#666666"];
    time.font = time_font;
    [self.contentView addSubview:time];
    self.time = time;
    
    /** state */
    UILabel *state = [[UILabel alloc] init];
    state.textColor = [UIColor colorWithRed:239.0/255.0 green:40.0/255.0 blue:64.0/255.0 alpha:1];
    state.font = state_font;
    state.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:state];
    self.state = state;
    
    UIView *content_view = [[UIView alloc] init];
    content_view.backgroundColor = [FDUtils colorWithHexString:@"#f9f9f9"];
    [self.contentView addSubview:content_view];
    self.content_view = content_view;
    
    /** 用户头像 */
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 3;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    icon.userInteractionEnabled = NO;
    [content_view addSubview:icon];
    self.icon = icon;

    
    /** 用户详情 */
    UILabel *merchant_name = [[UILabel alloc] init];
    merchant_name.textColor = [FDUtils colorWithHexString:@"#222222"];
    merchant_name.font = merchant_name_font;
    [content_view addSubview:merchant_name];
    self.merchant_name = merchant_name;
    
    
    
    /** 餐厅距离 */
    UILabel *people_num = [[UILabel alloc] init];
    people_num.font = people_num_font;
    people_num.textColor = [FDUtils colorWithHexString:@"#666666"];
    [content_view addSubview:people_num];
    self.people_num = people_num;
    
    /** 距离图  */
    UIButton *only_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    only_btn.layer.cornerRadius = 3;
    only_btn.clipsToBounds = YES;
    [only_btn setTitleColor:[FDUtils colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    only_btn.layer.borderColor = [FDUtils colorWithHexString:@"#999999"].CGColor;
    only_btn.titleLabel.font = btn_font;
    only_btn.layer.borderWidth = 0.5;
    [self.contentView addSubview:only_btn];
    self.only_btn = only_btn;
    
    
    /** 年龄和性别标签 */
    UIButton *again_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    again_btn.layer.cornerRadius = 3;
    again_btn.clipsToBounds = YES;
    [again_btn setTitleColor:[FDUtils colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    again_btn.layer.borderColor =[FDUtils colorWithHexString:@"#999999"].CGColor;
    again_btn.titleLabel.font = btn_font;
    again_btn.layer.borderWidth = 0.5;
    [self.contentView addSubview:again_btn];
    self.again_btn = again_btn;
    
    
}

- (void)setStatusFrame:(FDOrderListFrame *)statusFrame
{
    _statusFrame = statusFrame;
    _statusFrame.status = statusFrame.status;
    [self setupFrame];
    OrderModel *statusM = statusFrame.status;
    
    if ([statusM.icon hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//48*3
            img = [NSString stringWithFormat:@"%@@144w",statusM.icon];
        }else{
            img = [NSString stringWithFormat:@"%@@96w",statusM.icon];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }
    
    
    self.merchant_name.text = statusM.merchant_name;
    
    self.time.text = [NSString stringWithFormat:@"就餐时间 %@ %@",statusM.order_date,statusM.meal_time];
    
    self.people_num.text = [NSString stringWithFormat:@"%@  |  %@元",statusM.meal_desc,statusM.paid];
    
    
    //订单状态：-2用户取消-1超时取消0已提交1支付成功2已完成
    self.state.text = [NSString stringWithFormat:@"%@",statusM.state_desc];
    
    if (statusM.state ==2) {
        self.only_btn.hidden = NO;
        self.again_btn.hidden= NO;
        [self.only_btn setTitle:@"评价送积分" forState:UIControlStateNormal];
        [self.again_btn setTitle:@"再吃一次" forState:UIControlStateNormal];
    }else if (statusM.state==1){
        self.only_btn.hidden = NO;
        [self.only_btn setTitle:@"退款" forState:UIControlStateNormal];
    }else if (statusM.state==0){
        self.only_btn.hidden = NO;
        [self.only_btn setTitle:@"去支付" forState:UIControlStateNormal];
    }else if (statusM.state==3){
        self.only_btn.hidden = NO;
        self.again_btn.hidden= NO;
        [self.only_btn setTitle:@"发红包" forState:UIControlStateNormal];
        [self.again_btn setTitle:@"再吃一次" forState:UIControlStateNormal];
    }else{
        self.only_btn.hidden = YES;
        self.again_btn.hidden= YES;
    }
    if (statusM.state<0) {
        self.userInteractionEnabled = NO;
    }else{
        self.userInteractionEnabled = YES;
    }
    
    
}

- (void)setupFrame{
    self.time.frame = self.statusFrame.timeF;
    self.state.frame = self.statusFrame.stateF;
    self.content_view.frame = self.statusFrame.content_viewF;
    self.icon.frame = self.statusFrame.iconF;
    self.merchant_name.frame = self.statusFrame.merchant_nameF;
    self.people_num.frame = self.statusFrame.people_numF;
    self.only_btn.frame = self.statusFrame.only_btnF;
    self.again_btn.frame = self.statusFrame.again_btnF;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
