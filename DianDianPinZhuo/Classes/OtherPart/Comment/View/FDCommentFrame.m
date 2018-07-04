//
//  FDCommentFrame.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDCommentFrame.h"
#import "CommentModel.h"
#import "HQConst.h"
#import "NSString+Urldecode.h"
#import "HWStatusPhotosView.h"
@implementation FDCommentFrame
- (void)setStatus:(CommentModel *)status
{
    _status = status;
    // cell的宽度
    CGFloat cellW = ScreenW;
    
    
    
    /** 头像 */
    CGFloat iconWH = 42;
    CGFloat iconX = 15;
    CGFloat iconY = CGRectGetMaxY(self.gap_viewF)+15;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    CGFloat nick_nameX = CGRectGetMaxX(self.iconF)+8;
    CGFloat nick_nameY = CGRectGetMinY(self.iconF)+1;
    CGFloat nick_nameW = cellW-CGRectGetMaxX(self.iconF)-150;
    CGRect  nameRect = [status.nick_name boundingRectWithSize:CGSizeMake(nick_nameW, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nick_nameFont} context:nil];
    self.nick_nameF = CGRectMake(nick_nameX, nick_nameY, nameRect.size.width , 20);
    
    /* describe_viewF */
    CGFloat timeW = 230;
    CGFloat timeH = 20;
    self.timeF = CGRectMake(nick_nameX, CGRectGetMaxY(self.nick_nameF), timeW, timeH);
    
    /** describe_Label */
    CGFloat starX = cellW-76;
    CGFloat starY = nick_nameY-2;
    CGFloat starW = 80;
    CGFloat starH = 24;
    self.starF = CGRectMake(starX, starY, starW, starH);
    
    NSString *decodedString = [status.content stringByDecodingURLFormat];
    CGRect  replyRect = [decodedString boundingRectWithSize:CGSizeMake(cellW-iconX-iconX, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:content_Font} context:nil];
    
    self.replyF = CGRectMake(iconX, CGRectGetMaxY(self.iconF)+10, cellW-iconX-iconX, replyRect.size.height);
    
    CGFloat photosX = iconX;
    CGFloat photosY = CGRectGetMaxY(self.replyF) + 8;
    if (status.imgs.count>0) { // 有配图
        CGSize photosSize = [HWStatusPhotosView sizeWithCount:status.imgs.count];
        self.imageF = (CGRect){{photosX, photosY}, {photosSize.width,photosSize.height}};
        
    }else{
        self.imageF = (CGRect){{photosX, photosY}, {0,0}};
    }

    /** 姓名 */
    if ([status.service_response isEqualToString:@""]||status.service_response==nil) {
        self.cellHeight = CGRectGetMaxY(self.imageF)+12;
        
    }else{
        CGFloat contentX = 10;
        CGFloat contentY = 0;
        CGFloat contentW = cellW-30;
        NSString *decoString = [status.service_response stringByDecodingURLFormat];
        CGRect  contentRect = [decoString boundingRectWithSize:CGSizeMake(contentW, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:content_Font} context:nil];
        self.contentF = (CGRect){{contentX,contentY}, {contentRect.size.width,contentRect.size.height+26}};
        
        CGFloat content_viewW = cellW-10;
        self.content_viewF = (CGRect){{5,CGRectGetMaxY(self.imageF)+10}, {content_viewW,contentRect.size.height+26}};
        
        /** 热门 */
        CGFloat jiantouW = 11;
        CGFloat jiantouH = 6.5;
        CGFloat jiantouX = 15+25-8;
        CGFloat jiantouY = CGRectGetMinY(self.content_viewF)-6.5;
        self.jiantouF = CGRectMake(jiantouX, jiantouY, jiantouW, jiantouH);
        /* cell的高度 */
        self.cellHeight = CGRectGetMaxY(self.content_viewF)+12;
    }
    self.gap_viewF = CGRectMake(0, self.cellHeight-0.5, cellW, 0.5);
    
}

@end
