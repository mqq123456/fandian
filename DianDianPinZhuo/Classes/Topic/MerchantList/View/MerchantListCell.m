
//
//  MerchantListCell.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "MerchantListCell.h"
#import "UIView+Extension.h"
#import "LDXScore.h"
#import "HQConst.h"
#import "StatusFrame.h"
#import "MerchantModel.h"
#import "UIImageView+WebCache.h"

@interface MerchantListCell ()
/** 上部的距离view */
@property (nonatomic, weak) UIView *headView;
/** 中间view */
@property (nonatomic, weak) UIView *originalView;
/** 餐厅距离 */
@property (nonatomic, weak) UILabel *head_distance;
/** 头像 */
@property (nonatomic, weak) UIImageView *icon;
/** 餐厅名称 */
@property (nonatomic, weak) UILabel *merchant_name;
/** 星星 */
@property (nonatomic, weak) LDXScore *star;
/** 特色 */
@property (nonatomic, weak) UILabel *food;
/** 距离 */
@property (nonatomic, weak) UILabel *distance;
/** 热门 */
@property (nonatomic, weak) UIImageView *hot;

/** 新上 */
@property (nonatomic, weak) UIImageView *isNew;
/** 餐厅订满 */
@property (nonatomic, weak) UIImageView *dingmanImage;

/** 价格 */
@property (nonatomic, weak) UILabel *price;
/** 每人 */
@property (nonatomic, weak) UILabel *meiren;
/** 线 */
@property (nonatomic, weak) UIView *bottonView;



@end
@implementation MerchantListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MerchantListCell";
    MerchantListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MerchantListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    /** headView */
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = FDColor(239, 239, 244, 1);
    [self.contentView addSubview:headView];
    self.headView = headView;
    
    /** 头部距离 */
    UILabel *head_distance = [[UILabel alloc] init];
    head_distance.font = [UIFont systemFontOfSize:13];
    head_distance.textAlignment = NSTextAlignmentCenter;
    head_distance.textColor = FDColor(153, 153, 153, 1);
    [headView addSubview:head_distance];
    self.head_distance = head_distance;
    
    /** 中间view */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 3;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.clipsToBounds = YES;
    [originalView addSubview:icon];
    self.icon = icon;
    
    /** 餐厅名称 */
    UILabel *merchant_name = [[UILabel alloc] init];
    merchant_name.textColor = FDColor(51, 51, 51 ,1);
    merchant_name.font = [UIFont boldSystemFontOfSize:17];
    [originalView addSubview:merchant_name];
    self.merchant_name = merchant_name;
    
    /** 星星 */
    LDXScore *star = [[LDXScore alloc] init];
    star.normalImg = [UIImage imageNamed:@"star_nor"];
    star.highlightImg = [UIImage imageNamed:@"star_sel"];
    [originalView addSubview:star];
    self.star = star;
    
    /** 热门 */
    UIImageView *hot = [[UIImageView alloc] init];
    hot.image = [UIImage imageNamed:@"list_ico_hot_nor"];
    hot.contentMode = UIViewContentModeScaleAspectFill;
    [originalView addSubview:hot];
    
    self.hot = hot;
    
    /** 新上线 */
    UIImageView *isNew = [[UIImageView alloc] init];
    isNew.image = [UIImage imageNamed:@"list_img_new_nor"];
    isNew.contentMode = UIViewContentModeScaleAspectFill;
    [originalView addSubview:isNew];
    self.isNew = isNew;
    
    /** 订满 */
    UIImageView *dingmanImage = [[UIImageView alloc] init];
    dingmanImage.image = [UIImage imageNamed:@"list_img_dingman_nor"];
    [originalView addSubview:dingmanImage];
    dingmanImage.contentMode = UIViewContentModeScaleAspectFill;
    self.dingmanImage = dingmanImage;
    
    
    /** 特色 */
    UILabel *food = [[UILabel alloc] init];
    food.font = [UIFont systemFontOfSize:15];
    food.textColor = FDColor(102, 102, 102, 1);
    [originalView addSubview:food];
    self.food = food;
    
    /** 底部view */
    UIView *bottonView = [[UIView alloc] init];
    [self.contentView addSubview:bottonView];
    self.bottonView = bottonView;
    
    /** 距离 */
    UILabel *distance = [[UILabel alloc] init];
    distance.font = [UIFont systemFontOfSize:14];
    distance.textColor = FDColor(153, 153, 153, 1);
    [bottonView addSubview:distance];
    self.distance = distance;
    
    /** 价格 */
    UILabel *price = [[UILabel alloc] init];
    price.font = [UIFont systemFontOfSize:20];
    price.textAlignment = NSTextAlignmentRight;
    price.textColor = FDColor(255, 84, 0, 1);
    [bottonView addSubview:price];
    self.price = price;
    
    /** 价格 */
    UILabel *meiren = [[UILabel alloc] init];
    meiren.font = [UIFont systemFontOfSize:12];
    meiren.textColor = FDColor(51, 51, 51, 1);
    meiren.textAlignment = NSTextAlignmentLeft;
    [bottonView addSubview:meiren];
    self.meiren = meiren;
    
    /** 线 */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, ScreenW-100, 0.5)];
    lineView.backgroundColor = FDColor(233, 233, 233, 1);
    [bottonView addSubview:lineView];
    
    
    
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupFrame];
    
    MerchantModel *statusM = statusFrame.status;
    
    /** 上部距离 */

    self.head_distance.text = statusM.segment_desc;

