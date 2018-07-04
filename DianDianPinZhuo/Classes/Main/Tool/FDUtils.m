//
//  FDUtils.m
//  OOMall
//
//  Created by ZhangJL on 15/5/26.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

#import "FDUtils.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <AVFoundation/AVFoundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "sys/utsname.h"
#define recourcesPath [[NSBundle mainBundle] resourcePath]

@implementation FDUtils

+ (UIColor*)colorWithInt:(NSInteger)colorValue alpha:(float) a{
    unsigned r = (colorValue&0x00ff0000)>>16;
    unsigned g = (colorValue&0x0000ff00)>>8;
    unsigned b = colorValue&0x000000ff;
    UIColor* color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha: a];
    return color;
}


//以tag为替换strSrc中所有的sub
+ (NSString*)Repleace:(NSString*)strSrc allsubStr:(NSString*) sub with:(NSString*) tag{
    if (strSrc == nil || [strSrc isEqual:[NSNull null]]) {
        return @"";
    }
    NSMutableString* resStr = [NSMutableString stringWithString:strSrc];
    NSRange range = [resStr rangeOfString:sub];
    while (range.length > 0) {
        [resStr replaceCharactersInRange:range withString:tag];
        range = [resStr rangeOfString:sub];
    }
    return resStr;
}

+ (UILabel*)createLabel:(NSString*)label withTextColor:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize withBackColor:(UIColor *)bgcolor numberOfLines:(NSInteger)lines with:(NSTextAlignment)type{
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[UIFont systemFontOfSize:fontsize]];
    [label1 setBackgroundColor:bgcolor];
    [label1 setTextColor:corlor];
    label1.numberOfLines = lines;
    label1.textAlignment = type;
    
    return label1;
}

+ (UILabel*)createMoreLineLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize{
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[UIFont systemFontOfSize:fontsize]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    label1.numberOfLines = 0;
    //    [label1 autorelease];
    return label1;
}

+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize{
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    [label1 setText:label];
    [label1 setFont:[UIFont systemFontOfSize:fontsize]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    label1.numberOfLines = 0;
    //    - (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(NSStringDrawingContext *)context
    //    [label1 autorelease];
    return label1;
}

//创建单行label，宽度根据字符串和字体大小自动适应
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [label sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [FDUtils textSizeWithString:label withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [label1 setText:label];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    //    [label1 autorelease];
    return label1;
}

+ (UILabel*)createsgLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [label sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [FDUtils textSizeWithString:label withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [label1 setText:label];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    //    [label1 autorelease];
    return label1;
}
//创建多行label,指定宽度与左上角，根据内容控制高度
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint) topleft with:(int) width with:(int)fontsize{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [label sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    CGSize titleSize = [FDUtils textSizeWithString:label width:width withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, width, titleSize.height)];
    [label1 setText:label];
    [label1 setFont:font];
    [label1 setNumberOfLines:0];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    //    [label1 autorelease];
    return label1;
}
//创建多行label,指定宽度与左上角，根据内容控制高度
+ (UILabel*) createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint) topleft with:(int) width with:(NSTextAlignment)type with:(int)fontsize{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    CGSize titleSize = [FDUtils textSizeWithString:label width:width withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, width, titleSize.height)];
    [label1 setTextAlignment:type];
    [label1 setText:label];
    [label1 setFont:font];
    [label1 setNumberOfLines:0];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:corlor];
    //    [label1 autorelease];
    return label1;
}

+ (UILabel*) createLabel:(CGRect)rect with: (UIColor*)color with: (CGFloat) radius
{
    UILabel* lable = [[UILabel alloc]initWithFrame:rect];
    
    [lable setBackgroundColor:color];
    lable.layer.cornerRadius = radius;
    //    [lable autorelease];
    
    return lable;
}

