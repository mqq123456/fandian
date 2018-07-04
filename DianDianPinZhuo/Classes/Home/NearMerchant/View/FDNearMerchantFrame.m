//
//  FDNearMerchantFrame.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNearMerchantFrame.h"
#import "HQConst.h"
#import "MerchantModel.h"
#import "HQDefaultTool.h"
#import "SeatMealArrModel.h"

@implementation FDNearMerchantFrame

- (void)setStatus:(MerchantModel *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = ScreenW;
    
    self.gap_viewF = CGRectMake(0, 0, cellW, 10);
    /** 免费 */
    CGFloat freeX = 0;
    CGFloat freeY = 10;
    self.image_newF = (CGRect){{freeX, freeY}, {35,35}};
    
    /** 头像 */
    CGFloat iconWH = 44;
    CGFloat iconX = 14;
    CGFloat iconY = CGRectGetMaxY(self.gap_viewF)+17;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 姓名 */
    CGFloat nameX = CGRectGetMaxX(self.iconF)+10;
    CGFloat nameY = CGRectGetMaxY(self.gap_viewF)+12;
    CGRect  nameRect = [status.merchant_name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(self.iconF)+10-100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:merchant_nameFont} context:nil];
    self.merchant_nameF = (CGRect){{nameX,nameY}, {nameRect.size.width,30}};
    
    /** describe_Label */
    CGFloat starX = cellW-76;
    CGFloat starY = nameY-2;
    CGFloat starW = 80;
    CGFloat starH = 24;
    self.starF = CGRectMake(starX, starY, starW, starH);
    
    
    /** food */
    CGFloat foodX = nameX;
    CGFloat foodY = CGRectGetMaxY(self.iconF)-20;
    self.foodF = (CGRect){{foodX,foodY}, {cellW - CGRectGetMaxX(self.iconF)-20,24}};
    
    /** 热门 */
    CGFloat hotX = CGRectGetMaxX(self.merchant_nameF) + 5;
    CGFloat hotY = nameY+5;
    CGFloat hotW = 25;
    CGFloat hotH = 17;
    self.hotF = (CGRect){{hotX, hotY}, {hotW, hotH}};
    
    

    
    
    
  
    CGFloat bag_imageW = cellW-28;
    CGFloat bag_imageH = bag_imageW/1.8;
    CGFloat big_imageY = CGRectGetMaxY(self.iconF)+15;
    self.big_imageF = CGRectMake(14, big_imageY, bag_imageW, bag_imageH);
    
    /* describe_viewF */
    CGFloat describe_viewH = 38;
    self.describe_viewF = CGRectMake(14, CGRectGetMaxY(self.big_imageF)-describe_viewH, bag_imageW, describe_viewH);
    
    /** describe_Label */
    self.describe_LabelF = CGRectMake(5, 0, bag_imageW, describe_viewH);
    
    self.table_num_countF = CGRectMake(cellW-60, 30, 80, 20);
    if ([status.sold_out intValue]==1 ) {
        self.describe_viewF =CGRectMake(self.big_imageF.origin.x, self.big_imageF.origin.y, bag_imageW, bag_imageH);
        /** 订满 */
        CGFloat dingmanImageX = self.big_imageF.origin.x;
        CGFloat dingmanImageY = self.big_imageF.origin.y;
        CGFloat dingmanImageW = self.big_imageF.size.width;
        CGFloat dingmanImageH = self.big_imageF.size.height;
        
        self.dingmanImageF = (CGRect){{dingmanImageX, dingmanImageY}, {dingmanImageW, dingmanImageH}};
    }
    
    CGFloat taocan_viewY = CGRectGetMaxY(self.big_imageF);
    CGFloat taocan_viewH = 46;
    if (status.set_meal_arr.count>0) {
        self.taocan_viewF = CGRectMake(0, taocan_viewY, cellW, taocan_viewH);
    }else{
        self.taocan_viewF = CGRectMake(0, taocan_viewY, cellW, 0);
    }
    
    
    if (status.set_meal_arr.count>=2) {
        SeatMealArrModel *seat = status.set_meal_arr[0];
    
        SeatMealArrModel *seat1 = status.set_meal_arr[1];
        
//        CGFloat bao_imageW = 9;
//        CGFloat bao_imageY = 18;
//        CGFloat bao_imageH = 11;
//        
        //self.bao_image1F = CGRectMake(14, bao_imageY, bao_imageW, bao_imageH);
       
        NSString *content1 = [seat.price_people_num_desc string];
        CGRect  taocan_label1Rect = [content1 boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:taocan_label_font} context:nil];
        self.taocan_label1F =  CGRectMake(14, 0, taocan_label1Rect.size.width, taocan_viewH);
        CGFloat xin_imageW = 15;
        CGFloat xin_imageY = 16;
        CGFloat xin_imageH = 15;
        
        CGRect  original_price1Rect = [@"150元" boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:original_price_font} context:nil];
        
        self.original_price1F = CGRectMake(CGRectGetMaxX(self.taocan_label1F)+3,  4, original_price1Rect.size.width, taocan_viewH-4);
        self.bao_image1F = CGRectMake(CGRectGetMaxX(self.taocan_label1F)+3, (taocan_viewH+4)/2-0.5 , original_price1Rect.size.width, 0.5);
        
        if ([seat.menu_is_new intValue]==1) {
            self.xin_image1F =  CGRectMake(CGRectGetMaxX(self.original_price1F)+3, xin_imageY, xin_imageW, xin_imageH);
        }else{
            self.xin_image1F =  CGRectMake(CGRectGetMaxX(self.original_price1F)+3, xin_imageY, 0, 0);
        }
        
        //self.bao_image2F = CGRectMake(CGRectGetMaxX(self.xin_image1F)+10,  bao_imageY, bao_imageW, bao_imageH);
        NSString *content2 = [seat1.price_people_num_desc string];
        CGRect  taocan_label2Rect = [content2 boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:taocan_label_font} context:nil];
        self.taocan_label2F = CGRectMake(CGRectGetMaxX(self.xin_image1F)+10, 0, taocan_label2Rect.size.width, taocan_viewH);
        CGRect  original_price2Rect = [@"250元" boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:original_price_font} context:nil];
        
        self.original_price2F = CGRectMake(CGRectGetMaxX(self.taocan_label2F)+3,  4, original_price2Rect.size.width, taocan_viewH-4);
        self.bao_image2F = CGRectMake(CGRectGetMaxX(self.taocan_label2F)+3, (taocan_viewH+4)/2-0.5 , original_price2Rect.size.width, 0.5);
        if ([seat1.menu_is_new intValue]==1) {
            self.xin_image2F =  CGRectMake(CGRectGetMaxX(self.original_price2F)+3,  xin_imageY, xin_imageW, xin_imageH);

        }else{
            self.xin_image2F =  CGRectMake(CGRectGetMaxX(self.original_price2F)+3,  xin_imageY, 0, 0);

        }
        
    }
    if (status.set_meal_arr.count==1) {
        SeatMealArrModel *seat = status.set_meal_arr[0];
        
//        CGFloat bao_imageW = 9;
//        CGFloat bao_imageY = 18;
//        CGFloat bao_imageH = 11;
//        
//        self.bao_image1F = CGRectMake(14, bao_imageY, bao_imageW, bao_imageH);
        
        NSString *content1 = [seat.price_people_num_desc string];
        CGRect  taocan_label1Rect = [content1 boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:taocan_label_font} context:nil];
        self.taocan_label1F =  CGRectMake(14, 0, taocan_label1Rect.size.width, taocan_viewH);
        
        
        CGRect  original_price1Rect = [@"150元" boundingRectWithSize:CGSizeMake(1000, taocan_viewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:original_price_font} context:nil];
        
        self.original_price1F = CGRectMake(CGRectGetMaxX(self.taocan_label1F)+3,  4, original_price1Rect.size.width, taocan_viewH-4);
        self.bao_image1F = CGRectMake(CGRectGetMaxX(self.taocan_label1F)+3, (taocan_viewH+4)/2-0.5 , original_price1Rect.size.width, 0.5);
        
        
        CGFloat xin_imageW = 15;
        CGFloat xin_imageY = 16.5;
        CGFloat xin_imageH = 15;
        if ([seat.menu_is_new intValue]==1) {
            self.xin_image1F =  CGRectMake(CGRectGetMaxX(self.original_price1F)+3, xin_imageY, xin_imageW, xin_imageH);
        }else{
            self.xin_image1F =  CGRectMake(CGRectGetMaxX(self.original_price1F)+3, xin_imageY, 0, 0);
        }
        
        
        self.taocan_label2F = CGRectMake(CGRectGetMaxX(self.bao_image2F)+3, 0, 0, 0);
        
        self.xin_image2F =  CGRectMake(CGRectGetMaxX(self.taocan_label2F)+3,  xin_imageY, 0, 0);

    }
       
    
    /** originalViewF */
    CGFloat bottomY = CGRectGetMaxY(self.taocan_viewF);
    CGFloat bottomH = 42;
    self.bottonViewF = CGRectMake(14, bottomY, cellW-10, bottomH);
    self.lineF = (CGRect){{0, 0}, {cellW-28, 0.5}};
    
    if ([status.sold_out intValue]==1) {
        CGRect  yiyouRect = [@"已订满" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.yiyouF = CGRectMake(0, 0, yiyouRect.size.width, bottomH);
        self.people_yudingF = CGRectMake(CGRectGetMaxX(self.yiyouF), 0, 0, bottomH);
    }else{
        if ([status.order_seat intValue]==0) {
            CGRect  yiyouRect = [@"已有" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.yiyouF = CGRectMake(0, 0, yiyouRect.size.width, bottomH);
            CGRect  yiyou_peopleRect = [[NSString stringWithFormat:@"%d",status.tastes] boundingRectWithSize:CGSizeMake(1000, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.yiyou_peopleF = CGRectMake(CGRectGetMaxX(self.yiyouF), 0, yiyou_peopleRect.size.width, bottomH);
            CGRect  people_yudingRect = [@"人品尝" boundingRectWithSize:CGSizeMake(1000, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.people_yudingF = CGRectMake(CGRectGetMaxX(self.yiyou_peopleF), 0, people_yudingRect.size.width, bottomH);
        }else{
            CGRect  yiyouRect = [@"" boundingRectWithSize:CGSizeMake(100, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.yiyouF = CGRectMake(0, 0, yiyouRect.size.width, bottomH);
            /** originalViewF */
            CGRect  yiyou_peopleRect = [[NSString stringWithFormat:@"%@",status.order_seat] boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.yiyou_peopleF = CGRectMake(CGRectGetMaxX(self.yiyouF), 0, yiyou_peopleRect.size.width, bottomH);
            /** originalViewF */
            
            CGRect  people_yudingRect = [@"人预定" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.people_yudingF = CGRectMake(CGRectGetMaxX(self.yiyou_peopleF), 0, people_yudingRect.size.width, bottomH);
            
        }
        
    }
    
    
    if ([[HQDefaultTool getKid] isEqualToString:@""]||[status.tablemate intValue]==0||[status.order_seat intValue]==0) {
        self.remaining_peopleF = CGRectMake(0, 0, 0, 0);
        self.remainingF  = CGRectMake(0, 0, 0, 0);
        self.people_kongweiF  = CGRectMake(0, 0, 0, 0);
        
        CGRect  xian_baozhuoRect = [@"仅供包桌" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.xian_baozhuoF = CGRectMake(CGRectGetMaxX(self.people_yudingF)+10, bottomH/2-10, xian_baozhuoRect.size.width+15, 20);
    }else{
        
        CGRect  remainingRect = [@"" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        self.remainingF =  CGRectMake(CGRectGetMaxX(self.people_yudingF)+8, 0, remainingRect.size.width, bottomH);
        
        /** originalViewF */
        CGRect  remaining_peopleRect = [[NSString stringWithFormat:@"%@",status.tablemate] boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.remaining_peopleF = CGRectMake(CGRectGetMaxX(self.remainingF), 0, remaining_peopleRect.size.width, bottomH);
        CGRect  people_kongweiRect = [@"人曾同桌" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.people_kongweiF = CGRectMake(CGRectGetMaxX(self.remaining_peopleF), 0, people_kongweiRect.size.width, bottomH);
        
        CGRect  xian_baozhuoRect = [@"仅供包桌" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.xian_baozhuoF = CGRectMake(CGRectGetMaxX(self.people_kongweiF)+10, 13.5, xian_baozhuoRect.size.width+15, 20);
        /** originalViewF */
        if ([status.order_seat intValue]==0) {
            CGRect  xian_baozhuoRect = [@"仅供包桌" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
            self.xian_baozhuoF = CGRectMake(CGRectGetMaxX(self.people_yudingF)+10, 13.5, xian_baozhuoRect.size.width+15, 20);
        }
        
        
    }
    /** originalViewF */
    CGRect  meirenRect = [@"元/人" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:priceFont} context:nil];
    self.meirenF = CGRectMake(cellW-28-meirenRect.size.width, 0, meirenRect.size.width, bottomH);
    
    CGRect  priceRect = [[NSString stringWithFormat:@"%@",status.price] boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:priceFont} context:nil];
    self.priceF = CGRectMake(cellW-meirenRect.size.width-priceRect.size.width-28, 0, priceRect.size.width, bottomH);
    
    /*distance距离*/
    CGRect  distanceRect = [[NSString stringWithFormat:@"距离你约%@米",status.distance] boundingRectWithSize:CGSizeMake(cellW-CGRectGetMaxX(self.merchant_nameF)-30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:distanceFont} context:nil];
    self.distanceF = CGRectMake(cellW-distanceRect.size.width-14, 0, distanceRect.size.width, bottomH);
    
    self.distance_imageF = CGRectMake(cellW-distanceRect.size.width-10-14, (bottomH-9)/2, 7.5, 9);


    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.bottonViewF);
    
}
@end
