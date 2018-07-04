//
//  IAKeychainWrapper.h
//  iiappleSDK
//
//  Created by stefan on 14-7-10.
//  Copyright (c) 2014年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface IAKeychainWrapper : NSObject
{
    NSMutableDictionary        *keychainData;
    NSMutableDictionary        *genericPasswordQuery;
}

@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)resetKeychainItem;

@end
