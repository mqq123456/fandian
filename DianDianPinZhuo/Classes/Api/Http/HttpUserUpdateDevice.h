//
//  HttpUserUpdateDevice.h
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/27.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUserUpdateDevice : NSObject
+(id)sharedInstance;
- (void)loadUserUpdateDeviceWithKid:(NSString *)kid;
@end
