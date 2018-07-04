//
//  FDOrderListFrame.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/6/7.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDOrderListFrame.h"
#import "OrderModel.h"
@implementation FDOrderListFrame
- (void)setStatus:(OrderModel *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat timeX = 12;
    CGFloat timeH = 40;
    
    self.timeF = CGRectMake(timeX, 10, cellW-60, timeH);
    
    self.stateF = CGRectMake(cellW-122, 10, 110, timeH);
    CGFloat contentH = 68;
    self.content_viewF = CGRectMake(0, CGRectGetMaxY(self.timeF), cellW, contentH);
    
    CGFloat iconX = 12;
    CGFloat iconY = 10;
    CGFloat iconWH = contentH-20;
    
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    self.merchant_nameF = CGRectMake(CGRectGetMaxX(self.iconF)+10, iconY, cellW-CGRectGetMaxX(self.iconF)-20, 24);
    self.people_numF = CGRectMake(CGRectGetMaxX(self.iconF)+10, CGRectGetMaxY(self.iconF)-20, cellW-CGRectGetMaxX(self.iconF)-20, 20);
    
    
    CGFloat only_btnH = 26;
    
    if (status.state ==2) {
        CGRect  only_btnRect = [@"评价送积分" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        CGFloat only_btnX = cellW-only_btnRect.size.width-10-20;
        
        self.only_btnF = CGRectMake(only_btnX, CGRectGetMaxY(self.content_viewF)+10, only_btnRect.size.width+20, only_btnH);
        
        
        CGRect  again_btnRect = [@"再吃一次" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        
        CGFloat again_btnX = (only_btnX - again_btnRect.size.width)-20-10;
        
        self.again_btnF = CGRectMake(again_btnX, CGRectGetMaxY(self.content_viewF)+10, again_btnRect.size.width+20, only_btnH);
    }else if (status.state==1){
        CGRect  only_btnRect = [@"退款" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        CGFloat only_btnX = cellW-only_btnRect.size.width-10-20;
        
        self.only_btnF = CGRectMake(only_btnX, CGRectGetMaxY(self.content_viewF)+10, only_btnRect.size.width+20, only_btnH);
        
    }else if (status.state==0){
        CGRect  only_btnRect = [@"去支付" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        CGFloat only_btnX = cellW-only_btnRect.size.width-10-20;
        
        self.only_btnF = CGRectMake(only_btnX, CGRectGetMaxY(self.content_viewF)+10, only_btnRect.size.width+20, only_btnH);
        
    }else if (status.state ==3) {
        CGRect  only_btnRect = [@"发红包" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        CGFloat only_btnX = cellW-only_btnRect.size.width-10-20;
        
        self.only_btnF = CGRectMake(only_btnX, CGRectGetMaxY(self.content_viewF)+10, only_btnRect.size.width+20, only_btnH);
        
        
        CGRect  again_btnRect = [@"再吃一次" boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn_font} context:nil];
        
        CGFloat again_btnX = (only_btnX - again_btnRect.size.width)-20-10;
        
        self.again_btnF = CGRectMake(again_btnX, CGRectGetMaxY(self.content_viewF)+10, again_btnRect.size.width+20, only_btnH);
    }else{
        self.only_btnF = CGRectMake(0, CGRectGetMaxY(self.content_viewF)+10, 0, 0);
        self.again_btnF = CGRectMake(0, CGRectGetMaxY(self.content_viewF)+10, 0, 0);
    }

    
    self.cellHeight = CGRectGetMaxY(self.only_btnF)+10;
  
}
@end
