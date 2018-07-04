//
//  FDNearMerchantCell.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNearMerchantCell.h"
#import "UIView+Extension.h"
#import "LDXScore.h"
#import "HQConst.h"
#import "FDNearMerchantFrame.h"
#import "MerchantModel.h"
#import "UIImageView+WebCache.h"
#import "HQDefaultTool.h"
#import "FDUtils.h"
#import "SeatMealArrModel.h"
#import "FDTopicMerchantListFram.h"

@interface FDNearMerchantCell ()
/** 图片 */
@property (nonatomic, weak) UIImageView *big_image;
/** 新上 */
@property (nonatomic, weak) UIImageView *image_new;
/** 描述，半透明 */
@property (nonatomic, weak) UIView *describe_view;
/** 描述文字 */
@property (nonatomic, weak) UILabel *describe_Label;
/** 几人桌 */
@property (nonatomic, weak) UIButton *table_num_count;
/** logo图 */
@property (nonatomic, weak) UIImageView *icon;
/** 餐厅名称 */
@property (nonatomic, weak) UILabel *merchant_name;
/** 特色 */
@property (nonatomic, weak) UILabel *food;
/** 分割线 */
@property (nonatomic, weak) UIView *line;
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
@property (nonatomic, weak) UILabel *distance;
/** 距离图  */
@property (nonatomic, weak) UIImageView *distance_image;
/** 热门 */
@property (nonatomic, weak) UIImageView *hot;

/** 餐厅订满 */
@property (nonatomic, weak) UIImageView *dingmanImage;
/** 每人 */
@property (nonatomic, weak) UILabel *meiren;
/** 底部view */
@property (nonatomic, weak) UIView *bottonView;
/** 底部view */
@property (nonatomic, weak) UILabel *xian_baozhuo;
/** 底部view */
@property (nonatomic, weak) UIView *gap_view;

/** 套餐view */
@property (nonatomic, weak) UIView *taocan_view;
/** 图1  */
@property (nonatomic, weak) UIImageView *bao_image1;
/** 图2 */
@property (nonatomic, weak) UIImageView *bao_image2;
/** 新1  */
@property (nonatomic, weak) UIImageView *xin_image1;
/** 新2 */
@property (nonatomic, weak) UIImageView *xin_image2;
/** 套餐1 */
@property (nonatomic, weak) UILabel *taocan_label1;
/** 套餐2 */
@property (nonatomic, weak) UILabel *taocan_label2;
/** 套餐1 */
@property (nonatomic, weak) UILabel *original_price1;
/** 套餐2 */
@property (nonatomic, weak) UILabel *original_price2;

/** 星级 */
@property (nonatomic, weak) LDXScore *star;
@end

@implementation FDNearMerchantCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FDNearMerchantCell";
    FDNearMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FDNearMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    /** 顶部view */
    UIView *gap_view = [[UIView alloc] init];
    gap_view.backgroundColor = Background_Color;
    [self.contentView addSubview:gap_view];
    self.gap_view = gap_view;
    
   
    
    /** 图片 */
    UIImageView *big_image = [[UIImageView alloc] init];
    [self.contentView addSubview:big_image];
//    big_image.contentMode = UIViewContentModeScaleAspectFill;
    big_image.layer.cornerRadius = 1;
    big_image.clipsToBounds = YES;
    self.big_image = big_image;

   
    /** 描述，半透明 */
    UIView *describe_view = [[UIView alloc] init];
    describe_view.backgroundColor = FDColor(0, 0, 0, 0.3);
    describe_view.layer.cornerRadius = 1;
    describe_view.clipsToBounds = YES;
    [self.contentView addSubview:describe_view];
    self.describe_view = describe_view;
    
    /** 描述文字 */
    UILabel *describe_Label = [[UILabel alloc] init];
    describe_Label.textColor = [UIColor whiteColor];
    describe_Label.font = describe_LabelFont;
    [describe_view addSubview:describe_Label];
    self.describe_Label = describe_Label;
    
    LDXScore *star = [[LDXScore alloc] init];
    [self.contentView addSubview:star];
    star.normalImg = [UIImage imageNamed:@"star_nor"];
    star.highlightImg = [UIImage imageNamed:@"star_sel"];
    self.star = star;
    
