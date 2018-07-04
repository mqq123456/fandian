//
//  HQSearchBar.m
//  诺曼底
//
//  Created by user on 15/5/20.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "HQSearchBar.h"
#import "UIView+Extension.h"
@implementation HQSearchBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入要切换的写字楼";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.delegate = self;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}

@end
