//
//  FDInputMyDescViewController.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RootViewController.h"

@interface FDInputMyDescViewController : RootViewController
/* 1,修改昵称 2、修改公司 3、修改写字楼 4.发送好有请求**/

@property (nonatomic ,copy) NSString *content;
@property (nonatomic ,copy) NSString *placehorder;
@property (nonatomic ,copy) NSString *navtitle;
@property (nonatomic ,copy) NSString *submitStr;
@property (nonatomic ,copy) NSString *kid;
///字数
@property (nonatomic ,assign) NSInteger NumberCounts;
@property (nonatomic ,copy) NSString *nickname;
@property (nonatomic ,copy) NSString *url;



@end