//    /** 几人桌 */
//    UIButton * table_num_count = [UIButton buttonWithType:UIButtonTypeCustom];
//    table_num_count.userInteractionEnabled = NO;
//    table_num_count.backgroundColor = FDColor(0, 0, 0 ,0.5);
//    table_num_count.layer.cornerRadius = 10;
//    table_num_count.clipsToBounds = YES;
//    [table_num_count setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    table_num_count.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
//    [table_num_count setImage:[UIImage imageNamed:@"baw_img_bqyuan_nor"] forState:UIControlStateNormal];
//    table_num_count.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
//    table_num_count.titleLabel.font = table_num_countFont;
//    [self.contentView addSubview:table_num_count];
//    self.table_num_count  = table_num_count;
//    
    /** 头像 */
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 1;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    [self.contentView addSubview:icon];
    self.icon = icon;
    
    /** 餐厅名称 */
    UILabel *merchant_name = [[UILabel alloc] init];
    merchant_name.textColor = FDColor(51, 51, 51 ,1);
    merchant_name.font = merchant_nameFont;
    [self.contentView addSubview:merchant_name];
    self.merchant_name = merchant_name;
    
    /** 免费图  */
    UIImageView *new_image = [[UIImageView alloc] init];
    new_image.image = [UIImage imageNamed:@"ba_img_new_nor"];
    new_image.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:new_image];
    self.image_new = new_image;
    
 
    
    /** 特色 */
    UILabel *food = [[UILabel alloc] init];
    food.font = foodFont;
    food.textColor = FDColor(102, 102, 102, 1);
    [self.contentView addSubview:food];
    self.food = food;
    
    /** 底部view */
    UIView *bottonView = [[UIView alloc] init];
    bottonView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottonView];
    self.bottonView = bottonView;
    
    /** 分割线 */
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [FDUtils colorWithHexString:@"#dedede"];
    [bottonView addSubview:line];
    self.line = line;
    
    /** 已有 */
    UILabel *yiyou = [[UILabel alloc] init];
    yiyou.font = bottonFont;
    yiyou.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:yiyou];
    self.yiyou = yiyou;
    
    /** 已有人数 */
    UILabel *yiyou_people = [[UILabel alloc] init];
    yiyou_people.font = bottonFont;
    yiyou_people.textColor = FDColor(51, 51, 51, 1);
    [bottonView addSubview:yiyou_people];
    self.yiyou_people = yiyou_people;
    
    /** 人预定 */
    UILabel *people_yuding = [[UILabel alloc] init];
    people_yuding.font = bottonFont;
    people_yuding.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:people_yuding];
    self.people_yuding = people_yuding;
    
    /** 剩余 */
    UILabel *remaining = [[UILabel alloc] init];
    remaining.font = bottonFont;
    remaining.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:remaining];
    self.remaining = remaining;
    
    /** 剩余人数 */
    UILabel *remaining_people = [[UILabel alloc] init];
    remaining_people.font = bottonFont;
    remaining_people.textColor = FDColor(51, 51, 51, 1);
    [bottonView addSubview:remaining_people];
    self.remaining_people = remaining_people;
    
    /** 个空位 */
    UILabel *people_kongwei = [[UILabel alloc] init];
    people_kongwei.font = bottonFont;
    people_kongwei.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:people_kongwei];
    self.people_kongwei = people_kongwei;
    
    
    /** 已有人数 */
    UILabel *xian_baozhuo = [[UILabel alloc] init];
    xian_baozhuo.font = bottonFont;
    xian_baozhuo.textColor = [UIColor whiteColor];
    xian_baozhuo.backgroundColor = [FDUtils colorWithHexString:@"#f0355c"];
    xian_baozhuo.layer.cornerRadius = 10;
    xian_baozhuo.textAlignment = NSTextAlignmentCenter;
    xian_baozhuo.clipsToBounds = YES;
    [bottonView addSubview:xian_baozhuo];
    self.xian_baozhuo = xian_baozhuo;
    
    /** 单价 */
    UILabel *price = [[UILabel alloc] init];
    price.font = [UIFont systemFontOfSize:18];
    price.textColor = FDColor(51, 51, 51, 1);
    price.hidden = YES;
    [bottonView addSubview:price];
    self.price = price;
    
    
    
    /** 每人 */
    UILabel *meiren = [[UILabel alloc] init];
    meiren.font = priceFont;
    meiren.textColor = FDColor(51, 51, 51, 1);
    meiren.hidden = YES;
    [bottonView addSubview:meiren];
    self.meiren = meiren;
    
    
    /** 餐厅距离 */
    UILabel *distance = [[UILabel alloc] init];
    distance.font = distanceFont;
    distance.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:distance];
    self.distance = distance;
    
    /** 距离图  */
    UIImageView *distance_image = [[UIImageView alloc] init];
    distance_image.image = [UIImage imageNamed:@"baw_icon_dingweixiao_nor"];
    distance_image.contentMode = UIViewContentModeScaleAspectFill;
    [bottonView addSubview:distance_image];
    self.distance_image = distance_image;
    
    
    

    /** 热门 */
    UIImageView *hot = [[UIImageView alloc] init];
    hot.image = [UIImage imageNamed:@"list_ico_hot_nor"];
    hot.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:hot];
    self.hot = hot;
    

    /** 订满 */
    UIImageView *dingmanImage = [[UIImageView alloc] init];
    dingmanImage.image = [UIImage imageNamed:@"baw_img_yidingman"];
    dingmanImage.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:dingmanImage];
    self.dingmanImage = dingmanImage;
    
    
    
    
    /** 套餐view */
    UIView *taocan_view = [[UIView alloc] init];
    taocan_view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:taocan_view];
    self.taocan_view = taocan_view;
    
    /** 距离图  */
    UIImageView *bao_image1 = [[UIImageView alloc] init];
