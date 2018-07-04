//
//  QQWKImageScale.m
//  wohlook
//
//  Created by Apple on 14/9/27.
//  Copyright (c) 2014年 wohlink. All rights reserved.
//

#import "QQWKImageScale.h"

@implementation QQWKImageScale
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        //NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        //NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString *) image2Data: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;

    if ([self imageHasAlpha: image]) {
            imageData = UIImagePNGRepresentation(image);
            mimeType = @"image/png";
        } else {
            imageData = UIImageJPEGRepresentation(image, 0.2);//后面是压缩比
            mimeType = @"image/jpeg";
        }
    
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
}

+(BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||alpha == kCGImageAlphaLast ||alpha == kCGImageAlphaPremultipliedFirst ||alpha == kCGImageAlphaPremultipliedLast);
}
+(UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )newSize

{
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext (newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    // Get the new image from the context
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    // End the context
    
    UIGraphicsEndImageContext ();
    
    // Return the new image.
    
    return newImage;
    
}

@end
