//
//  FDTopicDetailUserHeadView.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicDetailUserHeadView.h"
#import "MemberModel.h"
#import "UIImageView+WebCache.h"
#import "FDUserDetailViewController.h"
@implementation FDTopicDetailUserHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        // 超出边框的内容都剪掉
        FDHeadImageView *imageView = [[FDHeadImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.frame = CGRectMake(10, 0, self.frame.size.width-20,  self.frame.size.width-20);
        [self addSubview:imageView];
        self.imageView = imageView;
        UILabel *userName = [[UILabel alloc] init];
        userName.frame = CGRectMake(5, self.frame.size.width-20, self.frame.size.width-10, self.frame.size.height-(self.frame.size.width-20));
        userName.font = [UIFont systemFontOfSize:12];
        userName.textColor = FDColor(102, 102, 102, 1);
        [self addSubview:userName];
        //userName.lineBreakMode = NSLineBreakByTruncatingMiddle;
        userName.textAlignment = NSTextAlignmentCenter;
        self.userName = userName;
        [self.imageView addGestureRecognizer:        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
        UILabel *last_people = [[UILabel alloc] initWithFrame:self.imageView.frame];
        last_people.textColor = [UIColor whiteColor];
        last_people.font = [UIFont boldSystemFontOfSize:18];
        last_people.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1];
        [self addSubview:last_people];
        last_people.hidden = YES;
        last_people.layer.masksToBounds = YES;
        last_people.textAlignment = NSTextAlignmentCenter;
        self.last_people = last_people;
        
        
    }
    return self;
}

- (void)setPhoto:(MemberModel *)photo
{
    _photo = photo;
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photo.img] placeholderImage:[UIImage imageNamed:@"placeholder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image;
    }];
    if (photo.kid) {
        self.imageView.kid  = photo.kid;
    }
    if (photo.nick_name) {
        self.userName.text = photo.nick_name;
    }
    if (photo.kid==nil) {
        self.last_people.text = [NSString stringWithFormat:@"+%@",photo.img];
        self.last_people.hidden = NO;
    }else{
        self.last_people.hidden = YES;
    }
    
    
}
- (void)tapClick:(UITapGestureRecognizer *)tap{
    FDHeadImageView *head = (FDHeadImageView *)tap.view;
    if (head.kid) {
        FDUserDetailViewController *user = [[FDUserDetailViewController alloc] init];
        user.kid = head.kid;
        
        [[self viewController:self].navigationController pushViewController:user animated:YES];
    }
    
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)viewController:(UIView *)view{
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.width-20);
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    _userName.frame = CGRectMake(5, self.frame.size.width-20, self.frame.size.width-10, self.frame.size.height-(self.frame.size.width-20));
    _last_people.frame =CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.width-20);
    self.last_people.layer.cornerRadius = self.last_people.frame.size.width/2;
}

@end
