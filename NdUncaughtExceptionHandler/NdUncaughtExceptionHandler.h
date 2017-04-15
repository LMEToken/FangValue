//
//  NdUncaughtExceptionHandler.h
//  用户发布后能保存崩溃
//
//  Created by chenlihua on 14-7-2.
//  Copyright (c) 2014年 chenlihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;
//还可以选择设置自定义的handler，让用户取选择

@end
