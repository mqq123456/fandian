//
//  FDInvocieCell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDInvocieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UITextField *inputTextfiled;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
