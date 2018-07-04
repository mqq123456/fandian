//
//  HQHttpTool.h
//  normandy
//
//  Created by user on 15/6/1.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQHttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
