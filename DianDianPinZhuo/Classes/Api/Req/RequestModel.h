//
//  RequestModel.h
//  poem
//
//  Created by Apple on 15/1/13.
//  Copyright (c) 2015年 wohlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModel : NSObject

@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSMutableDictionary *parameters;

@end