+ (UILabel*) createLabel:(NSString *)labText  withOtTextArray:(NSArray*)otArray withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont withWidth:(CGFloat)lWidth
{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [labText sizeWithFont:font constrainedToSize:CGSizeMake(lWidth, 2000.0f)];
    CGSize titleSize = [FDUtils textSizeWithString:labText width:lWidth withFontSize:fontsize];
    //    if (ISIOS7ORLATER) {
    //        titleSize = [labText boundingRectWithSize:options:NSStringDrawingTruncatesLastVisibleLine attributes: context:];
    //    }
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [label1 setText:labText];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:textClr];
    if ([FDUtils getIOSVersion] >= 6.0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label1.attributedText];
        //        NSArray* array = [NSArray arrayWithObjects:day, hour, min, nil];
        for (int i = 0; i < otArray.count; i++) {
            NSRange range = [labText rangeOfString:[otArray objectAtIndex:i]];
            if (range.location!=NSNotFound) {
                NSInteger location = range.location;
                NSInteger lenght = range.length;
                [attributedString addAttribute:NSForegroundColorAttributeName value:OtClr range:NSMakeRange(location, lenght)];      //这里设置字体颜色不同的地方
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otFont] range:NSMakeRange(location, lenght)];
            }
        }
        [label1 setAttributedText:attributedString];
        label1.numberOfLines = 0;
        //自动折行设置
        label1.lineBreakMode = NSLineBreakByWordWrapping;
        attributedString = nil;
    }
    //    [label1 autorelease];
    return label1;
}

+ (UILabel*) createlastTimeLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont
{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [labText sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [FDUtils textSizeWithString:labText withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, 20)];
    [label1 setText:labText];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:textClr];
    if ([FDUtils getIOSVersion] >= 6.0) {
        NSString* day = @"天";
        NSString* hour = @"小时";
        NSString* min = @"分";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label1.attributedText];
        NSArray* array = [NSArray arrayWithObjects:day, hour, min, nil];
        for (int i = 0; i < array.count; i++) {
            NSRange range = [labText rangeOfString:[array objectAtIndex:i]];
            if (range.location!=NSNotFound) {
                NSInteger location = range.location;
                NSInteger lenght = range.length;
                [attributedString addAttribute:NSForegroundColorAttributeName value:OtClr range:NSMakeRange(location, lenght)];      //这里设置字体颜色不同的地方
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otFont] range:NSMakeRange(location, lenght)];
            }
        }
        [label1 setAttributedText:attributedString];
        attributedString = nil;
    }
    //    [label1 autorelease];
    return label1;
}
+ (UILabel*) createLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont
{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [labText sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [FDUtils textSizeWithString:labText withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, 20)];
    [label1 setText:labText];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:textClr];
    if ([FDUtils getIOSVersion] >= 6.0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label1.attributedText];
        [attributedString addAttribute:NSForegroundColorAttributeName value:OtClr range:NSMakeRange(0, 1)];      //这里设置字体颜色不同的地方
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otFont] range:NSMakeRange(0, 1)];
        NSString *string2 = @"-";
        NSRange range = [labText rangeOfString:string2];
        if (range.location!=NSNotFound) {
            NSInteger location = range.location;
            NSInteger lenght = range.length;
            [attributedString addAttribute:NSForegroundColorAttributeName value:OtClr range:NSMakeRange(location, lenght)];      //这里设置字体颜色不同的地方
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otFont] range:NSMakeRange(location, lenght)];
        }
        [label1 setAttributedText:attributedString];
        attributedString = nil;
    }
    
    //    [label1 autorelease];
    return label1;
}

+ (UILabel*) createLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(NSInteger)fontsize withOtherFont:(CGFloat)otFont wiDivStr:(NSString*)divStr
{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    CGSize titleSize = [FDUtils textSizeWithString:labText withFontSize:fontsize];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [label1 setText:labText];
    [label1 setFont:font];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTextColor:textClr];
    if ([FDUtils getIOSVersion] >= 6.0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label1.attributedText];
        NSRange range = [labText rangeOfString:divStr];
        if (range.location!=NSNotFound) {
            NSInteger location = range.location;
            [attributedString addAttribute:NSForegroundColorAttributeName value:OtClr range:NSMakeRange(0, location)];      //这里设置字体颜色不同的地方
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otFont] range:NSMakeRange(0, location)];
        }
        [label1 setAttributedText:attributedString];
        attributedString = nil;
    }
    
    //    [label1 autorelease];
    return label1;
}

+ (CGSize)textSizeWithString:(NSString*)strText withFontSize:(CGFloat)fontSize
{
    if ([FDUtils getIOSVersion] < 7.0) {
        UIFont* font = [UIFont systemFontOfSize: fontSize];
        CGRect rect= [([FDUtils isAvailableStr:strText] ? strText : @"") boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];

        return rect.size;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:strText] ? strText : @"") attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize;
    }
}

