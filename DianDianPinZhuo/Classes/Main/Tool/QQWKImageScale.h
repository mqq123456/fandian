//
//  QQWKImageScale.h
//  wohlook
//
//  Created by Apple on 14/9/27.
//  Copyright (c) 2014年 wohlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QQWKImageScale : NSObject

+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+(NSString *) image2Data: (UIImage *) image;
@end
