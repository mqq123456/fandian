//
//  HQHttpTool.m
//  normandy
//
//  Created by user on 15/6/1.
//  Copyright (c) 2015年 qianqiangmen. All rights reserved.
//

#import "HQHttpTool.h"
#import "AFNetworking.h"
#import "NewGTMBase64.h"
#import "HQDefaultTool.h"
#import "NSData+Encrption.h"
#import "SVProgressHUD.h"
@implementation HQHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
//    // 设置超时时间
//    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    mgr.requestSerializer.timeoutInterval = 10.f;
//    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    // 2.发送请求
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSString *responseString = @"";
            if (((NSData*)responseObject).length) {
                responseString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            }
            
            NSString *decryptString=[[NSString alloc] initWithData:[[NewGTMBase64 decodeString:responseString] AES256DecryptWithKey:[HQDefaultTool getKey]] encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [self dictionaryWithJsonString:decryptString];
            success(dict);
            
        }
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
           // [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        [SVProgressHUD showImage:nil status:@"数据获取失败！"];
        return nil;
    }
    return dic;
}

//+ (void)post2:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
//{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setTimeoutInterval:300];
//   
//    
//    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *responseString = @"";
//        if (((NSData*)responseObject).length) {
//            responseString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//        }
//        
//        NSDictionary* responseDic = nil;
//        NSString *decryptString=[[NSString alloc] initWithData:[[NewGTMBase64 decodeString:responseString] AES256DecryptWithKey:[HQDefaultTool getKey]] encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",decryptString);
//        
////        [self requestFinished:(AFBBtreeBaseResponseSerializer*)operation.responseSerializer requestObject:responseObject];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@",[error description]);
//    }];
//    
//}

@end
