//
//  FDTopicCommentFrame.m
//  DianDianPinZhuo
//
//  Created by user on 16/1/26.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicCommentFrame.h"
#import "TopicCommentModel.h"
#import "HQConst.h"
#import "NSString+Urldecode.h"


@implementation FDTopicCommentFrame
- (void)setStatus:(TopicCommentModel *)status
{
    _status = status;
    // cell的宽度
    CGFloat cellW = ScreenW;
    
    
    /** 头像 */
    CGFloat iconWH = 46;
    CGFloat iconX = 15;
    CGFloat iconY = 21;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    CGFloat nick_nameX = CGRectGetMaxX(self.iconF)+10;
    CGFloat nick_nameY = CGRectGetMinY(self.iconF)+2;
    CGFloat nick_nameW = cellW-CGRectGetMaxX(self.iconF)-20;
    CGRect  nameRect = [status.nickname boundingRectWithSize:CGSizeMake(nick_nameW, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nick_nameFont} context:nil];
    self.nick_nameF = CGRectMake(nick_nameX, nick_nameY, nameRect.size.width , 20);
    
    /* describe_viewF */
    CGRect timeRect = [status.time_desc boundingRectWithSize:CGSizeMake(cellW-nick_nameX-15, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:time_font} context:nil];
    CGFloat timeX = cellW-15-timeRect.size.width;
    CGFloat timeH = 20;
    self.timeF = CGRectMake(timeX, nick_nameY, timeRect.size.width, timeH);
    

    /** 姓名 */
     NSString *decodedString = [status.content stringByDecodingURLFormat];
    NSString *content;
    if (![status.reply_kid isEqualToString:@""]&&![status.reply_nickname isEqualToString:@""]) {
        content= [NSString stringWithFormat:@"回复%@：%@",status.reply_nickname,decodedString];
    }else{
        content=decodedString;
    }
     CGRect  contentRect = [content boundingRectWithSize:CGSizeMake(cellW-nick_nameX-15, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:content_Font} context:nil];
    //CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-50, 10000) lineBreakMode:NSLineBreakByTruncatingTail];
    

    CGFloat contentX = nick_nameX;
    CGFloat contentY = CGRectGetMaxY(self.nick_nameF)+5;
    CGFloat contentW = cellW-nick_nameX-15;
    
    self.contentF = (CGRect){{contentX,contentY}, {contentW,contentRect.size.height}};
    
//    CGFloat content_viewW = cellW-30;
//    self.content_viewF = (CGRect){{15,CGRectGetMaxY(self.iconF)+12}, {content_viewW,contentRect.size.height+20}};
//    
//    /** 热门 */
//    CGFloat jiantouW = 11;
//    CGFloat jiantouH = 6.5;
//    CGFloat jiantouX = 15+25-8;
//    self.jiantouF = CGRectMake(jiantouX, 15+50+15-6.5-3-4, jiantouW, jiantouH);
    CGFloat height1 = CGRectGetMaxY(self.contentF);
    CGFloat height2 = CGRectGetMaxY(self.iconF);
    if (height1>height2) {
        self.gap_viewF = CGRectMake(0, 1, cellW, CGRectGetMaxY(self.contentF)+25);
    }else{
        self.gap_viewF = CGRectMake(0, 1, cellW, CGRectGetMaxY(self.iconF)+25);
    }
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.gap_viewF);
    
}

@end

