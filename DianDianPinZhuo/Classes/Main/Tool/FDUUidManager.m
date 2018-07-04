//
//  FDUUidManager.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDUUidManager.h"
#import "IAKeychainWrapper.h"
#import "NSDictionary+STSafeObject.h"

@implementation FDUUidManager

+ (instancetype)sharedManager {
    static FDUUidManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
        [_sharedManager initUserInfo];
    });
    
    return _sharedManager;
}

-(void)initUserInfo
{
    IAKeychainWrapper* helper=[[IAKeychainWrapper alloc] init];
    NSString* json=[helper myObjectForKey:(__bridge id)kSecValueData];
    
    if (json&&[json length]>0) {
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        
        self.imei=[dic safeObjectForKey:@"imei"];
        
    }
}

-(void)saveUserinfo
{
    IAKeychainWrapper* helper=[[IAKeychainWrapper alloc] init];
    
    NSMutableDictionary* dic=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (_imei) {
        [dic setObject:_imei forKey:@"imei"];
    }
    
  
    [helper mySetObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL] encoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
}


@end