//    bao_image1.image = [UIImage imageNamed:@"bow_ico_taocanbiaoqian"];
    bao_image1.backgroundColor = FDColor(153, 153, 153, 1);
    [taocan_view addSubview:bao_image1];
    self.bao_image1 = bao_image1;

    /** 热门 */
    UIImageView *bao_image2 = [[UIImageView alloc] init];
//    bao_image2.image = [UIImage imageNamed:@"bow_ico_taocanbiaoqian"];
    bao_image2.backgroundColor = FDColor(153, 153, 153, 1);
    [taocan_view addSubview:bao_image2];
    self.bao_image2 = bao_image2;
    
    
    /** 订满 */
    UIImageView *xin_image1 = [[UIImageView alloc] init];
    xin_image1.image = [UIImage imageNamed:@"baw_ico_xincaidan_nor"];
    [taocan_view addSubview:xin_image1];
    self.xin_image1 = xin_image1;
    
    /** 订满 */
    UIImageView *xin_image2 = [[UIImageView alloc] init];
    xin_image2.image = [UIImage imageNamed:@"baw_ico_xincaidan_nor"];
    [taocan_view addSubview:xin_image2];
    self.xin_image2 = xin_image2;
    
    /** 剩余 */
    UILabel *taocan_label2 = [[UILabel alloc] init];
    taocan_label2.font = taocan_label_font;
    taocan_label2.textColor = [FDUtils colorWithHexString:@"#666666"];
    [taocan_view addSubview:taocan_label2];
    self.taocan_label2 = taocan_label2;
    
    /** 剩余人数 */
    UILabel *taocan_label1 = [[UILabel alloc] init];
    taocan_label1.font = taocan_label_font;
    taocan_label1.textColor = [FDUtils colorWithHexString:@"#666666"];
    [taocan_view addSubview:taocan_label1];
    self.taocan_label1 = taocan_label1;
    
    /** 剩余 */
    UILabel *original_price1 = [[UILabel alloc] init];
    original_price1.font = original_price_font;
    original_price1.textColor = FDColor(153, 153, 153, 1);
    [taocan_view addSubview:original_price1];
    self.original_price1 = original_price1;
    
    /** 剩余人数 */
    UILabel *original_price2 = [[UILabel alloc] init];
    original_price2.font = original_price_font;
    original_price2.textColor = FDColor(153, 153, 153, 1);
    [taocan_view addSubview:original_price2];
    self.original_price2 = original_price2;

    
}

