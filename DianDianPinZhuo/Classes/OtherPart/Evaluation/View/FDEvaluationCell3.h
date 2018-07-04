//
//  FDEvaluationCell3.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/10/30.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDEvaluationCell3 : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *environmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *speetBtn;
@property (weak, nonatomic) IBOutlet UIButton *diffentBtn;
@property (weak, nonatomic) IBOutlet UIButton *healthBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
