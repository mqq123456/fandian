//
//  HttpGetCode.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpGetCode : NSObject
//获取单例对象
+(id)sharedInstance;

- (void)getCode:(NSString *)phone;

@end
