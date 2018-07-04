//
//  ApiParseBase.m
//  poem
//
//  Created by Apple on 15/1/13.
//  Copyright (c) 2015年 wohlink. All rights reserved.
//

#import "ApiParseBase.h"
#import "HQDefaultTool.h"

@implementation ApiParseBase

@synthesize uuid;
@synthesize url;
@synthesize params;
@synthesize datas;

-(ApiParseBase *)init
{
    self =[super init];
    uuid=[HQDefaultTool getUuid];//应该从default里取
    url=[NSString stringWithFormat:@"%@%@%@",API_HTTP,API_HOST,API_VERSION];
    params=[[NSMutableDictionary alloc]init];
    params[@"uuid"]=uuid;
    params[@"ios_arm64_flag"] = @"1";
    datas=[[NSMutableDictionary alloc]init];
    return self;
}

-(id)requestData:(id)reqData
{
    return nil;
}

-(id)parseData:(id)resultData
{
    return nil;
}

@end
