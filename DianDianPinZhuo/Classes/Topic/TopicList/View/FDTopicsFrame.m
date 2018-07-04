//
//  FDTopicsFrame.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/21.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicsFrame.h"
#import "FDTopics.h"
#import "HWStatusPhotosView.h"
#import "UIImageView+WebCache.h"
#import "HQConst.h"

@implementation FDTopicsFrame

- (void)setStatus:(FDTopics *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    
    /** 头像 */
    CGFloat iconWH = 52;
    CGFloat iconX = 13;
    CGFloat iconY = 13;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 用户名 */
    CGFloat nameX = CGRectGetMaxX(self.iconF) + HWStatusCellBorderW;
    CGFloat nameY = iconY+2;
    self.user_nameF = (CGRect){{nameX, nameY}, cellW-CGRectGetMaxX(self.iconF)-100,20};
    
    
    /** 用户详情 */
    CGFloat user_detailX = nameX;
    CGFloat user_detailY = CGRectGetMaxY(self.iconF)-20-2;
    NSString *user_detail;
    if (status.occupation&&status.company&&![status.occupation isEqualToString:@""]&&![status.company isEqualToString:@""]) {
        user_detail = [NSString stringWithFormat:@"%@ - %@",status.company,status.occupation];
    }else{
        if (status.occupation==nil) {
            user_detail = [NSString stringWithFormat:@"%@",status.company];
        }else{
            user_detail = [NSString stringWithFormat:@"%@%@",status.company,status.occupation];
        }
    }
    
    CGRect  user_detailRect = [user_detail boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
    self.user_detailF = (CGRect){{user_detailX, user_detailY}, user_detailRect.size.width,20};
    /**  年龄和性别  */
    if (status.age &&![status.age isEqualToString:@""]) {
        if ([status.sex intValue]==1||[status.sex intValue]==2) {
            CGRect  sex_ageRect = [status.age boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, user_detailY+3}, sex_ageRect.size.width+2+10,14};
        }else{
            CGRect  sex_ageRect = [status.age boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, user_detailY+3}, sex_ageRect.size.width+2,14};
        }
        
    }else{
        if ([status.sex intValue]==1||[status.sex intValue]==2) {
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, user_detailY+3}, 14,14};
        }else{
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, user_detailY+3}, 0,0};
        }

    }
    
    /** 免费 */
    CGFloat freeX = cellW-45;
    CGFloat freeY = 0;
    self.freeF = (CGRect){{freeX, freeY}, {30,30}};
    
    /** 跟随他 */
    CGFloat follow_sheX = cellW-80;
    CGFloat follow_sheY = 15;
    CGFloat followW = 70;
    CGFloat followH = 20;
    self.follow_sheF = (CGRect){{follow_sheX,follow_sheY}, {followW,followH}};
    
    
    
    /** 标题 */
    CGFloat titleX = iconX;
    CGFloat titleY = CGRectGetMaxY(self.iconF)+13;
    CGFloat titleW = cellW-(iconX*2);
    
    CGRect  titleRect = [status.content boundingRectWithSize:CGSizeMake(titleW, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:title_font} context:nil];
    //    NSLog(@"高度%f",titleRect.size.height);
    
    self.titleF = (CGRect){{titleX, titleY}, titleW,titleRect.size.height};
    CGFloat content_viewY ;
    if (status.image &&![status.image isEqualToString:@""]) { // 有配图
        NSArray *array  = @[status.image];
        CGFloat photosX = titleX;
        CGFloat photosY = CGRectGetMaxY(self.titleF) + 13;
        CGSize photosSize = [HWStatusPhotosView sizeWithCount:array.count];
        self.imageF = (CGRect){{photosX, photosY}, {photosSize.width,photosSize.height}};
        content_viewY = CGRectGetMaxY(self.imageF) + 13;
    }else{
        content_viewY = CGRectGetMaxY(self.titleF) + 13;
    }
    /** 内容 */
    CGFloat content_viewX = 13;
    CGFloat content_viewW = cellW - 26;
    CGSize contentSize = CGSizeMake(content_viewW, 64);
    self.content_viewF = CGRectMake(content_viewX, content_viewX,contentSize.width,contentSize.height);
    

    /*distance距离*/
    NSString *distance;
    if ([status.distance intValue]>1000) {
        distance = [NSString stringWithFormat:@"地点：%@ 距离你约%.1f公里",status.merchant_name,[status.distance floatValue]/1000];
    }else{
        distance =[NSString stringWithFormat:@"地点：%@ 距离你约%@米",status.merchant_name,status.distance];
    }
    
    CGRect  distanceRect = [distance boundingRectWithSize:CGSizeMake(titleW-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.distanceF = CGRectMake(22, 10, distanceRect.size.width, distanceRect.size.height);
    self.distance_imageF = CGRectMake(5,12 , 10, 12);
    self.time_imageF = CGRectMake(4.5,CGRectGetMaxY(self.distanceF)+7 , 12, 12);
    /* 时间 */
    CGRect  timeRect = [[NSString stringWithFormat:@"时间：%@ %@",status.kdate_desc,status.meal_time] boundingRectWithSize:CGSizeMake(titleW-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.timeF = CGRectMake(22, CGRectGetMaxY(self.distanceF)+5, timeRect.size.width, timeRect.size.height);
    
    self.content_viewF = CGRectMake(content_viewX, content_viewY, content_viewW, CGRectGetMaxY(self.timeF)+10);
  
    CGFloat bottomH = 30;
    CGFloat bottonY = CGRectGetMaxY(self.content_viewF)+15;

    if (status.comment_num==0) {
        self.tiao_pinglunF = (CGRect){{cellW-10,bottonY}, {0,bottomH}};
        self.point2F= (CGRect){{cellW-10,bottonY}, {0,bottomH}};
        self.comment_peopleF =(CGRect){{cellW-10,bottonY}, {0,bottomH}};
    }else{
        CGRect tiao_pinglunRect  = [@"条讨论" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.tiao_pinglunF = (CGRect){{cellW-10-tiao_pinglunRect.size.width,bottonY}, {tiao_pinglunRect.size.width,bottomH}};
        CGRect  comment_peopleRect = [[NSString stringWithFormat:@"%d",status.comment_num] boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.comment_peopleF =(CGRect){{CGRectGetMinX(self.tiao_pinglunF)-comment_peopleRect.size.width,bottonY}, {comment_peopleRect.size.width,bottomH}};
        self.point2F= CGRectMake(CGRectGetMinX(self.comment_peopleF)-15, bottonY, 15, bottomH);
    }
    if (status.sheng_yu == 0) {
        self.remaining_peopleF = CGRectMake(0, 0, 0, 0);
        CGRect  people_kongweiRect = [@"人数已满" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.people_kongweiF = (CGRect){{CGRectGetMinX(self.point2F)-people_kongweiRect.size.width,bottonY}, {people_kongweiRect.size.width,bottomH}};
    }else{
        CGRect  people_kongweiRect = [@"人预订" boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.people_kongweiF = (CGRect){{CGRectGetMinX(self.point2F)-people_kongweiRect.size.width,bottonY}, {people_kongweiRect.size.width,bottomH}};
        CGRect  remaining_peopleRect = [[NSString stringWithFormat:@"%d",status.ordermeal_num] boundingRectWithSize:CGSizeMake(200, bottomH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bottonFont} context:nil];
        self.remaining_peopleF = (CGRect){{CGRectGetMinX(self.people_kongweiF)-remaining_peopleRect.size.width,bottonY}, {remaining_peopleRect.size.width+2,bottomH}};
    }
    

    
    CGFloat user_head1FX = 13;
    CGFloat user_headY = CGRectGetMaxY(self.content_viewF)+14;
    CGFloat user_headWH = FDTopicUsersIconWH;
    self.user_head1F = (CGRect){{user_head1FX,user_headY}, {user_headWH,user_headWH}};
    self.user_head2F = (CGRect){{CGRectGetMaxX(self.user_head1F)+13,user_headY}, {user_headWH,user_headWH}};
    self.user_head3F = (CGRect){{CGRectGetMaxX(self.user_head2F)+13,user_headY}, {user_headWH,user_headWH}};
    self.user_head4F = (CGRect){{CGRectGetMaxX(self.user_head3F)+13,user_headY}, {user_headWH,user_headWH}};
    
    self.gap_viewF = CGRectMake(0, CGRectGetMaxY(self.user_head1F)+14, cellW, 10);
    self.line1F =CGRectMake(0, CGRectGetMaxY(self.user_head1F)+13.5, cellW, 0.5);
    if ([status.last_unfinished intValue]==1) {
        self.gap_viewF = CGRectMake(0, CGRectGetMaxY(self.user_head1F)+14, cellW, 40);
        self.end_tipsF = CGRectMake(cellW/2-60, 0, 120, 40);
        self.left_lineF = CGRectMake(30, 40/2-0.5, cellW/2-100, 0.5);
        self.right_lineF = CGRectMake(cellW/2+70, 40/2-0.5, cellW/2-100, 0.5);
    
    }else{
        self.gap_viewF = CGRectMake(0, CGRectGetMaxY(self.user_head1F)+14, cellW, 10);
        self.end_tipsF = CGRectMake(0, 0, 0, 0);
        self.left_lineF = CGRectMake(0, 0, 0, 0);
        self.right_lineF = CGRectMake(0, 0, 0, 0);
    }
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.gap_viewF);
    
    
    
    
}
@end
