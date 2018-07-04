//
//  FDSubject_Users_cell.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/22.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDSubject_Users_cell.h"


@implementation FDSubject_Users_cell
+ (instancetype)cellWithTableView:(UITableView *)tableView controller:(FDSubjectDetailViewController *)viewController usersArray:(NSArray *)users views:(FDSubjectUsers_View *)views{

    FDSubject_Users_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDSubject_Users_cell"];
    
    if (cell == nil) {
        
        cell =   [[FDSubject_Users_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FDSubject_Users_cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (users.count<=6) {
        views.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.width- left*2-placeH*(6-1))/6+placeH*2+30);
    }else{
        views.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.width- left*2-placeH*(6-1))/6+placeH*2)*2+30);
    }
    
    [cell.contentView addSubview:views];
    
    return cell;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
