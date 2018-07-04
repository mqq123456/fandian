//
//  FDUtils.h
//  OOMall
//
//  Created by ZhangJL on 15/5/26.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UIKit/UIKit.h>

#define KSGKNetConnectOK         @"sgkNetWorkConnectOK"


@interface FDUtils : NSObject


+ (UIColor*)colorWithInt:(NSInteger)colorValue alpha:(float)a;//rgb



//以tag为替换strSrc中所有的sub
+ (NSString*)Repleace:(NSString*)strSrc allsubStr:(NSString*)sub with:(NSString*)tag;


//+(UIImageView*) createImageView:(NSString*) name in:(CGPoint) topLeft;
+ (UILabel*)createLabel:(NSString*)label withTextColor:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize withBackColor:(UIColor *)bgcolor numberOfLines:(NSInteger)lines with:(NSTextAlignment)type;

//创建单行label，宽度根据字符串和字体大小自动适应
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize;
//创建多行label,指定宽度与左上角，根据内容控制高度
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)width with:(int)fontsize;
+ (UILabel*)createMoreLineLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize;
+ (UILabel*)createLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)width with:(NSTextAlignment)type with:(int)fontsize;
//创建按钮，为文字和字体确定按钮的宽度和高度
//创建label，指定位置大小 背景颜色，以及边缘圆角
+ (UILabel*)createLabel:(CGRect)rect with: (UIColor*)color with:(CGFloat)radius;
+ (UILabel*)createlastTimeLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont;
+ (UILabel*) createLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(NSInteger)fontsize withOtherFont:(CGFloat)otFont wiDivStr:(NSString*)divStr;
+ (UILabel*)createLabel:(NSString *)labText withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont;
+ (UILabel*) createLabel:(NSString *)labText  withOtTextArray:(NSArray*)otArray withTxCl:(UIColor *)textClr withOtherCl:(UIColor *)OtClr inPoint:(CGPoint)topleft withTextFont:(int)fontsize withOtherFont:(int)otFont withWidth:(CGFloat)lWidth;

+ (CGSize)textSizeWithString:(NSString*)strText withFontSize:(CGFloat)fontSize;
+ (CGSize)textSizeWithString:(NSString*)strText width:(CGFloat)tWidth withFontSize:(CGFloat)fontSize;
+ (CGSize)textSizeWithString:(NSString*)strText width:(CGFloat)tWidth withFontName: (NSString *)fontName size:(CGFloat)fontSize;

+ (CGFloat)textHeightWith:(NSString*)labText labWidth:(CGFloat)lWidth withBoldFontSize:(CGFloat)fontSize;
+ (CGFloat)textLengthWith:(NSString*)labText withFontSize:(CGFloat)fontSize;
+ (CGFloat)textHeightWith:(NSString *)string width:(CGFloat)tWidth withFontSize:(CGFloat)fontSize;
+ (CGFloat)textHeightWith:(NSString *)string width:(CGFloat)tWidth withFontName: (NSString *)fontName fontSize:(CGFloat)fontSize;

+ (CGFloat)textLengthWith:(NSString*)labText withBoldFontSize:(CGFloat)fontSize;

#pragma mark -- test
+ (UILabel*)createNormalLabel:(NSString*)label with:(UIColor*)corlor frame:(CGRect)rect with:(int)fontsize;
+ (UILabel*)createsgLabel:(NSString*)label with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize;

+ (UIButton*)createButton:(NSString*)title with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize;
//创建按钮，以背景图片的大小确定按钮的宽度和高度
+ (UIButton*)createButton:(NSString*)title with:(UIColor*)corlor in:(CGPoint)topleft with:(int)fontsize with:(NSString*)bgImage;

+ (UIButton*)createButton:(NSString*)bgImage hlImage:(NSString*)hlBgImage in:(CGPoint)topleft;

+ (UIImageView*)createImageView:(NSString*)imageName in:(CGPoint)topleft;
+ (NSDictionary*)subOfDictionary:(NSDictionary*)parentDic withItems:(NSArray*)keys;


