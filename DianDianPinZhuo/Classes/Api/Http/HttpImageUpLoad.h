//
//  HttpImageUpLoad.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/3.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpImageUpLoad : NSObject

+(id)sharedInstance;

- (void)imageUpLoadWithImageString:(NSString *)image;

@end
