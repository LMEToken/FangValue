//
//  Utils.h
//  TestApplication
//
//  Created by 潘鸿吉 on 13-4-22.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utils : NSObject {
    
}
+(NSString *)ImagePath:(UIImage *)image;
+ (NSString*)checkKey:(NSDictionary*)responseDic key:(NSString*)key;
+ (NSString *)md5:(NSString *)str;

+ (void)setDefaultFont:(id)sender size:(float)size;
+ (void)setDefaultFont:(id)sender;

+ (float)nextHeight:(id)sender;

+ (NSString*)base64forData:(NSData*)theData;

+ (BOOL)isEmptyString:(NSString*)testString;

//app bundle id
+ (NSString*)appIdentifier;
//bundle目录
+ (NSString *)bundlePath:(NSString *)fileName;
//document目录
+ (NSString *)documentsPath:(NSString *)fileName;
//临时目录
+ (NSString *)tempPath:(NSString *)fileName;



//系统版本
+ (NSString*)systemVersion;

//平台类型
//+ (NSString*)platformString;

+ (NSString*)getDeviceModel;

+ (BOOL) isIphone5;


+(UIFont *)getDefaultFont:(float)size;

+ (NSString *) getTimeForNow;
+ (NSString *) getCurrentTime;

+ (UIImage*) getImageFromProject : (NSString*) path;

+ (UIFont*) getMyFontWithSize : (float) _size;

+ (UIColor*) getRGBColor : (float) r g : (float) g b : (float) b a : (float) a;

#pragma mark 获取中文字符串转码
+ (NSString*) getEncodingWithGBK : (NSString*) _str;

#pragma mark 获取中文字符串转码utf8
+ (NSString*) getEncodingWithUTF8:(NSString *)_str;

#pragma mark 字符串字符替换
+ (NSString*) changeString : (NSString*) _str withString : (NSString*) _wStr toString : (NSString*) _toStr;

#pragma mark 图片转base64
+ (NSString*) imageToBase64 : (UIImage*) _image;

+ (void) hudShow;
+ (void) hudShow : (NSString*) msg;
+ (void) hudSuccessHidden;
+ (void) hudSuccessHidden : (NSString*) msg;
+ (void) hudFailHidden;
+ (void) hudFailHidden : (NSString*) msg;
+ (NSString *)getString:(id) str;
+ (void) changeViewControllerWithTabbarIndex : (int) _tabbarIndex;

+(void) setdefaultRedColor:(UILabel *)sender;
+ (void)setMyDefaultFont:(id)sender;
@end
