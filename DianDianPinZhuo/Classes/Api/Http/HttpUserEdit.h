//
//  HttpUserEdit.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDInformationViewController;
@class FDPerfectInformationViewController;
@interface HttpUserEdit : NSObject
//获取单例对象
+(id)sharedInstance;
/**
 *  图片上传
 */
- (void)loadUpLoadClick:(FDInformationViewController *)controller;

- (void)loadUserEditWithIndex:(NSInteger)index content:(NSString *)content;
- (void)loadUserEditWithIndustry:(NSString *)industry occupation:(NSString *)occupation;
- (void)loadUserEditOffice_build:(NSString *)content;
- (void)loadUserEditWithSex:(NSString *)sex age:(NSString *)age company:(NSString *)company occupation:(NSString *)occupation controller:(FDPerfectInformationViewController *)controller;
@end
