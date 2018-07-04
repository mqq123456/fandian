//
//  FDNotJoinGroupsFrame.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDNotJoinGroupsFrame.h"
#import "NotJoinGroupModel.h"
#import "HQConst.h"

@implementation FDNotJoinGroupsFrame
- (void)setStatus:(NotJoinGroupModel *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    self.gap_viewF = CGRectMake(0, 0, cellW, 9);
    if (status.gap_hiden) {
        self.gap_viewF = CGRectMake(0, 0, cellW, 0);
    }
    
    /** 头像 */
    CGFloat iconWH = 52;
    CGFloat iconX = 13;
    CGFloat iconY = 23;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 用户名 */
    CGFloat nameX = CGRectGetMaxX(self.iconF) + HWStatusCellBorderW;
    CGFloat nameY = iconY+5;
    self.user_nameF = (CGRect){{nameX, nameY}, cellW-CGRectGetMaxX(self.iconF)-40,20};
    
    
    /** 用户详情 */
    CGFloat user_detailX = nameX;
    CGFloat user_detailY = CGRectGetMaxY(self.user_nameF)+7;
    CGRect  user_detailRect = [[NSString stringWithFormat:@"本群共%@人",status.members_count] boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
    self.user_detailF = (CGRect){{user_detailX, user_detailY}, user_detailRect.size.width,20};
    
    /** 跟随他 */
    CGFloat follow_sheX = cellW-80;
    CGFloat follow_sheY = user_detailY;
    CGFloat followW = 70;
    CGFloat followH = 20;
    self.follow_sheF = (CGRect){{follow_sheX,follow_sheY}, {followW,followH}};
    
    /** 标题 */
    CGFloat titleX = 8;
    CGFloat titleY = 8;
    CGFloat titleW = cellW-46;
    
    CGRect  titleRect = [status.notice boundingRectWithSize:CGSizeMake(titleW, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titlefont} context:nil];
  
    self.titleF = (CGRect){{titleX, titleY}, titleW,titleRect.size.height};
    /** 内容 */
    CGFloat content_viewX = 15;
    CGFloat content_viewY = CGRectGetMaxY(self.iconF) + 14;
    CGFloat content_viewW = cellW - 30;
    CGSize contentSize = CGSizeMake(content_viewW, 50);
    if (titleRect.size.height>30) {
        contentSize = CGSizeMake(content_viewW, 30+titleRect.size.height);
    }
    
    self.content_viewF = CGRectMake(content_viewX, content_viewY,contentSize.width,contentSize.height);
    CGRect  activeRect = [@"本群活跃" boundingRectWithSize:CGSizeMake(titleW, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:active_font} context:nil];
    
    self.activeF = CGRectMake(15, CGRectGetMaxY(self.content_viewF)+13, activeRect.size.width, 32);
    CGFloat user_head1FX = CGRectGetMaxX(self.activeF)+10;
    CGFloat user_headY = CGRectGetMaxY(self.content_viewF)+13;
    CGFloat user_headWH = TopicUsersIconWH;
    self.user_head1F = (CGRect){{user_head1FX,user_headY}, {user_headWH,user_headWH}};
    self.user_head2F = (CGRect){{CGRectGetMaxX(self.user_head1F)+12,user_headY}, {user_headWH,user_headWH}};
    self.user_head3F = (CGRect){{CGRectGetMaxX(self.user_head2F)+12,user_headY}, {user_headWH,user_headWH}};
    self.user_head4F = (CGRect){{CGRectGetMaxX(self.user_head3F)+12,user_headY}, {user_headWH,user_headWH}};
    self.line1F =CGRectMake(0, CGRectGetMaxY(self.user_head1F)+13, cellW, 0.5);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.line1F);
    
    
    
    
}
@end