+ (CGSize)textSizeWithString:(NSString*)strText width:(CGFloat)tWidth withFontSize:(CGFloat)fontSize
{
    //    if ([FDUtils getIOSVersion] < 7.0) {
    //        UIFont* font = [UIFont systemFontOfSize: fontSize];
    //        CGSize titleSize = [([FDUtils isAvailableStr:strText] ? strText : @"") sizeWithFont:font constrainedToSize:CGSizeMake(tWidth, CGFLOAT_MAX)];
    //        return titleSize;
    //    }else{
    //
    //        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:strText] ? strText : @"") attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
    //
    //        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){tWidth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    //        //Constrain to integers
    //        textSize.width = ceilf(textSize.width);
    //        textSize.height = ceilf(textSize.height);
    //        return textSize;
    //    }
    return [FDUtils textSizeWithString:strText width:tWidth withFontName:nil size:fontSize];
}

+ (CGSize)textSizeWithString:(NSString*)strText width:(CGFloat)tWidth withFontName: (NSString *)fontName size:(CGFloat)fontSize
{
    UIFont *font = nil;
    if (![FDUtils isAvailableStr:fontName]) {
        font = [UIFont systemFontOfSize:fontSize];
    }else {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    if ([FDUtils getIOSVersion] < 7.0) {
        CGRect rect= [([FDUtils isAvailableStr:strText] ? strText : @"") boundingRectWithSize:CGSizeMake(tWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];

        return rect.size;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:strText] ? strText : @"") attributes:@{NSFontAttributeName : font}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){tWidth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize;
    }
}

+ (CGFloat)textLengthWith:(NSString*)labText withFontSize:(CGFloat)fontSize
{
    if ([FDUtils getIOSVersion] < 7.0) {
        UIFont* font = [UIFont systemFontOfSize: fontSize];

        CGRect rect= [([FDUtils isAvailableStr:labText] ? labText : @"") boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.width;
        
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:labText] ? labText : @"") attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.width;
    }
}

+ (CGFloat)textHeightWith:(NSString*)labText labWidth:(CGFloat)lWidth withBoldFontSize:(CGFloat)fontSize
{
    if ([FDUtils getIOSVersion] < 7.0) {
        UIFont* font = [UIFont boldSystemFontOfSize: fontSize];

        CGRect rect= [([FDUtils isAvailableStr:labText] ? labText : @"") boundingRectWithSize:CGSizeMake(lWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.width;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:labText] ? labText : @"") attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){lWidth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.height;
    }
}

+ (CGFloat)textLengthWith:(NSString*)labText withBoldFontSize:(CGFloat)fontSize
{
    if ([FDUtils getIOSVersion] < 7.0) {
        UIFont* font = [UIFont boldSystemFontOfSize: fontSize];

        CGRect rect= [([FDUtils isAvailableStr:labText] ? labText : @"") boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.width;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:labText] ? labText : @"") attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.width;
    }
}

