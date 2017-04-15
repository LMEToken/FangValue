//
//  UIImage+UrlRequest.h
//  FangChuang
//
//  Created by 朱天超 on 14-2-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^UIImageCallBack)(id);
@interface UIImage (UrlRequest)<NSURLConnectionDelegate , NSURLConnectionDataDelegate>


+ (void )imageWithUrlString:(NSString*)urlString imageCallBlock:(UIImageCallBack)block;
+ (void )imageWithConnectionString:(NSString*)urlString imageCallBlock:(UIImageCallBack)block;
@end
