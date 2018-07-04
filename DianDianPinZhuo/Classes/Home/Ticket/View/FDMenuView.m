//
//  FDMenuView.m
//  DianDianPinZhuo
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMenuView.h"
#import "UIImageView+WebCache.h"
#import "HQConst.h"
#import "AdView.h"
#import "UIView+Extension.h"
#import "FDUtils.h"
@interface FDMenuView()

@end
@implementation FDMenuView

+(instancetype)menuWithSmall_imagesURL:(NSMutableArray *)small_imagesURL small_categoryArray:(NSMutableArray *)small_categoryArray small_menusArray:(NSMutableArray *)small_menusArray  menuTitle:(NSString *)small_menu_title{
    
    FDMenuView *menu = [[[NSBundle mainBundle]loadNibNamed:@"FDMenuView" owner:nil options:nil]lastObject];
    menu.menuTitle.text = small_menu_title;
    menu.menuTitle.clipsToBounds = YES;
    menu.menuTitle.layer.cornerRadius = 3;
    menu.layer.masksToBounds = YES;
    if (IPhone6Plus) {
        menu.headImageViewH.constant = 180;
    }else if (IPhone6) {
        menu.headImageViewH.constant = 165;
    }else{
        menu.headImageViewH.constant = 145;
    }
    
    if (small_imagesURL.count<=1) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = menu.headImageView.bounds;
        CGFloat left = 20;
        imageView.width = [UIScreen mainScreen].bounds.size.width - left*2;
        if (IPhone6Plus) {
            imageView.height = 180;
        }else if (IPhone6) {
            imageView.height =  165;
        }else{
            imageView.height = 145;
        }
        
        if (small_imagesURL.count==0) {
            imageView.image = [UIImage imageNamed:@"ad_image"];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:small_imagesURL[0]] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
            }];
        }
        
        [menu.headImageView addSubview:imageView];
        
    }else{
        
        AdView *view = [AdView adScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, menu.headImageViewH.constant) imageLinkURL:small_imagesURL placeHoderImageName:@"ad_image" pageControlShowStyle:UIPageControlShowStyleCenter];
        [menu.contentView addSubview:view];
        
        
        
    }
    CGFloat menuH = 0.0;
    CGFloat labelX ;
    CGFloat imageW ;
    if (IPhone6Plus) {
        labelX = 45;
        imageW = 100;
    }else if (IPhone6){
        labelX = 40;
        imageW = 90;
    }else{
        labelX = 30;
        imageW = 80;
    }
    
    
    UIView *categoryView = [[UIView alloc] init];
    if (small_categoryArray.count>=1) {
        /** 特色 */
        NSArray *fristArray = [NSArray array];
        fristArray = small_menusArray[0];
        
        categoryView.frame = CGRectMake(labelX, 30,ScreenW-40-(labelX*2), (fristArray.count%2!=1?fristArray.count/2:fristArray.count/2+1)*24+30);
        [menu.menuListView addSubview:categoryView];
        
        UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, categoryView.frame.size.width, 21)];
        categoryLabel.text = small_categoryArray[0];
        categoryLabel.font = [UIFont boldSystemFontOfSize:14];
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        categoryLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
        [categoryView addSubview:categoryLabel];
        
        UIImageView *categoryLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(categoryLabel.frame)-imageW-30, CGRectGetMidY(categoryLabel.frame), imageW, 2.5)];
        categoryLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
        [categoryView addSubview:categoryLeft_image];
        
        UIImageView *categoryRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(categoryLabel.frame)+30, CGRectGetMidY(categoryLabel.frame), imageW, 2.5)];
        categoryRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
        [categoryView addSubview:categoryRight_image];
        
        
        double y = 30;
        double x = 0;
        
        if (fristArray.count == 1) {
            
            double w = (ScreenW-40-(labelX*2));
            double h = 24;
            UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
            menuLabel.text = fristArray[0];
            menuLabel.font = [UIFont boldSystemFontOfSize:14];
            menuLabel.textAlignment = NSTextAlignmentCenter;
            menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
            
            [categoryView addSubview:menuLabel];
            
        }else{
            
            for (int j=0; j<fristArray.count; j++ ) {
                double w = (ScreenW-40-(labelX*2))/2;
                double h = 24;
                UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
                menuLabel.text = fristArray[j];
                menuLabel.font = [UIFont boldSystemFontOfSize:14];
                menuLabel.textAlignment = NSTextAlignmentCenter;
                menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
                
                [categoryView addSubview:menuLabel];
                j%2!=1?(x += w ):(x=30,y += h);
                
                
            }
        }
        menuH = CGRectGetMaxY(categoryView.frame);
        
    }
    UIView *menuView = [[UIView alloc] init];
    if (small_categoryArray.count>=2) {
        /** 主食 */
        NSArray *secendArray = [NSArray array];
        secendArray = small_menusArray[1];
        
        menuView.frame = CGRectMake(labelX, CGRectGetMaxY(categoryView.frame)+10, ScreenW-40-(labelX*2), (secendArray.count%2!=1?secendArray.count/2:secendArray.count/2+1)*24+30);
        [menu.menuListView addSubview:menuView];
        
        UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
        menuLabel.text = small_categoryArray[1];
        menuLabel.font = [UIFont boldSystemFontOfSize:14];
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
        [menuView addSubview:menuLabel];
        
        
        UIImageView *categoryLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(menuLabel.frame)-imageW-30, CGRectGetMidY(menuLabel.frame), imageW, 2.5)];
        categoryLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
        [menuView addSubview:categoryLeft_image];
        
        UIImageView *categoryRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(menuLabel.frame)+30, CGRectGetMidY(menuLabel.frame), imageW, 2.5)];
        categoryRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
        [menuView addSubview:categoryRight_image];
        
        
        
        
        double menuX = 0;
        double menuY = 30;
        if (secendArray.count == 1) {
            
            double w = (ScreenW-40-(labelX*2));
            double h = 24;
            UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(menuX, menuY, w, h)];
            menuLabel.text = secendArray[0];
            menuLabel.font = [UIFont systemFontOfSize:14];
            menuLabel.textAlignment = NSTextAlignmentCenter;
            menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
            
            [menuView addSubview:menuLabel];
            
        }else{
            
            for (int j=0; j<secendArray.count; j++ ) {
                double w = (ScreenW-40-(labelX*2))/2;
                double h = 24;
                UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(menuX, menuY, w, h)];
                menuLabel.text = secendArray[j];
                menuLabel.font = [UIFont systemFontOfSize:14];
                menuLabel.textAlignment = NSTextAlignmentCenter;
                menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
                
                [menuView addSubview:menuLabel];
                j%2!=1?(menuX += w ):(menuX=0,menuY += h);
            }
        }
        
        menuH = CGRectGetMaxY(menuView.frame);
        
    }
    /** 上汤 */
    UIView *soupView = [[UIView alloc] init];
    if (small_categoryArray.count>=3) {
        NSArray *thirArray = [NSArray array];
        thirArray = small_menusArray[2];
        
        soupView.frame = CGRectMake(labelX, CGRectGetMaxY(menuView.frame)+10,ScreenW-40-(labelX*2), (thirArray.count%2!=1?thirArray.count/2:thirArray.count/2+1)*24+30);
        [menu.menuListView addSubview:soupView];
        
        UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
        soupLabel.text = small_categoryArray[2];
        soupLabel.font = [UIFont boldSystemFontOfSize:14];
        soupLabel.textAlignment = NSTextAlignmentCenter;
        soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
        [soupView addSubview:soupLabel];
        
        
        UIImageView *categoryLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)-imageW-30, CGRectGetMidY(soupLabel.frame), imageW, 2.5)];
        categoryLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
        [soupView addSubview:categoryLeft_image];
        
        UIImageView *categoryRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)+30, CGRectGetMidY(soupLabel.frame), imageW, 2.5)];
        categoryRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
        [soupView addSubview:categoryRight_image];
        
        
        
        
        double soupX = 0;
        double soupY = 30;
        if (thirArray.count == 1) {
            
            double w = (ScreenW-40-(labelX*2));
            double h = 24;
            UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
            soupLabel.text = thirArray[0];
            soupLabel.font = [UIFont systemFontOfSize:14];
            soupLabel.textAlignment = NSTextAlignmentCenter;
            soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
            
            [soupView addSubview:soupLabel];
            
        }else{
            
            for (int j=0; j<thirArray.count; j++ ) {
                double w = (ScreenW-40-(labelX*2))/2;
                double h = 24;
                UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
                soupLabel.text = thirArray[j];
                soupLabel.font = [UIFont systemFontOfSize:14];
                soupLabel.textAlignment = NSTextAlignmentCenter;
                soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
                
                [soupView addSubview:soupLabel];
                j%2!=1?(soupX += w ):(soupX=0,soupY += h);
            }
        }
        
        
        menuH = CGRectGetMaxY(soupView.frame);
        
    }
    
    
    /** 最后一个菜餐列表 */
    UIView *lastView = [[UIView alloc] init];
    if (small_categoryArray.count>=4) {
        NSArray *fourArray = [NSArray array];
        fourArray = small_menusArray[3];
        
        lastView.frame = CGRectMake(labelX, CGRectGetMaxY(soupView.frame)+10, ScreenW-40-(labelX*2), (fourArray.count%2!=1?fourArray.count/2:fourArray.count/2+1)*24+30);
        [menu.menuListView addSubview:lastView];
        
        UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
        lastLabel.font = [UIFont boldSystemFontOfSize:14];
        lastLabel.textAlignment = NSTextAlignmentCenter;
        lastLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
        lastLabel.text = small_categoryArray[3];
        [lastView addSubview:lastLabel];
        
        
        UIImageView *categoryLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(lastLabel.frame)-imageW-30, CGRectGetMidY(lastLabel.frame), imageW, 2.5)];
        categoryLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
        [lastView addSubview:categoryLeft_image];
        
        UIImageView *categoryRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(lastLabel.frame)+30, CGRectGetMidY(lastLabel.frame), imageW, 2.5)];
        categoryRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
        [lastView addSubview:categoryRight_image];
        
        
        double soupX = 0;
        double soupY = 30;
        if (fourArray.count == 1) {
            
            double w = (ScreenW-40-(labelX*2));
            double h = 24;
            UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
            soupLabel.text = fourArray[0];
            soupLabel.font = [UIFont systemFontOfSize:14];
            soupLabel.textAlignment = NSTextAlignmentCenter;
            soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
            
            [lastView addSubview:soupLabel];
            
        }else{
            
            for (int j=0; j<fourArray.count; j++ ) {
                double w = (ScreenW-40-(labelX*2))/2;
                double h = 24;
                UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
                soupLabel.text = fourArray[j];
                soupLabel.font = [UIFont systemFontOfSize:14];
                soupLabel.textAlignment = NSTextAlignmentCenter;
                soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
                
                [lastView addSubview:soupLabel];
                j%2!=1?(soupX += w ):(soupX=0,soupY += h);
            }
            
        }
        
        menuH = CGRectGetMaxY(lastView.frame);
    }
    
    if (IPhone6Plus) {
        menu.backViewH.constant = 224+menuH;
    }else if (IPhone6){
        menu.backViewH.constant = 200+menuH;
    }else{
        menu.backViewH.constant = 165+menuH;
    }
    
    return menu;
}


- (void)awakeFromNib {
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    if (IPhone6Plus) {
        self.backLeftH.constant = 20;
        self.backRightH.constant = 20;
    }
    //    else{
    //        self.backLeftH.constant = 15;
    //        self.backRightH.constant = 15;
    //    }
    [self.contentView bringSubviewToFront:self.menuTitle];
    [self layoutIfNeeded];
}



@end
