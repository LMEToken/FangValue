//
//  Utils.m
//  TestApplication
//
//  Created by 潘鸿吉 on 13-4-22.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "Utils.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "AppDelegate.h"
#import "GTMBase64.h"

@implementation Utils

+(NSString *)ImagePath:(UIImage *)image
{
    
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/files.jpg"];
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    return pngPath;
}


+ (NSString*)checkKey:(NSDictionary*)responseDic key:(NSString*)key
{
    if ([responseDic isKindOfClass:[NSDictionary class]]) {
        
        if ([[responseDic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary* dic =[responseDic objectForKey:@"data"];
            
            if ([dic objectForKey:key]) {
                return [dic objectForKey:key];
            }
        }
        
    }
    
    return @"";
}

+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//2014.08.21 chenlihua 修改字体
+ (void)setDefaultFont:(id)sender size:(float)size{
    [sender setFont:[UIFont fontWithName:KUIFont size:size]];
}
+(UIFont *)getDefaultFont:(float)size{


    UIFont *font=[UIFont fontWithName:KUIFont size:size];
    return font;
    
}

+ (void)setDefaultFont:(id)sender{
    //[sender setFont:[UIFont fontWithName:KUIFont size:[[sender font] pointSize]]];
}

/*
+ (void)setDefaultFont:(id)sender{
    [sender setFont:[UIFont fontWithName:@"FZLTHJW--GB1-0" size:[[sender font] pointSize]]];
}*/
/*
+ (void)setDefaultFont:(id)sender size:(float)size{
    [sender setFont:[UIFont fontWithName:@"Helvetica" size:size]];
}
+(UIFont *)getDefaultFont:(float)size{
    
    
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:size];
    return font;
    
}
*/



+ (float)nextHeight:(id)sender{
    return ((UIView*)sender).frame.origin.y + ((UIView*)sender).frame.size.height;
}

+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (BOOL)isEmptyString:(NSString*)testString{
    if (!testString) {
        return YES;
    }
    if ([[testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString*)appIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)bundlePath:(NSString *)fileName {
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
   
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSString *)tempPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"temp"];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}



+ (NSString *)getDeviceModel{
    struct utsname u;
    uname(&u);
    NSString *modelVersion = [NSString stringWithFormat:@"%s", u.machine];
    return modelVersion;
}

+ (NSString*)systemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

//+ (NSString*)platformString{
//    // Gets a string with the device model
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    
//    if ([platform isEqualToString:@"iPhone1,1"])return@"iPhone 2G";
//    if ([platform isEqualToString:@"iPhone1,2"])return@"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"])return@"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"])return@"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,2"])return@"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"])return@"iPhone 4 (CDMA)";
//    if ([platform isEqualToString:@"iPhone4,1"])return@"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"])return@"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,2"])return@"iPhone 5 (GSM+CDMA)";
//    
//    if ([platform isEqualToString:@"iPod1,1"])return@"iPod Touch (1 Gen)";
//    if ([platform isEqualToString:@"iPod2,1"])return@"iPod Touch (2 Gen)";
//    if ([platform isEqualToString:@"iPod3,1"])return@"iPod Touch (3 Gen)";
//    if ([platform isEqualToString:@"iPod4,1"])return@"iPod Touch (4 Gen)";
//    if ([platform isEqualToString:@"iPod5,1"])return@"iPod Touch (5 Gen)";
//    
//    if ([platform isEqualToString:@"iPad1,1"])return@"iPad";
//    if ([platform isEqualToString:@"iPad1,2"])return@"iPad 3G";
//    if ([platform isEqualToString:@"iPad2,1"])return@"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,2"])return@"iPad 2";
//    if ([platform isEqualToString:@"iPad2,3"])return@"iPad 2 (CDMA)";
//    if ([platform isEqualToString:@"iPad2,4"])return@"iPad 2";
//    if ([platform isEqualToString:@"iPad2,5"])return@"iPad Mini (WiFi)";
//    if ([platform isEqualToString:@"iPad2,6"])return@"iPad Mini";
//    if ([platform isEqualToString:@"iPad2,7"])return@"iPad Mini (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,1"])return@"iPad 3 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,2"])return@"iPad 3 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,3"])return@"iPad 3";
//    if ([platform isEqualToString:@"iPad3,4"])return@"iPad 4 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,5"])return@"iPad 4";
//    if ([platform isEqualToString:@"iPad3,6"])return@"iPad 4 (GSM+CDMA)";
//
//    if ([platform isEqualToString:@"i386"]) return@"Simulator";
//    if ([platform isEqualToString:@"x86_64"]) return@"Simulator";
//
//    return platform;
//}

+ (BOOL) isIphone5
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size);
    }
    else
    {
        return NO;
    }
}

