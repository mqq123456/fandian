//
//  FDUsersFrame.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDUsersFrame.h"
#import "membersModel.h"
#import "FDTopicUsersView.h"
@implementation FDUsersFrame
- (void)setStatus:(NSArray *)status
{
    _status = status;
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    self.gapViewF = (CGRect){{0, 0}, {cellW,10}};
    self.headViewF =(CGRect){{0, CGRectGetMaxY(self.gapViewF)}, {cellW,44}};
    self.lineViewF =(CGRect){{0, CGRectGetMaxY(self.headViewF)}, {cellW,0.5}};
    self.iconF =(CGRect){{15, 44/2-9}, {18,18}};
    self.peopleF =(CGRect){{CGRectGetMaxX(self.iconF)+5, 0}, {cellW-100,44}};
    self.people_descF =(CGRect){{cellW-80, 0}, {80,44}};
    
    CGFloat photosX = 10;
    CGFloat photosY = CGRectGetMaxY(self.lineViewF)+14;
    if (status.count) { // 有配图
        CGSize photosSize = [FDTopicUsersView sizeWithCount:status.count];
        self.photosViewF = (CGRect){{photosX, photosY}, photosSize};
        
    } else { // 没配图
        self.photosViewF = (CGRect){{0, photosY}, 0};
        self.cellHeight = 0;
    }
    self.cellHeight = CGRectGetMaxY(self.photosViewF)+11;

    
}
@end
