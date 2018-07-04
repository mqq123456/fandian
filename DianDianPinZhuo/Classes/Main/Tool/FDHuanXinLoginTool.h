//
//  FDHuanXinLoginTool.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/5/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FDHuanXinLoginTool : NSObject
+ (instancetype)sharedInstance;
- (void)huanxinLogin:(UIViewController *)controller;
@end