//    [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.icon.image = image;
//    }];
    if ([statusM.icon hasPrefix:@"http://image.fundot.com.cn/"]) {
        NSString *img;
        if (IPhone6Plus) {//68*3
            img = [NSString stringWithFormat:@"%@@204w",statusM.icon];
        }else{
            img = [NSString stringWithFormat:@"%@@136w",statusM.icon];
        }
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:statusM.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.icon.image = image;
        }];
    }

    
    /** 姓名 */

    self.merchant_name.text = statusM.merchant_name;
    
    self.star.show_star = [statusM.star intValue];
    
    self.food.text = statusM.dishes;
    
    /** 距离 */
    self.distance.text = [NSString stringWithFormat:@"距离你约%@ %d人品尝",statusM.distance,statusM.tastes];
    

    
    /** 每人 */
    if (self.is_bz == 1) {
        /** 价格 */
        self.price.text = [NSString stringWithFormat:@"¥%zd",[statusM.price integerValue]*[self.peopleNum integerValue]];
        self.meiren.text = @"/桌";
    }else{
        /** 价格 */
        self.price.text = [NSString stringWithFormat:@"¥%@",statusM.price];
        self.meiren.text = @"/人";
    }
    
    if ([statusM.sold_out intValue]==1) {//是否售完
        self.dingmanImage.hidden = NO;
    }else{
        self.dingmanImage.hidden = YES;
    }
    if ([statusM.isNew intValue]==1) {//是否新上线
        self.isNew.hidden = NO;
    }else{
        self.isNew.hidden = YES;
    }
    if ([statusM.hot intValue]==1) {//是否热门
        self.hot.hidden = NO;
    }else{
        self.hot.hidden = YES;
    }

    
}
- (void)setupFrame{
    self.headView.frame = _statusFrame.headViewF;
    self.head_distance.frame = _statusFrame.head_distanceF;
    
    self.originalView.frame = _statusFrame.originalViewF;
    self.icon.frame = _statusFrame.iconF;
    self.merchant_name.frame = _statusFrame.merchant_nameF;
    self.star.frame = _statusFrame.starF;
    self.food.frame = _statusFrame.foodF;
    self.hot.frame = _statusFrame.hotF;
    self.isNew.frame = _statusFrame.isNewF;
    self.dingmanImage.frame = _statusFrame.dingmanImageF;
    
    self.bottonView.frame = _statusFrame.bottonViewF;
    self.distance.frame = _statusFrame.distanceF;
    self.price.frame = _statusFrame.priceF;
    self.meiren.frame = _statusFrame.meirenF;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