- (void)setStatusFrame:(FDNearMerchantFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupFrame];
    
    [self setMessage];
    
    
}
- (void)setTopic_statusFrame:(FDTopicMerchantListFram *)topic_statusFrame{

    _topic_statusFrame = topic_statusFrame;
    
    self.price.hidden = NO;
    
    self.meiren.hidden = NO;
    
    self.yiyou.hidden = YES;
    
    self.yiyou_people.hidden = YES;
    
    self.people_yuding.hidden = YES;
    
    self.people_kongwei.hidden = YES;
    
    self.remaining.hidden = YES;
    
    self.remaining_people.hidden = YES;
    
    self.xian_baozhuo.hidden = YES;
    
    [self setuptopic_statusFrame];
    
    [self settopic_statusMessage];
    
    

}

- (void)settopic_statusMessage{
    MerchantModel *statusM = self.topic_statusFrame.status;
    /** 图片 */
    [self.big_image sd_setImageWithURL:[NSURL URLWithString:statusM.img] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.big_image.image = image;
    }];
    /** 描述文字 */
    self.describe_Label.text = statusM.description_desc;
    
    
//    /** logo图 */
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
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

    /** 餐厅名称 */
    self.merchant_name.text = statusM.merchant_name;
    /** 特色 */
    self.food.text = statusM.dishes;
    
    /** 已有人数 */
    self.yiyou_people.text = [NSString stringWithFormat:@"%@",statusM.order_seat];
    self.people_yuding.text = @"人预定";
    
    if ([statusM.sold_out intValue]==1) {
        self.yiyou.text = @"已订满";
    }else{
        if ([statusM.order_seat intValue]==0) {
            self.yiyou.text = @"已有";
            self.yiyou_people.text = [NSString stringWithFormat:@"%d",statusM.tastes];
            self.people_yuding.text = @"人品尝";
        }else{
            self.yiyou.text = @"";
        }
        
    }
    
    
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        
        if ([statusM.only_pz intValue]==1) {
            self.xian_baozhuo.text = @"仅供拼桌";
            self.xian_baozhuo.hidden = NO;
        }else if ([statusM.only_bz intValue]==1){
            self.xian_baozhuo.text = @"仅供包桌";
            self.xian_baozhuo.hidden = NO;
        }else{
            self.xian_baozhuo.hidden = YES;
        }
        
    }else{
        if ([statusM.tablemate intValue]==0||[statusM.order_seat intValue]==0) {
            self.remaining.text = @"";
            self.remaining_people.text = @"";
            self.people_kongwei.text = @"";
        }else{
            self.remaining.text = @"";
            /** 剩余 */
            self.remaining_people.text = [NSString stringWithFormat:@"%@",statusM.tablemate];
            self.people_kongwei.text = @"人曾同桌";
            
        }
        if ([statusM.only_pz intValue]==1) {
            self.xian_baozhuo.text = @"仅供拼桌";
            self.xian_baozhuo.hidden = NO;
        }else if ([statusM.only_bz intValue]==1){
            self.xian_baozhuo.text = @"仅供包桌";
            self.xian_baozhuo.hidden = NO;
        }else{
            self.xian_baozhuo.hidden = YES;
        }
        
    }
    
    
    
    
    /** 距离 */
    self.distance.text = [NSString stringWithFormat:@"距离你约%@",statusM.distance];
    
    /** 价格 */
    self.price.text = [NSString stringWithFormat:@"%@",statusM.price];
    
    [self.table_num_count setTitle:statusM.table_desc forState:UIControlStateNormal];
    
    
    /** 每人 */
    self.meiren.text = @"元/人";
    
    if ([statusM.sold_out intValue]==1) {//是否售完
        self.dingmanImage.hidden = NO;
        self.describe_Label.text = @"";
    }else{
        self.dingmanImage.hidden = YES;
        self.describe_Label.text = statusM.description_desc;
    }
    
    if ([statusM.isNew intValue]==1) {//是否新上线
        self.image_new.hidden = NO;
    }else{
        self.image_new.hidden = YES;
    }
    if ([statusM.hot intValue]==1) {//是否热门
        self.hot.hidden = NO;
    }else{
        self.hot.hidden = YES;
    }
    
    
    if (statusM.set_meal_arr.count==1) {
        self.taocan_label2.hidden = YES;
        self.taocan_label1.hidden = NO;
        self.bao_image1.hidden = NO;
        self.bao_image2.hidden = YES;
        self.xin_image2.hidden = YES;
        SeatMealArrModel *seat = statusM.set_meal_arr[0];
        NSAttributedString * content  = seat.price_people_num_desc;
        [self.taocan_label1 setAttributedText:content];
        if ([seat.menu_is_new intValue]==1) {
            self.xin_image1.hidden = NO;
        }else{
            self.xin_image1.hidden = YES;
        }
    }else{
        if (statusM.set_meal_arr.count>=2) {
            self.taocan_label2.hidden = NO;
            self.taocan_label1.hidden = NO;
            self.bao_image1.hidden = NO;
            self.bao_image2.hidden = NO;
            SeatMealArrModel *seat = statusM.set_meal_arr[0];
            NSAttributedString * content  = seat.price_people_num_desc;
            [self.taocan_label1 setAttributedText:content];
            if ([seat.menu_is_new intValue]==1) {
                self.xin_image1.hidden = NO;
            }else{
                self.xin_image1.hidden = YES;
            }
            
            SeatMealArrModel *seat1 = statusM.set_meal_arr[1];
            NSAttributedString * content1  = seat1.price_people_num_desc;
            [self.taocan_label2 setAttributedText:content1];
            if ([seat1.menu_is_new intValue]==1) {
                self.xin_image2.hidden = NO;
            }else{
                self.xin_image2.hidden = YES;
            }
        }else{
            self.taocan_label2.hidden = YES;
            self.taocan_label1.hidden = YES;
            self.xin_image1.hidden = YES;
            self.xin_image2.hidden = YES;
            self.bao_image1.hidden = YES;
            self.bao_image2.hidden = YES;
        }
    }
    
    
    self.star.show_star = [statusM.star floatValue];

}
- (void)setMessage{
    
    MerchantModel *statusM = self.statusFrame.status;
    /** 图片 */
    [self.big_image sd_setImageWithURL:[NSURL URLWithString:statusM.img] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.big_image.image = image;
    }];
    /** 描述文字 */
    self.describe_Label.text = statusM.description_desc;
    
    
    /** logo图 */
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
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

    /** 餐厅名称 */
    self.merchant_name.text = statusM.merchant_name;
    /** 特色 */
    self.food.text = statusM.dishes;
    
    /** 已有人数 */
    self.yiyou_people.text = [NSString stringWithFormat:@"%@",statusM.order_seat];
    self.people_yuding.text = @"人预定";
    
    if ([statusM.sold_out intValue]==1) {
        self.yiyou.text = @"已订满";
    }else{
        if ([statusM.order_seat intValue]==0) {
            self.yiyou.text = @"已有";
            self.yiyou_people.text = [NSString stringWithFormat:@"%d",statusM.tastes];
            self.people_yuding.text = @"人品尝";
        }else{
            self.yiyou.text = @"";
        }
        
    }
    
    
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]) {
        
        if ([statusM.only_pz intValue]==1) {
            self.xian_baozhuo.text = @"仅供拼桌";
            self.xian_baozhuo.hidden = NO;
        }else if ([statusM.only_bz intValue]==1){
            self.xian_baozhuo.text = @"仅供包桌";
            self.xian_baozhuo.hidden = NO;
        }else{
            self.xian_baozhuo.hidden = YES;
        }
        
    }else{
        if ([statusM.tablemate intValue]==0||[statusM.order_seat intValue]==0) {
            self.remaining.text = @"";
            self.remaining_people.text = @"";
            self.people_kongwei.text = @"";
        }else{
            self.remaining.text = @"";
            /** 剩余 */
            self.remaining_people.text = [NSString stringWithFormat:@"%@",statusM.tablemate];
            self.people_kongwei.text = @"人曾同桌";
            
        }
        if ([statusM.only_pz intValue]==1) {
            self.xian_baozhuo.text = @"仅供拼桌";
            self.xian_baozhuo.hidden = NO;
        }else if ([statusM.only_bz intValue]==1){
            self.xian_baozhuo.text = @"仅供包桌";
            self.xian_baozhuo.hidden = NO;
        }else{
            self.xian_baozhuo.hidden = YES;
        }
        
    }
    
    
    
    
    /** 距离 */
    self.distance.text = [NSString stringWithFormat:@"距离你约%@",statusM.distance];
    
    /** 价格 */
    self.price.text = [NSString stringWithFormat:@"%@",statusM.price];
    
    [self.table_num_count setTitle:statusM.table_desc forState:UIControlStateNormal];
    
    
    /** 每人 */
    self.meiren.text = @"元/人";
    
    if ([statusM.sold_out intValue]==1) {//是否售完
        self.dingmanImage.hidden = NO;
        self.describe_Label.text = @"";
    }else{
        self.dingmanImage.hidden = YES;
        self.describe_Label.text = statusM.description_desc;
    }
    
    if ([statusM.isNew intValue]==1) {//是否新上线
        self.image_new.hidden = NO;
    }else{
        self.image_new.hidden = YES;
    }
    if ([statusM.hot intValue]==1) {//是否热门
        self.hot.hidden = NO;
    }else{
        self.hot.hidden = YES;
    }
    
    
    if (statusM.set_meal_arr.count==1) {
        self.taocan_label2.hidden = YES;
        self.taocan_label1.hidden = NO;
        self.bao_image1.hidden = NO;
        //self.original_price1.hidden = NO;
        self.bao_image2.hidden = YES;
        self.xin_image2.hidden = YES;
        //self.original_price2.hidden = YES;
        SeatMealArrModel *seat = statusM.set_meal_arr[0];
        NSAttributedString * content  = seat.price_people_num_desc;
        [self.taocan_label1 setAttributedText:content];
        if ([seat.menu_is_new intValue]==1) {
            self.xin_image1.hidden = NO;
        }else{
            self.xin_image1.hidden = YES;
        }
        self.original_price1.text = seat.original_price;
    }else{
        if (statusM.set_meal_arr.count>=2) {
            self.taocan_label2.hidden = NO;
            self.taocan_label1.hidden = NO;
            self.bao_image1.hidden = NO;
            self.bao_image2.hidden = NO;
//            self.original_price1.hidden = NO;
//            self.original_price2.hidden = NO;
            SeatMealArrModel *seat = statusM.set_meal_arr[0];
            NSAttributedString * content  = seat.price_people_num_desc;
            [self.taocan_label1 setAttributedText:content];
            if ([seat.menu_is_new intValue]==1) {
                self.xin_image1.hidden = NO;
            }else{
                self.xin_image1.hidden = YES;
            }
            self.original_price1.text = seat.original_price;
            
            SeatMealArrModel *seat1 = statusM.set_meal_arr[1];
            NSAttributedString * content1  = seat1.price_people_num_desc;
            [self.taocan_label2 setAttributedText:content1];
            if ([seat1.menu_is_new intValue]==1) {
                self.xin_image2.hidden = NO;
            }else{
                self.xin_image2.hidden = YES;
            }
            self.original_price2.text = seat1.original_price;
        }else{
            self.taocan_label2.hidden = YES;
            self.taocan_label1.hidden = YES;
            self.xin_image1.hidden = YES;
            self.xin_image2.hidden = YES;
            self.bao_image1.hidden = YES;
            self.bao_image2.hidden = YES;
//            self.original_price1.hidden = YES;
//            self.original_price2.hidden = YES;
        }
    }
    
    
    self.original_price1.text = @"150元";
    
    self.original_price2.text = @"250元";
    
    
    
    
    self.star.show_star = [statusM.star floatValue];
    

}
- (void)setupFrame{
    self.big_image.frame = _statusFrame.big_imageF;
    self.image_new.frame = _statusFrame.image_newF;
    self.describe_view.frame = _statusFrame.describe_viewF;
    self.describe_Label.frame = _statusFrame.describe_LabelF;
    self.table_num_count.frame = _statusFrame.table_num_countF;
    self.icon.frame = _statusFrame.iconF;
    self.merchant_name.frame = _statusFrame.merchant_nameF;
    self.food.frame = _statusFrame.foodF;
    self.yiyou.frame = _statusFrame.yiyouF;
    self.yiyou_people.frame = _statusFrame.yiyou_peopleF;
    self.people_yuding.frame = _statusFrame.people_yudingF;
    self.remaining.frame = _statusFrame.remainingF;
    self.remaining_people.frame = _statusFrame.remaining_peopleF;
    self.people_kongwei.frame = _statusFrame.people_kongweiF;
    self.price.frame = _statusFrame.priceF;
    self.distance.frame = _statusFrame.distanceF;
    self.distance_image.frame = _statusFrame.distance_imageF;
    self.hot.frame = _statusFrame.hotF;
    self.dingmanImage.frame = _statusFrame.dingmanImageF;
    self.meiren.frame = _statusFrame.meirenF;
    self.bottonView.frame = _statusFrame.bottonViewF;
    self.line.frame = _statusFrame.lineF;
    self.gap_view.frame = _statusFrame.gap_viewF;
    self.xian_baozhuo.frame = _statusFrame.xian_baozhuoF;
    
    self.taocan_view.frame = _statusFrame.taocan_viewF;
    self.bao_image1.frame = _statusFrame.bao_image1F;
    self.bao_image2.frame = _statusFrame.bao_image2F;
    self.taocan_label1.frame = _statusFrame.taocan_label1F;
    self.taocan_label2.frame = _statusFrame.taocan_label2F;
    self.xin_image1.frame = _statusFrame.xin_image1F;
    self.xin_image2.frame = _statusFrame.xin_image2F;
    self.star.frame = _statusFrame.starF;
    self.original_price1.frame = _statusFrame.original_price1F;
    self.original_price2.frame = _statusFrame.original_price2F;
    
}
- (void)setuptopic_statusFrame{

    self.big_image.frame = _topic_statusFrame.big_imageF;
    self.image_new.frame = _topic_statusFrame.image_newF;
    self.describe_view.frame = _topic_statusFrame.describe_viewF;
    self.describe_Label.frame = _topic_statusFrame.describe_LabelF;
    self.table_num_count.frame = _topic_statusFrame.table_num_countF;
    self.icon.frame = _topic_statusFrame.iconF;
    self.merchant_name.frame = _topic_statusFrame.merchant_nameF;
    self.food.frame = _topic_statusFrame.foodF;
    self.yiyou.frame = _topic_statusFrame.yiyouF;
    self.yiyou_people.frame = _topic_statusFrame.yiyou_peopleF;
    self.people_yuding.frame = _topic_statusFrame.people_yudingF;
    self.remaining.frame = _topic_statusFrame.remainingF;
    self.remaining_people.frame = _topic_statusFrame.remaining_peopleF;
    self.people_kongwei.frame = _topic_statusFrame.people_kongweiF;
    self.price.frame = _topic_statusFrame.priceF;
    self.distance.frame = _topic_statusFrame.distanceF;
    self.distance_image.frame = _topic_statusFrame.distance_imageF;
    self.hot.frame = _topic_statusFrame.hotF;
    self.dingmanImage.frame = _topic_statusFrame.dingmanImageF;
    self.meiren.frame = _topic_statusFrame.meirenF;
    self.bottonView.frame = _topic_statusFrame.bottonViewF;
    self.line.frame = _topic_statusFrame.lineF;
    self.gap_view.frame = _topic_statusFrame.gap_viewF;
    self.xian_baozhuo.frame = _topic_statusFrame.xian_baozhuoF;
    
    self.taocan_view.frame = _topic_statusFrame.taocan_viewF;
    self.bao_image1.frame = _topic_statusFrame.bao_image1F;
    self.bao_image2.frame = _topic_statusFrame.bao_image2F;
    self.taocan_label1.frame = _topic_statusFrame.taocan_label1F;
    self.taocan_label2.frame = _topic_statusFrame.taocan_label2F;
    self.xin_image1.frame = _topic_statusFrame.xin_image1F;
    self.xin_image2.frame = _topic_statusFrame.xin_image2F;
    self.star.frame = _topic_statusFrame.starF;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
