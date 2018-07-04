//
//  FDUUidManager.h
//  DianDianPinZhuo
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDUUidManager : NSObject

+ (instancetype)sharedManager;
-(void)initUserInfo;
-(void)saveUserinfo;
@property(nonatomic,strong)NSString* imei;
@end
