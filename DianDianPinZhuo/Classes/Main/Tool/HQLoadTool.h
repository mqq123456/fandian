//
//  HQLoadTool.h
//  normandy
//
//  Created by rongdong on 15/6/13.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface HQLoadTool : NSObject<UIAlertViewDelegate>

+(void)appkey;
+(void)loading;
+(void)version;
@end
