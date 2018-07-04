//
//  FDGroupCell.m
//  DianDianPinZhuo
//
//  Created by user on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDGroupCell.h"

@implementation FDGroupCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)headerLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if(_delegate && _indexPath && [_delegate respondsToSelector:@selector(cellImageViewLongPressAtIndexPath:)])
        {
            [_delegate cellImageViewLongPressAtIndexPath:self.indexPath];
        }
    }
}
@end
