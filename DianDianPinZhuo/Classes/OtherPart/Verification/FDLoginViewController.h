//
//  FDLoginViewController.h
//  DianDianPinZhuo
//
//  Created by user on 16/1/12.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"

@protocol FDLoginViewControllerDelegate <NSObject>

@optional
- (void)isToOrder;
- (void)dismissWithIndex:(NSInteger)index;
- (void)pushToMakeTopic;
- (void)pushToMakeComment;
@end


@interface FDLoginViewController : RootViewController
@property (nonatomic,assign)id <FDLoginViewControllerDelegate>delegate;
@property (nonatomic)BOOL isFromDetail;
@property (nonatomic)BOOL isFirst;
@property (nonatomic)BOOL isFromList;
@property (nonatomic)BOOL isFromUserInfo;

@property (weak, nonatomic) UITextField *vcode;
@property (weak, nonatomic) UITextField *phone;
@property (weak, nonatomic) UILabel *label1;
@property (weak, nonatomic) UILabel *label2;


@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *openid;
@property (nonatomic,copy) NSString *weixin_head;
@property (nonatomic,copy) NSString *weixin_nickname;

///个人中心的跳转
@property (nonatomic,assign)NSInteger info_index;

- (void)saveLastLoginUsername;
- (void)addWeiXinView;
- (void)setNav;
- (void)weixinCheck:(NSString *)kid;

@end