+ (CGFloat)textHeightWith:(NSString *)string width:(CGFloat)tWidth withFontSize:(CGFloat)fontSize
{
    if ([FDUtils getIOSVersion] < 7.0) {
        UIFont* font = [UIFont systemFontOfSize: fontSize];
   
        CGRect rect= [([FDUtils isAvailableStr:string] ? string : @"") boundingRectWithSize:CGSizeMake(tWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.height;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:string] ? string : @"") attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){tWidth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.height;
    }
}
+ (CGFloat)textHeightWith:(NSString *)string width:(CGFloat)tWidth withFontName: (NSString *)fontName fontSize:(CGFloat)fontSize
{
    UIFont *font = nil;
    if (![FDUtils isAvailableStr:fontName]) {
        font = [UIFont systemFontOfSize:fontSize];
    }else {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    
    if ([FDUtils getIOSVersion] < 7.0) {

        CGRect rect= [([FDUtils isAvailableStr:string] ? string : @"") boundingRectWithSize:CGSizeMake(tWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        return rect.size.height;
    }else{
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:([FDUtils isAvailableStr:string] ? string : @"") attributes:@{NSFontAttributeName : font}];
        
        CGSize textSize = [attributedString boundingRectWithSize:(CGSize){tWidth, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //Constrain to integers
        textSize.width = ceilf(textSize.width);
        textSize.height = ceilf(textSize.height);
        return textSize.height;
    }
}



+ (BOOL)isAvailableStr:(id)obj
{
    if (obj && ![obj isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

//创建按钮，为文字和字体确定按钮的宽度和高度
+ (UIButton*) createButton:(NSString*)title with:(UIColor*)corlor in:(CGPoint) topleft with:(int)fontsize{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    //    CGSize titleSize = [title sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    CGSize titleSize = [FDUtils textSizeWithString:title withFontSize:fontsize];
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, [font lineHeight] + 2)];
    [btn.titleLabel setFont:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:corlor forState:UIControlStateNormal];
    return btn;
}
//创建按钮，以背景图片的大小确定按钮的宽度和高度
+ (UIButton*) createButton:(NSString*)title with:(UIColor*)corlor in:(CGPoint) topleft with:(int)fontsize with:(NSString*)bgImage{
    UIFont* font = [UIFont systemFontOfSize: fontsize];
    UIImage* image = [UIImage imageNamed:bgImage];
    CGSize titleSize = image.size;
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:corlor forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    return btn;
}

+ (UIButton*) createButton:(NSString*)bgImage hlImage:(NSString*)hlBgImage in:(CGPoint) topleft{
    UIImage* image = [UIImage imageNamed:bgImage];
    CGSize titleSize = image.size;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(topleft.x , topleft.y, titleSize.width, titleSize.height)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if (hlBgImage && [hlBgImage length] > 0) {
        UIImage* hBg = [UIImage imageNamed:hlBgImage];
        [btn setBackgroundImage:hBg forState:UIControlStateHighlighted];
    }
    return btn;
}

+(UIImageView*) createImageView:(NSString*) imageName in:(CGPoint) topleft{
    UIImage* image = [UIImage imageNamed:imageName];
    UIImageView* view = [[UIImageView alloc] initWithImage:image];
    [view setFrame:CGRectMake(topleft.x, topleft.y, image.size.width, image.size.height)];
    return view;
}

+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage*)imageWithName:(NSString*)imgName
{
    NSString* path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@",imgName] ofType:@"png" ];
    UIImage *  tempImage = [UIImage imageWithContentsOfFile:path];
    if (tempImage == nil) {
        path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@@2x",imgName] ofType:@"png"];
        tempImage = [UIImage imageWithContentsOfFile:path];
    }
    return tempImage;
}

+ (UIImage*)imageWithName:(NSString*)imgName ofType:(NSString*)type
{
    NSString* path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@",imgName] ofType:type];
    UIImage *  tempImage = [UIImage imageWithContentsOfFile:path];
    if (tempImage == nil) {
        path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@@2x",imgName] ofType:type];
        tempImage = [UIImage imageWithContentsOfFile:path];
    }
    return tempImage;
}

// 电话号和人名加密
+(NSString*) encodeAsByte:(NSString*) val
{
    NSMutableString* sb =  [NSMutableString string];
    const char* utf8 = [val UTF8String];
    
    while (*utf8 != '\0') {
        int temp = *utf8;
        NSMutableString* ch = [NSMutableString string];
        if (temp < 0) {
            NSString* content = [NSString stringWithFormat:@"%d", -temp];
            [ch appendFormat:@"%d",1];
            [ch appendFormat:@"%ld",(unsigned long)content.length];
            [ch appendString:content];
        }else{
            NSString* content = [NSString stringWithFormat:@"%d", temp];
            [ch appendFormat:@"%d",0];
            [ch appendFormat:@"%ld",(unsigned long)content.length];
            [ch appendString:content];
        }
        [sb appendString:ch];
        utf8++;
    }
    return sb;
}

+ (BOOL) isTimeOverNow:(NSString*)time
{
    BOOL isOver;
    long long times = [time longLongValue];
    times = (times/1000);
    NSDate* homeTime = [NSDate date];
    long long times2 = [homeTime timeIntervalSince1970];
    times = times - times2;
    if (times <= 0) {
        isOver = YES;
    }else{
        isOver = NO;
    }
    return isOver;
}

+(NSString*) timeFormatWithSecond:(CGFloat) time{//time秒
    NSInteger times = (NSInteger)time;
    if (times > 0) {
        NSInteger hour = (times/(60*60))%24;
        NSInteger minute = (times/60)%60;
        NSInteger second = times % 60;
        NSString* minStr = (minute >= 10) ? [NSString stringWithFormat:@"%ld",(long)minute] : [NSString stringWithFormat:@"0%ld",(long)minute];
        NSString* secStr = (second >= 10) ? [NSString stringWithFormat:@"%ld",(long)second] : [NSString stringWithFormat:@"0%ld",(long)second];
        if (hour > 0 ) {
            NSString* hourStr = (hour >= 10) ? [NSString stringWithFormat:@"%ld",(long)hour] : [NSString stringWithFormat:@"0%ld",(long)hour];
            return [NSString stringWithFormat:@"%@:%@:%@",hourStr,minStr,secStr];
        }else{
            return [NSString stringWithFormat:@"%@:%@",minStr,secStr];
        }
    }
    return @"00:00";
}

+(NSString*) timeFormat:(NSString*) time{//time毫秒
    long long times = [time longLongValue];
    times = (times/1000);
    NSDate* homeTime = [NSDate date];
    long long times2 = [homeTime timeIntervalSince1970];
    times = times - times2;
    if (times > 0) {
        long long int day = times/(24*60*60);
        long long int hour = (times/(60*60))%24;
        long long int minute = (times/60)%60;
        if (day > 0 || hour > 0 || minute > 0) {
            return [NSString stringWithFormat:@"剩:%lld天%lld小时%lld分", day, hour, minute];
        }
    }
    return @"";
}

+(NSString*) finalTimeLastFormat:(NSString*)time{
    long long times = [time longLongValue];
    NSMutableString* lastTimeStr = [NSMutableString string];
    times = (times/1000);
    NSDate* homeTime = [NSDate date];
    long long times2 = [homeTime timeIntervalSince1970];
    times = times - times2;
    if (times > 0) {
        long long int day = times/(24*60*60);
        long long int hour = (times/(60*60))%24;
        long long int minute = (times/60)%60;
        //        if (day > 0 || hour > 0 || minute > 0) {
        //            return [NSString stringWithFormat:@"剩:%lld天%lld小时%lld分", day, hour, minute];
        //        }
        //        [lastTimeStr appendFormat:@"🕑"];
        if (day >0) {
            [lastTimeStr appendFormat:@"%lld天",day];
        }
        if (day > 0) {
            [lastTimeStr appendFormat:@"%lld小时%lld分", hour, minute];
        }else{
            if (hour > 0 || minute > 0) {
                [lastTimeStr appendFormat:@"%lld小时%lld分", hour, minute];
            }
        }
    }
    return lastTimeStr;
}

+(NSDictionary*) subOfDictionary:(NSDictionary*) parentDic withItems:(NSArray*) keys{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < [keys count]; i++) {
        NSString* key = [keys objectAtIndex:i];
        [dic setObject: [parentDic objectForKey:key] forKey:key];
    }
    return dic;
}

+ (NSString*)dateStringWith:(NSString*)timeCode
{
    if (timeCode == nil || [timeCode length] < 10) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* str = [timeCode substringToIndex:10];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    //NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}

+ (NSString*) GetDateFormat:(NSDate*) date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * components = [gregorian components: NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate: date];
    NSMutableString* month = [NSMutableString stringWithFormat:@"%ld", (long)[components month]];
    if (month.length == 1) {
        [month insertString:@"0" atIndex:0];
    }
    NSMutableString* day = [NSMutableString stringWithFormat:@"%ld", (long)[components day]];
    if (day.length == 1) {
        [day insertString:@"0" atIndex:0];
    }
    NSMutableString* hour = [NSMutableString stringWithFormat:@"%ld", (long)[components hour]];
    if (hour.length == 1) {
        [hour insertString:@"0" atIndex:0];
    }
    NSMutableString* minute = [NSMutableString stringWithFormat:@"%ld", (long)[components minute]];
    if (minute.length == 1) {
        [minute insertString:@"0" atIndex:0];
    }
    NSString* dateFrmat = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@", (long)[components year], month, day , hour, minute];
    return dateFrmat;
}

+ (BOOL)phoneCheck:(NSString*)mobileNum{
    if (!mobileNum || [mobileNum isEqual:[NSNull null]] || mobileNum.length == 0) {
        return NO;
    }
    NSString* MOBILE = @"^1\\d{10}$";
    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isMobileNumberll:(NSString*)mobileNum
{
    /**
     *
     手机号码
     *
     移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     *
     联通：130,131,132,152,155,156,185,186
     *
     电信：133,1349,153,180,189,181,
     */
    
    NSString* MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0125-9])\\d{8}$";
    
    /**
     *
     中国移动：China Mobile
     *
     134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    
    NSString* CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     *
     中国联通：China Unicom
     *
     130,131,132,152,155,156,185,186
     */
    
    NSString* CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     *
     中国电信：China Telecom
     *
     133,1349,153,180,189
     */
    
    NSString* CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString* NEW = @"^1(4[57]|8[0-35-9])\\d{8}$";
    
    /**
     *
     大陆地区固话及小灵通
     *
     区号：010,020,021,022,023,024,025,027,028,029
     *
     号码：七位或八位
     */
    //NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate* newmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",NEW];
    NSPredicate*regextestcm
    = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    
    NSPredicate*regextestcu
    = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    NSPredicate*regextestct
    = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)||
       ([regextestcm evaluateWithObject:mobileNum] == YES)||
       ([regextestct evaluateWithObject:mobileNum] == YES)||
       ([regextestcu evaluateWithObject:mobileNum] == YES)||
       [newmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*)uidStringForDevice
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (BOOL)isLoginPasswordOK:(NSString *)passWord
{
    int strlength = 0;
    if (!passWord || [passWord isEqual:[NSNull null]] || passWord.length == 0) {
        return NO;
    }
    char* p = (char*)[passWord cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[passWord lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    //    return strlength;
    if (strlength >= 6 && strlength <= 16) {
        return YES;
    }
    return NO;
}

+ (BOOL)isStrA:(NSString*)A containStrB:(NSString*)B
{
    NSRange range = [A rangeOfString:B];
    if (range.location!=NSNotFound) {
        return YES;
    }
    return NO;
}

//利用正则表达式验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//通过区分字符串

+ (BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        /*
         *使用compare option 来设定比较规则，如
         *NSCaseInsensitiveSearch是不区分大小写
         *NSLiteralSearch 进行完全比较,区分大小写
         *NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
         */
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else {
        return NO;
    }
}
//校验用户密码
+ (BOOL)isUserPasswd:(NSString *)str
{
    NSRegularExpression *regularexpression =[[NSRegularExpression alloc]initWithPattern:@"^[a-zA-Z0-9]{6,16}$"  options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isConnectedToInternetOK
{
    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    /**
     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
     *
     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
     *  第一个参数可以为NULL或kCFAllocatorDefault
     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
     *  同时返回一个引用必须在用完后释放.
     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
     *  第二个参数比如为"www.apple.com",其他和上一个一样.
     *
     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
     *  第一个参数为之前建立的测试连接的引用,
     *  第二个参数用来保存获得的状态,
     *  如果能获得状态则返回TRUE，否则返回FALSE
     *
     */
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flagsn");
        return NO;
    }
    
    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


+(void) writecontent:(NSString*)content toFile:(NSString*) file{
    if (content == nil) {
        return;
    }
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    //定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    
    //查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:4];
    [dic setObject:content forKey:@"key"];
    [dic writeToFile:filePath atomically:YES];
}

+(NSString*) readFromFile:(NSString*)fileName  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //获取文件路径
    NSString *pathll = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSMutableDictionary* dictl = [[NSMutableDictionary alloc]initWithContentsOfFile:pathll];
    //    NSLog(@"%@",dictl);
    NSString* str = nil;
    if ([dictl objectForKey:@"key"]) {
        str = [dictl objectForKey:@"key"];
    } else {
        str = @"";
    }
    return str;
}

+(UIImage*) imageOfView:(UIView*) view isRetain:(BOOL) retain{
    float scale = 1.0;
    if (retain == YES) {
        scale = 2.0;
    }
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);  //NO，YES 控制是否透明
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



+ (NSString*)jsonWithId:(id)obj
{
    NSError *error = nil;
    if (!obj) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0  && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

#pragma  mark - timeStamp
+ (NSString*)currentTimeInMicMSecond
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    return time;
}

+ (NSString*)currentTimeStamp{
    NSDate* date = [NSDate date];
    long long unsigned micSecond = [date timeIntervalSince1970];
    micSecond *= 1000;
    //    micSecond += 60*60*1000*8;
    NSString* time = [NSString stringWithFormat:@"%llu", micSecond];
    return time;
}

+ (NSString*)currentTimeStampInSecond
{
    NSDate* date = [NSDate date];
    long long unsigned micSecond = [date timeIntervalSince1970];
    //    micSecond += 60*60*1000*8;
    NSString* time = [NSString stringWithFormat:@"%llu", micSecond];
    return time;
}

+ (NSInteger)timeInMSecond
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    NSString* seconddd = [time substringFromIndex:8];
    NSInteger hh = [[seconddd substringToIndex:2] integerValue];
    NSInteger mm = [[[seconddd substringFromIndex:2] substringToIndex:2] integerValue];
    NSInteger second = [[seconddd substringFromIndex:4] integerValue] + mm * 60000  + hh * 3600000;
    return second;
}

- (int)textLength:(NSString *)text//计算字符串长度
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}

+ (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets withImage:(UIImage*)img
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *image = nil;
    if (systemVersion >= 6.0) {
        image = [img resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
        img = nil;
        return image;
    }else if (systemVersion >= 5.0) {
        image = [img resizableImageWithCapInsets:capInsets];
        img = nil;
        return image;
    }
    image = [img stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    img = nil;
    return image;
}

+ (UIImage*)imageStretchWithImage:(NSString*)imgName withCapInsets:(UIEdgeInsets)capInsets withStretchMode:(UIImageResizingMode)resizingMode
{
    UIImage* image = [UIImage imageNamed:imgName];
    image = [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    return image;
}

//1.等比率縮放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toHeight:(CGFloat)height
{
    CGSize oSize = image.size;
    CGFloat scale = height / oSize.height;
    UIImage* rImage = [FDUtils scaleImage:image toScale:scale];
    return rImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toWidth:(CGFloat)width
{
    CGSize oSize = image.size;
    CGFloat scale = width / oSize.width;
    UIImage* rImage = [FDUtils scaleImage:image toScale:scale];
    return rImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(CGSizeMake(newSize.width, newSize.height));
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
#pragma mark - 动画

+ (void)fadeIn: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait
{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [view setAlpha:0.0];
    [UIView animateWithDuration:duration animations:^{
        [view setAlpha:1.0];
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (CGSize)sizeOfImageNamed:(NSString*)imageName
{
    return [UIImage imageNamed:imageName].size;
}

+ (CGFloat)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString*)iosSysVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString*)getDeviceScreenInfo
{
    CGSize size = [[UIScreen mainScreen]bounds].size;
    return [NSString stringWithFormat:@"%3.0f*%3.0f",size.width,size.height];
}

+ (NSString*)deviceInfo
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];

    return app_Name;
}


//设备名称号
+ (NSString*)getMachine{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* allName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString* mName = [[allName componentsSeparatedByString:@","] firstObject];
    return mName;
    //    UIDevice* device = [UIDevice currentDevice];
    //    return [device localizedModel];
}

+ (BOOL)isIphone4
{
    if ([[FDUtils getMachine] isEqualToString:@"iPhone3"] || [[FDUtils getMachine]isEqualToString:@"iPhone4"]) {
        return YES;
    }
    return NO;
}

+ (NSString*)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    CFShow(CFBridgingRetain(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage*)ImageStretchWithImage:(NSString*)imgName withCapInsets:(UIEdgeInsets)capInsets withStretchMode:(UIImageResizingMode)resizingMode
{
    UIImage* image = [UIImage imageNamed:imgName];
    image = [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    return image;
}

#pragma mark-十六进制转化为字符串
+ (NSString*)stringWithHex:(NSInteger)hexValue
{
    return [NSString stringWithFormat:@"%lX",(long)hexValue];
}

#pragma mark - 字符串转化为十六进制数
+ (NSInteger)hexValueWithStr:(NSString*)hexStr
{
    hexStr = [FDUtils Repleace:hexStr allsubStr:@"#" with:@""];
    NSInteger hexValue = strtoul([hexStr UTF8String],0,16);
    //    Log(@"转换完的数字为：%x",hexValue);
    return hexValue;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)colorStr
{
    if (colorStr == nil || ([colorStr isEqual:[NSNull null]]) || colorStr.length == 0) {
        colorStr = @"ffffff";
    }
    NSInteger colorValue = [FDUtils hexValueWithStr:colorStr];
    return [FDUtils colorWithInt:colorValue alpha:1];
}


#pragma mark - UIColor转化为NSString
+ (NSString *) hexFromUIColor: (UIColor*) colorS {
    if (CGColorGetNumberOfComponents(colorS.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(colorS.CGColor);
        colorS = [UIColor colorWithRed:components[0]
                                 green:components[0]
                                  blue:components[0]
                                 alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(colorS.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(colorS.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(colorS.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(colorS.CGColor))[2]*255.0)];
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic) {
        return @"";
    }
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (BOOL)createDirIfDirIsNotExistWith:(NSString*)dirName byDir:(NSString*)baseDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (baseDir != nil && baseDir.length > 0) {
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:baseDir];
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbDir = [documentsDirectory stringByAppendingPathComponent:dirName];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:dbDir isDirectory:&isDir];
    if (isDir && isExist) {
        return YES;
    }else{
        if ([fileManager createDirectoryAtPath:dbDir withIntermediateDirectories:YES attributes:nil error:nil]) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (void)setDotBorderForView:(UIView*)theView
{
    [theView.layer setBorderWidth:1.0];
    [theView.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"layerImg.png"]] CGColor]];
}

+ (BOOL)fileInDocDirWithDir:(NSString*)dir withName:(NSString*)FName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbDir = [documentsDirectory stringByAppendingPathComponent:dir];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:dbDir isDirectory:&isDir];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",dbDir, FName];
    if (isDir && isExist) {
        BOOL isFExist = [fileManager isExecutableFileAtPath:filePath];
        if (isFExist) {
            return YES;
        }else{
            if ([fileManager createFileAtPath:filePath contents:nil attributes:nil]) {
                return YES;
            }else{
                return NO;
            }
        }
    }else{
        if ([fileManager createDirectoryAtPath:dbDir withIntermediateDirectories:YES attributes:nil error:nil]) {
            if ([fileManager createFileAtPath:filePath contents:nil attributes:nil]) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }
}

+ (BOOL)deleteFileWithPath:(NSString*)filePath
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        if ([fileManager removeItemAtPath:filePath error:nil]) {
            return YES;
        }
        return NO;
    }
    return YES;
}
+ (BOOL)isArrayOrg:(NSArray*)orgArray containtObjInAimArray:(NSArray*)aimArray
{
    for (NSInteger i = 0; i < aimArray.count; i++) {
        id obj = [aimArray objectAtIndex:i];
        if ([orgArray containsObject:obj]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isUserLogin
{
    //    NSString* status = [[NSUserDefaults standardUserDefaults] objectForKey:SGK_ISLOGIN];
    //    if (status && ![status isEqual:[NSNull null]] && [status intValue] == 1) {
    //        return YES;
    //    }
    return NO;
}

+ (BOOL)isFUseCamera
{
    if ([FDUtils getIOSVersion] < 8.0) {
        return NO;
    }
    NSString *mType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mType];
    if(authStatus == AVAuthorizationStatusNotDetermined){
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        return YES;
    }
    return NO;
}

+ (BOOL)isCameraOK
{
    if ([FDUtils getIOSVersion] < 8.0) {
        return YES;
    }
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    //    NSLog(@"---cui--authStatus--------%ld",authStatus);
    // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
    if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        //        NSLog(@"Authorized");
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isFUsePhotos
{
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPhotoOK
{
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNetOK
{
    BOOL isOK = YES;
    isOK = [[[NSUserDefaults standardUserDefaults]objectForKey:KSGKNetConnectOK] boolValue];
    return isOK;
}


+ (NSNumber *)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}
+ (NSNumber *)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}
+(NSString*)modifyPathExtensionWithPath:(NSString*)path extension:(NSString*)extension{
    
    NSMutableString* mutablePath = [path mutableCopy];
    NSRange range = [mutablePath rangeOfString:@"." options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        NSInteger length = path.length - range.location;
        range.length = length;
        [mutablePath replaceCharactersInRange:range withString:extension];
    }
    return mutablePath;
}
+(UIView *)addNavBarView{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    return navView;
}
- (CALayer *)layerWithRadius:(CGFloat)radius centerX:(CGFloat)centerX centerY:(CGFloat)centerY{
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    layer.position = CGPointMake(centerX, centerY);
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 0.5;
    layer.cornerRadius = radius;
    
    return layer;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor 有透明度
+ (UIColor *) colorWithHexString: (NSString *)colorStr alpha:(CGFloat)a
{
    if (colorStr == nil || ([colorStr isEqual:[NSNull null]]) || colorStr.length == 0) {
        colorStr = @"ffffff";
    }
    NSInteger colorValue = [FDUtils hexValueWithStr:colorStr];
    return [FDUtils colorWithInt:colorValue alpha:a];
}

+ (UIColor *)navgationBarTintColor{
    
    return [UIColor grayColor];
    
}
@end
