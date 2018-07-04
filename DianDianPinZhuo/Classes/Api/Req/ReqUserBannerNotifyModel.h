//
//  ReqUserBannerNotifyModel.h
//  DianDianPinZhuo
//
//  Created by HarryXu on 16/1/8.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqUserBannerNotifyModel : NSObject
///用户唯一标识
@property (strong,nonatomic) NSString *kid;
///banner的唯一标识
@property (strong,nonatomic) NSString *banner_id;

@end
