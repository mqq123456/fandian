//
//  NSMutableDictionary+Extension.m
//  DianDianPinZhuo
//
//  Created by user on 16/3/2.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)
-(void)setSafeObject:(id)obj forKey:(id)key{
    if (obj) {
        [self setObject:obj forKey:key];
    }
}
@end
