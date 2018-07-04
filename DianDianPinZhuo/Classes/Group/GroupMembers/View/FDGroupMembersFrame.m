//
//  FDGroupMembersFrame.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/20.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDGroupMembersFrame.h"
#import "GroupMembersModel.h"
#import "HQConst.h"

@implementation FDGroupMembersFrame
- (void)setStatus:(GroupMembersModel *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    self.iconF = CGRectMake(15, 15, FDTopicUsersIconWH, FDTopicUsersIconWH);
    CGFloat user_nameX = CGRectGetMaxX(self.iconF)+17;
    self.user_nameF =CGRectMake(user_nameX, CGRectGetMinY(self.iconF), cellW-CGRectGetMaxX(self.iconF)-30, 24);
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
    
    CGRect  user_detailRect = [user_detail boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-140, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
    
    CGFloat user_detailY = CGRectGetMaxY(self.user_nameF);
    self.user_detailF =CGRectMake(user_nameX,user_detailY , user_detailRect.size.width, 30);
    /**  年龄和性别  */
    /**  年龄和性别  */
    CGFloat sex_ageY = self.user_detailF.origin.y+15-7;
    if (status.age &&![status.age isEqualToString:@""]) {
        if ([status.sex intValue]==1||[status.sex intValue]==2) {
            CGRect  sex_ageRect = [status.age boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, sex_ageY}, sex_ageRect.size.width+2+10,14};
        }else{
            CGRect  sex_ageRect = [status.age boundingRectWithSize:CGSizeMake(cellW-self.iconF.size.width-50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:user_detail_font} context:nil];
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, sex_ageY}, sex_ageRect.size.width+2,14};
        }
        
    }else{
        if ([status.sex intValue]==1||[status.sex intValue]==2) {
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, sex_ageY}, 14,14};
        }else{
            self.sex_ageF = (CGRect){{CGRectGetMaxX(self.user_detailF)+2, sex_ageY}, 0,0};
        }
        
    }

    CGFloat addressY = CGRectGetMaxY(self.user_detailF)+5;
    self.address_imageF =CGRectMake(user_nameX, addressY, 10, 10);
    self.addressF =CGRectMake(CGRectGetMaxX(self.address_imageF)+3, addressY-4, cellW-CGRectGetMaxX(self.address_imageF)-10, 20);
    self.cellHeight = CGRectGetMaxY(self.iconF)+15;
}
@end
