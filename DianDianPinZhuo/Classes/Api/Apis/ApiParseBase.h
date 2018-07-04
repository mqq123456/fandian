//
//  ApiParseBase.h
//  poem
//
//  Created by Apple on 15/1/13.
//  Copyright (c) 2015年 wohlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiParseProtocol.h"
#import "ApiProtocol.h"
#import "NSData+Encrption.h"
#import "SBJsonWriter.h"
#import "NewGTMBase64.h"
#import "HQDefaultTool.h"
#import "NSDictionary+STSafeObject.h"
#import "NSMutableDictionary+Extension.h"

@interface ApiParseBase : NSObject<ApiParseProtocol,ApiProtocol>

///	获取appkey接口获取到的key值
@property (strong,nonatomic) NSString *uuid;
///url前缀
@property (strong,nonatomic) NSString *url;
///发起的参数
@property (strong,nonatomic) NSMutableDictionary *params;
///data消息体
@property (strong,nonatomic) NSMutableDictionary *datas;

@end