+ (NSString*)dateStringWith:(NSString*)timeCode;//时间戳转换为可见时间
+ (BOOL)phoneCheck:(NSString*)mobileNum;//手机号码验证
+ (BOOL)isLoginPasswordOK:(NSString *)passWord;//密码长度验证
+ (BOOL)isValidateEmail:(NSString *)email;//邮箱验证
+ (BOOL)validateEmail:(NSString*)email;
+ (BOOL)isUserPasswd:(NSString*)str;
+ (BOOL)isStrA:(NSString*)A containStrB:(NSString*)B;
+ (NSString*) encodeAsByte:(NSString*) val;
//MD5加密
+ (NSString*)GetDateFormat:(NSDate*)date;
+ (BOOL)isConnectedToInternetOK;//联网判断

+ (void)writecontent:(NSString*)content toFile:(NSString*)file;
+ (NSString*)readFromFile:(NSString*)fileName ;

+ (UIImage*)imageOfView:(UIView*)view isRetain:(BOOL)retain;

//time
+ (NSString*)currentTimeInMicMSecond;
+ (NSString*)currentTimeStampInSecond;
+ (NSInteger)timeInMSecond;
+ (NSString*)currentTimeStamp;

+ (BOOL)isTimeOverNow:(NSString*)time;
+ (NSString*)timeFormatWithSecond:(CGFloat)time;
+ (NSString*)timeFormat:(NSString*) time;
+ (NSString*)finalTimeLastFormat:(NSString*)time;

+ (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets withImage:(UIImage*)img;
+ (UIImage *)imageStretchWithImage:(NSString*)imgName withCapInsets:(UIEdgeInsets)capInsets withStretchMode:(UIImageResizingMode)resizingMode;
+ (UIImage *)imageWithName:(NSString*)imgName;
+ (UIImage *)imageWithName:(NSString*)imgName ofType:(NSString*)type;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)scaleImage:(UIImage *)image toHeight:(CGFloat)height;
+ (UIImage *)scaleImage:(UIImage *)image toWidth:(CGFloat)width;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;
//+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)newSize;
+ (UIImage *)imageWithView:(UIView *)view;
+ (CGSize)sizeOfImageNamed:(NSString*)imageName;

+ (NSString*)jsonWithId:(id)obj;

#pragma mark - donghua
+ (void)fadeIn: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait;

+ (BOOL)isIphone4;
+ (NSString*)getMachine;
+ (CGFloat)getIOSVersion;
+ (NSString*)getDeviceScreenInfo;
+ (NSString*)iosSysVersion;
+ (NSString*)appVersion;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage*)ImageStretchWithImage:(NSString*)imgName withCapInsets:(UIEdgeInsets)capInsets withStretchMode:(UIImageResizingMode)resizingMode;


+ (NSString*)stringWithHex:(NSInteger)hexValue; //十六进制转化为字符串
+ (NSInteger)hexValueWithStr:(NSString*)hexStr; //字符串转化为十六进制数

+ (NSString*)uidStringForDevice;

//yueyue add
//UIColor转化为NSString
+ (NSString *) hexFromUIColor: (UIColor*) colorS;
//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)colorStr;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (void)setDotBorderForView:(UIView*)theView;
+ (BOOL)isAvailableStr:(id)obj;
//创建文件夹
+ (BOOL)createDirIfDirIsNotExistWith:(NSString*)dirName byDir:(NSString*)baseDir;
+ (BOOL)fileInDocDirWithDir:(NSString*)dir withName:(NSString*)FName;

+ (BOOL)deleteFileWithPath:(NSString*)filePath;

+ (BOOL)isArrayOrg:(NSArray*)orgArray containtObjInAimArray:(NSArray*)aimArray;
+ (BOOL)isUserLogin;

+ (BOOL)isFUseCamera;
+ (BOOL)isCameraOK;
+ (BOOL)isFUsePhotos;
+ (BOOL)isPhotoOK;
+ (BOOL)isNetOK;


//获取设备的总容量和可用容量

+(NSNumber *)totalDiskSpace;
+(NSNumber *)freeDiskSpace;

//修改路径的扩展名

+(NSString*)modifyPathExtensionWithPath:(NSString*)path extension:(NSString*)extension;
+(UIView *)addNavBarView;

- (CALayer *)layerWithRadius:(CGFloat)radius centerX:(CGFloat)centerX centerY:(CGFloat)centerY;

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor 有透明度
+ (UIColor *) colorWithHexString: (NSString *)colorStr alpha:(CGFloat)a;

+ (UIColor *)navgationBarTintColor;

@end
