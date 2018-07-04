//
//  FDGroupCell.h
//  DianDianPinZhuo
//
//  Created by user on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FDGroupCellDelegate <NSObject>

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FDGroupCell : UITableViewCell
{
    UILongPressGestureRecognizer *_headerLongPress;
}
@property (weak, nonatomic) id<FDGroupCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *creat_time;
@property (weak, nonatomic) IBOutlet UILabel *last_time;
@property (weak, nonatomic) IBOutlet UILabel *last_message;

@end
