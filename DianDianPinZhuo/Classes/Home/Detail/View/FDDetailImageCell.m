//
//  FDDetailImageCell.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDDetailImageCell.h"
#import "AdView.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FDHeadImageView.h"
#define IPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736 ? YES : NO)

@implementation FDDetailImageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView imagesURL:(NSArray *)imagesURL{
    FDDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDDetailImageCell"];
    
    if (cell == nil) {
        
        cell =   [[FDDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (imagesURL.count<=1) {
        
        [cell.view removeFromSuperview];
        cell.view=nil;
        FDHeadImageView *imageView = [[FDHeadImageView alloc] init];
        
        imageView.frame = CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width,(([UIScreen mainScreen].bounds.size.width)*0.56649744));
        
        if (imagesURL.count==0) {
            imageView.image = [UIImage imageNamed:@"ad_image"];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagesURL[0]] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
            }];
            imageView.kid = imagesURL[0];
        }
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(imageClick:)]];
        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = imageView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        imageView.layer.mask = maskLayer;
        [cell.contentView addSubview:imageView];
        
    }else{
        AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.width)*0.56649744)) imageLinkURL:imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
        //        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
        //        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //        maskLayer.frame = view.bounds;
        //        maskLayer.path = maskPath.CGPath;
        //        view.layer.mask = maskLayer;
        [cell.contentView addSubview:view];
        
        view.callBack = ^(NSInteger index,NSString * imageURL)
        {
            // 1.创建图片浏览器
            MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
            browser.hideDeleteBtn = YES;
            //        // 2.设置图片浏览器显示的所有图片
            NSMutableArray *photos = [NSMutableArray array];
            
            int count = (int)imagesURL.count;
            for (int i = 0; i<count; i++) {
                //StatusPhoto *pic = self.photos[i];
                
                MJPhoto *photo = [[MJPhoto alloc] init];
                // 设置图片的路径
                photo.url = [NSURL URLWithString:imagesURL[i]];
                // 设置来源于哪一个UIImageView
                photo.srcImageView = view.centerImageView;
                [photos addObject:photo];
            }
            browser.photos = photos;
            
            // 3.设置默认显示的图片索引
            browser.currentPhotoIndex = index;
            
            // 3.显示浏览器
            [browser show];
        };

        cell.view = view;
    }
    
    return cell;
}
- (void)imageClick:(UITapGestureRecognizer *)tap{
    // 1.创建图片浏览器
    FDHeadImageView *imageView = (FDHeadImageView *)tap.view;
    if (imageView.kid) {
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.hideDeleteBtn = YES;
        //        // 2.设置图片浏览器显示的所有图片
        NSMutableArray *photos = [NSMutableArray array];
        
        //StatusPhoto *pic = self.photos[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:imageView.kid];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = imageView;
        [photos addObject:photo];
        
        browser.photos = photos;
        
        // 3.设置默认显示的图片索引
        browser.currentPhotoIndex = 0;
        
        // 3.显示浏览器
        [browser show];

    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