+ (NSString *) getCurrentTime
{
    NSDate* date = [NSDate date];

    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    NSInteger year = [component year];
    NSInteger month = [component month];
    NSInteger day = [component day];
    NSInteger hour = [component hour];
    NSInteger minute = [component minute];
    NSInteger second = [component second];
    
    NSString* dateString = [NSString stringWithFormat:@"%i-%@%i-%@%i %@%2i:%@%2i:%@%i" , year , month > 10 ? @"" :@"0",month , day > 10 ? @"" :@"0", day , hour > 10 ? @"" :@"0", hour  , minute > 10 ? @"" :@"0", minute ,second > 10 ? @"" :@"0", second];
    return dateString;
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    
//    NSDate* time = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [timeZone secondsFromGMTForDate:time];
//    NSDate* date = [[NSDate date] dateByAddingTimeInterval:interval];
//    
//    
////    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
////    NSInteger interval = [timeZone secondsFromGMTForDate:[NSDate date]];
////    NSDate* date = [[NSDate date] dateByAddingTimeInterval:interval];
////    
//    
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *timeDate = [[NSString alloc] initWithString:[dateformatter stringFromDate:date]];
//    [dateformatter release];
//    return [timeDate autorelease];

    
}

+ (NSString *) getTimeForNow
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeDate = [[NSString alloc] initWithString:[dateformatter stringFromDate:senddate]];

    return timeDate ;
}

+ (UIImage *)getImageFromProject:(NSString *)path
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
}

+(void) setdefaultRedColor:(UILabel *)sender
{
    sender.textColor=[UIColor colorWithRed:229/255.0 green:0 blue:82/255.0 alpha:1];

    
}
+ (UIFont*) getMyFontWithSize : (float) _size
{
    return [UIFont fontWithName:@"STHeitiTC-Medium" size:_size];
//    return [UIFont fontWithName:@"TRENDS" size:15.0f];
}

+ (UIColor*) getRGBColor : (float) r g : (float) g b : (float) b a:(float)a
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

#pragma mark 获取中文字符串转码
+ (NSString*) getEncodingWithGBK : (NSString*) _str
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [_str stringByAddingPercentEscapesUsingEncoding:enc];
}

#pragma mark 获取中文字符串转码utf8
+ (NSString*) getEncodingWithUTF8:(NSString *)_str
{
    return [_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark 字符串字符替换
+ (NSString*) changeString : (NSString*) _str withString : (NSString*) _wStr toString : (NSString*) _toStr
{
    return [_str stringByReplacingOccurrencesOfString:_wStr withString:_toStr];
}

#pragma mark 图片转base64
+ (NSString*) imageToBase64 : (UIImage*) _image
{
    if (!_image) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"base64" message:@"图片为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        return @"";
    }
//    NSData *imageData = UIImageJPEGRepresentation(_image, 1.0f);
    NSData *imageData = UIImagePNGRepresentation(_image);
     NSString *str = [GTMBase64 stringByEncodingData:imageData];
    return str;
}

+ (void) hudShow
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudShow];
}

+ (void) hudShow : (NSString*) msg
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudShow:msg];
}

+ (void) hudSuccessHidden
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudSuccessHidden];
}

+ (void) hudSuccessHidden : (NSString*) msg
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudSuccessHidden:msg];
}

+ (void) hudFailHidden
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudFailHidden];
}

+ (void) hudFailHidden : (NSString*) msg
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] hudFailHidden:msg];
}
+(NSString *)getString:(id) str
{
    
    if (![str isKindOfClass:[NSNull class]]) {
        
        NSString *st=[NSString stringWithFormat:@"%@",str];
        if ([st isEqualToString:@"(null)"]||[st isEqualToString:@"<null>"] || [st isEqualToString:@"null"]) {
            return @"";
        }
        else
            return st;
    }
    
    return @"";
}

+ (void) changeViewControllerWithTabbarIndex : (int) _tabbarIndex
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] changeViewController:_tabbarIndex];
}
+ (void)setMyDefaultFont:(id)sender{
    CGFloat size = 12;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"mySize"]) {
        int i = [[[NSUserDefaults standardUserDefaults] objectForKey:@"mySize"] intValue];
        NSLog(@"======i=%d",i);
        switch (i) {
            case -1:
                size = 12;
                break;
            case 0:
                size = 10;
                break;
            case 1:
                size = 12;
                break;
            case 2:
                size = 14;
                break;
            default:
                size = 12;
                break;
        }
    }
    [sender setFont:[UIFont fontWithName:@"Helvetica" size:size]];
}

@end
