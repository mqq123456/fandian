//
//  StatusFrame.m
//  meilizhiyue
//
//  Created by 盛杰 on 15/5/3.
//  Copyright (c) 2015年 zhou. All rights reserved.
//

#import "StatusFrame.h"
#import "HQConst.h"
#import "MerchantModel.h"

@implementation StatusFrame

- (void)setStatus:(MerchantModel *)status
{
    _status = status;
    // cell的宽度
    CGFloat cellW = ScreenW;
    
    /* headViewF */
    CGFloat headViewH;
    if ([status.segment intValue]==0) {
        headViewH = 5;
    }else{
        headViewH = 24;
    }
    self.headViewF = CGRectMake(0, 0, cellW, headViewH);
    
    /* head_distanceF */
    self.head_distanceF = CGRectMake(0, 0, cellW, headViewH);
    
    /** originalViewF */
    self.originalViewF = CGRectMake(0, CGRectGetMaxY(self.headViewF), cellW, 90);
    
    /** 头像 */
    CGFloat iconWH = 68;
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 姓名 */
    CGFloat nameX = 100;
    CGFloat nameY = 15;
    CGRect  nameRect = [status.merchant_name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-140, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil];
    
    self.merchant_nameF = (CGRect){{nameX,nameY}, {nameRect.size.width,nameRect.size.height}};

    /** xingxing */
    CGFloat starX = nameX;
    CGFloat starY = CGRectGetMaxY(self.merchant_nameF)+7;
    CGFloat starW = 89;
    CGFloat starH = 15;
    self.starF = (CGRect){{starX, starY}, {starW, starH}};

    /** food */
    CGFloat foodX = nameX;
    CGFloat foodY = CGRectGetMaxY(self.starF)+7;
    self.foodF = (CGRect){{foodX,foodY}, {cellW - 120,19}};
    
    /** 热门 */
    CGFloat hotX = CGRectGetMaxX(self.merchant_nameF) + 5;
    CGFloat hotY = 15;
    CGFloat hotW = 25;
    CGFloat hotH = 17;
    self.hotF = (CGRect){{hotX, hotY}, {hotW, hotH}};
    
    /** 新上 */
    CGFloat isNewX = cellW - 50;
    CGFloat isNewY = 0;
    CGFloat isNewW = 28;
    CGFloat isNewH = 27;
    self.isNewF = (CGRect){{isNewX, isNewY}, {isNewW, isNewH}};
    
    
    /** 订满 */
    CGFloat dingmanImageX =cellW-120;
    CGFloat dingmanImageY = CGRectGetMaxY(self.isNewF)-6;
    self.dingmanImageF = (CGRect){{dingmanImageX, dingmanImageY}, {107, 28}};
    
    CGFloat bottomH = 36;
    
    /** originalViewF */
    self.bottonViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, bottomH);
    

    self.meirenF = CGRectMake(cellW - 30, 7, 30, bottomH-7);
    CGRect priceRect;
    
    if (self.is_bz==1) {
        priceRect = [[NSString stringWithFormat:@"¥%zd",[self.status.price integerValue]*10] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-200, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
        
    }else{
    
        priceRect = [[NSString stringWithFormat:@"¥%@",self.status.price] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-200, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
        
    }
   
    self.priceF = CGRectMake(CGRectGetMinX(self.meirenF)-priceRect.size.width-20, 2, priceRect.size.width+20, bottomH-2);
    /*distance距离*/
    self.distanceF = CGRectMake(nameX, 0, cellW-100 - priceRect.size.width-20-20, bottomH);
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.bottonViewF);
    
}
@end
