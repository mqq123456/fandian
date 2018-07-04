//
//  FDMerchantDetail_Menu_Cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDMerchantDetail_Menu_Cell.h"
#import "HQConst.h"
#import "LDXScore.h"
#define labelFont [UIFont systemFontOfSize:15]

@implementation FDMerchantDetail_Menu_Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView categoryArray:(NSArray *)categoryArray menuArray:(NSArray *)menuArray hasTC:(BOOL)hasTC is_introduction:(BOOL)is_introduction{
    
    FDMerchantDetail_Menu_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDMerchantDetail_Menu_Cell"];
    if (cell == nil) {
        cell =   [[[NSBundle mainBundle] loadNibNamed:@"FDMerchantDetail_Menu_Cell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        CGFloat top = hasTC?120:0;
//        if (is_introduction) {
//            top-=50;
//        }
//
//        UIView *categoryView = [[UIView alloc] init];
//        if (menuArray.count>=1) {
//            /** 特色 */
//            NSArray *fristArray = [NSArray array];
//            fristArray = menuArray[0];
//            
//            categoryView.frame = CGRectMake(45, top+50, [UIScreen mainScreen].bounds.size.width-90, (fristArray.count%2!=1?fristArray.count/2:fristArray.count/2+1)*30+30);
//            [cell.contentView addSubview:categoryView];
//            
//            
//            UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, categoryView.frame.size.width, 21)];
//            categoryLabel.text = categoryArray[0];
//            categoryLabel.font = [UIFont boldSystemFontOfSize:15];
//            categoryLabel.textAlignment = NSTextAlignmentCenter;
//            categoryLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//            [categoryView addSubview:categoryLabel];
//            
//            UIImageView *categoryLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(categoryLabel.frame)-74-30, CGRectGetMidY(categoryLabel.frame), 74, 2.5)];
//            categoryLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
//            [categoryView addSubview:categoryLeft_image];
//            
//            UIImageView *categoryRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(categoryLabel.frame)+33, CGRectGetMidY(categoryLabel.frame), 74, 2.5)];
//            categoryRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
//            [categoryView addSubview:categoryRight_image];
//            
//            
//            double y = 33;
//            double x = 0;
//            
//            if (fristArray.count == 1) {
//
//                    double w = ([UIScreen mainScreen].bounds.size.width-90);
//                    double h = 30;
//                    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//                    menuLabel.text = fristArray[0];
//                    menuLabel.font = [UIFont boldSystemFontOfSize:15];
//                    menuLabel.textAlignment = NSTextAlignmentCenter;
//                    menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [categoryView addSubview:menuLabel];
//    
//            }else{
//            
//                for (int j=0; j<fristArray.count; j++ ) {
//                    double w = ([UIScreen mainScreen].bounds.size.width-90)/2;
//                    double h = 30;
//                    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//                    menuLabel.text = fristArray[j];
//                    menuLabel.font = [UIFont boldSystemFontOfSize:15];
//                    menuLabel.textAlignment = NSTextAlignmentCenter;
//                    menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [categoryView addSubview:menuLabel];
//                    j%2!=1?(x += w ):(x=30,y += h);
//                    
//                    
//                }
//            }
//
//            
//        }
//        UIView *menuView = [[UIView alloc] init];
//        if (menuArray.count>=2) {
//            /** 主食 */
//            NSArray *secendArray = [NSArray array];
//            secendArray = menuArray[1];
//            
//            menuView.frame = CGRectMake(45, CGRectGetMaxY(categoryView.frame)+10, [UIScreen mainScreen].bounds.size.width-90, (secendArray.count%2!=1?secendArray.count/2:secendArray.count/2+1)*30+30);
//            [cell.contentView addSubview:menuView];
//            
//            UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
//            menuLabel.text = categoryArray[1];
//            menuLabel.font = [UIFont boldSystemFontOfSize:15];
//            menuLabel.textAlignment = NSTextAlignmentCenter;
//            menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//            [menuView addSubview:menuLabel];
//            
//            
//            UIImageView *menuLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(menuLabel.frame)-74-30, CGRectGetMidY(menuLabel.frame), 74, 2.5)];
//            menuLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
//            [menuView addSubview:menuLeft_image];
//            
//            UIImageView *menuRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(menuLabel.frame)+30, CGRectGetMidY(menuLabel.frame), 74, 2.5)];
//            menuRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
//            [menuView addSubview:menuRight_image];
//            
//            
//            
//            double menuX = 0;
//            double menuY = 33;
//            if (secendArray.count == 1) {
//
//                    double w = ([UIScreen mainScreen].bounds.size.width-90);
//                    double h = 30;
//                    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(menuX, menuY, w, h)];
//                    menuLabel.text = secendArray[0];
//                    menuLabel.font = labelFont;
//                    menuLabel.textAlignment = NSTextAlignmentCenter;
//                    menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [menuView addSubview:menuLabel];
//          
//            }else{
//            
//                for (int j=0; j<secendArray.count; j++ ) {
//                    double w = ([UIScreen mainScreen].bounds.size.width-90)/2;
//                    double h = 30;
//                    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(menuX, menuY, w, h)];
//                    menuLabel.text = secendArray[j];
//                    menuLabel.font = labelFont;
//                    menuLabel.textAlignment = NSTextAlignmentCenter;
//                    menuLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [menuView addSubview:menuLabel];
//                    j%2!=1?(menuX += w ):(menuX=0,menuY += h);
//                }
//            }
//
//        }
//        /** 上汤 */
//        UIView *soupView = [[UIView alloc] init];
//        if (menuArray.count>=3) {
//            NSArray *thirArray = [NSArray array];
//            thirArray = menuArray[2];
//            
//            soupView.frame = CGRectMake(45, CGRectGetMaxY(menuView.frame)+10, [UIScreen mainScreen].bounds.size.width-90, (thirArray.count%2!=1?thirArray.count/2:thirArray.count/2+1)*30+30);
//            [cell.contentView addSubview:soupView];
//            
//            UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
//            soupLabel.text = categoryArray[2];
//            soupLabel.font = [UIFont boldSystemFontOfSize:15];
//            soupLabel.textAlignment = NSTextAlignmentCenter;
//            soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//            [soupView addSubview:soupLabel];
//            
//            UIImageView *soupLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)-74-30, CGRectGetMidY(soupLabel.frame), 74, 2.5)];
//            soupLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
//            [soupView addSubview:soupLeft_image];
//            
//            UIImageView *soupRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)+30, CGRectGetMidY(soupLabel.frame), 74, 2.5)];
//            soupRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
//            [soupView addSubview:soupRight_image];
//            
//            
//            
//            double soupX = 0;
//            double soupY = 33;
//            if (thirArray.count == 1) {
//
//                    double w = ([UIScreen mainScreen].bounds.size.width-90);
//                    double h = 30;
//                    UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
//                    soupLabel.text = thirArray[0];
//                    soupLabel.font = labelFont;
//                    soupLabel.textAlignment = NSTextAlignmentCenter;
//                    soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [soupView addSubview:soupLabel];
//           
//            }else{
//            
//                for (int j=0; j<thirArray.count; j++ ) {
//                    double w = ([UIScreen mainScreen].bounds.size.width-90)/2;
//                    double h = 30;
//                    UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
//                    soupLabel.text = thirArray[j];
//                    soupLabel.font = labelFont;
//                    soupLabel.textAlignment = NSTextAlignmentCenter;
//                    soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [soupView addSubview:soupLabel];
//                    j%2!=1?(soupX += w ):(soupX=0,soupY += h);
//                }
//            }
//
////            menuCover.frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(soupView.frame));
//
//        }
//        
//        
//        /** 最后一个菜餐列表 */
//        UIView *lastView = [[UIView alloc] init];
//        if (menuArray.count>=4) {
//            NSArray *fourArray = [NSArray array];
//            fourArray = menuArray[3];
//            
//            lastView.frame = CGRectMake(45, CGRectGetMaxY(soupView.frame)+10, [UIScreen mainScreen].bounds.size.width-90, (fourArray.count%2!=1?fourArray.count/2:fourArray.count/2+1)*30+30);
//            [cell.contentView addSubview:lastView];
//            
//            UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, menuView.frame.size.width, 21)];
//            soupLabel.text = categoryArray[3];
//            soupLabel.font = [UIFont boldSystemFontOfSize:14];
//            soupLabel.textAlignment = NSTextAlignmentCenter;
//            soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//            [lastView addSubview:soupLabel];
//            
//            UIImageView *soupLeft_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)-74-30, CGRectGetMidY(soupLabel.frame), 74, 2.5)];
//            soupLeft_image.image = [UIImage imageNamed:@"bow_ico_huawenzuo"];
//            [lastView addSubview:soupLeft_image];
//            
//            UIImageView *soupRight_image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(soupLabel.frame)+30, CGRectGetMidY(soupLabel.frame), 74, 2.5)];
//            soupRight_image.image = [UIImage imageNamed:@"bow_ico_huawenyou"];
//            [lastView addSubview:soupRight_image];
//            
//            
//            
//            double soupX = 0;
//            double soupY = 33;
//            if (fourArray.count == 1) {
//
//                    double w = ([UIScreen mainScreen].bounds.size.width-90);
//                    double h = 30;
//                    UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
//                    soupLabel.text = fourArray[0];
//                    soupLabel.font = labelFont;
//                    soupLabel.textAlignment = NSTextAlignmentCenter;
//                    soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [lastView addSubview:soupLabel];
//               
//            }else{
//            
//                for (int j=0; j<fourArray.count; j++ ) {
//                    double w = ([UIScreen mainScreen].bounds.size.width-90)/2;
//                    double h = 30;
//                    UILabel *soupLabel = [[UILabel alloc] initWithFrame:CGRectMake(soupX, soupY, w, h)];
//                    soupLabel.text = fourArray[j];
//                    soupLabel.font = labelFont;
//                    soupLabel.textAlignment = NSTextAlignmentCenter;
//                    soupLabel.textColor = [FDUtils colorWithHexString:@"#222222"];
//                    
//                    [lastView addSubview:soupLabel];
//                    j%2!=1?(soupX += w ):(soupX=0,soupY += h);
//                }
//            
//            }
//
//    }
        cell.lineH.constant = 0.5;
}

    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
