//
//  WGApiParseProtocol.h
//  wohlook
//
//  Created by Apple on 14/8/20.
//  Copyright (c) 2014年 wohlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiParseProtocol <NSObject>
-(id)requestData:(id)reqModel;
-(id)parseData:(id)resultData;
@end
