//
//  FDInfoSecontion1Cell.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/28.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDInfoSecontion1Cell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UITextField *rightText;
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;

@end
