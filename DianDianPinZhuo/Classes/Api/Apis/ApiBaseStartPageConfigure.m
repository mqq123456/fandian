//
//  ApiBaseStartPageConfigure.m
//  DianDianPinZhuo
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "ApiBaseStartPageConfigure.h"
#import "ReqBaseStartPageConfigure.h"
#import "RespBaseStartPageConfigure.h"
#import "RequestModel.h"
#import "HQConst.h"

@implementation ApiBaseStartPageConfigure
-(RequestModel *)requestData:(ReqBaseStartPageConfigure *)reqModel
{


    [self.datas setSafeObject:reqModel.kid forKey:@"kid"];

    [self.params setSafeObject:self.datas forKey:@"data"];
    
    RequestModel *requestModel=[[RequestModel alloc]init];
    requestModel.url=[NSString stringWithFormat:@"%@%@",self.url,API_BASE_START_PAGE_CONFIGURE];
    requestModel.parameters=self.params;
    
    MQQLog(@"ReqBaseStartPageConfigure=%@",[self.datas description]);
    return requestModel;
}

-(RespBaseStartPageConfigure *)parseData:(id)resultData
{
    RespBaseStartPageConfigure *respModel=[[RespBaseStartPageConfigure alloc]init];
    if (resultData!=nil) {
        
        NSDictionary *head=[resultData safeObjectForKey:@"head"];
        respModel.code =[NSString stringWithFormat:@"%@",[head safeObjectForKey:@"code"]];
        respModel.desc =[head safeObjectForKey:@"desc"];
        
        if ([respModel.code isEqualToString:@"1"]) {
            NSDictionary *body = [resultData safeObjectForKey:@"body"];
            respModel.img = [body safeObjectForKey:@"img"];
            respModel.url = [body safeObjectForKey:@"url"];
            respModel.h5_title = [body safeObjectForKey:@"h5_title"];
            respModel.end_stamp = [body safeObjectForKey:@"end_stamp"];
        }
    }
    MQQLog(@"RespBaseStartPageConfigure=%@",[resultData description]);
    
    return respModel;
}

@end
