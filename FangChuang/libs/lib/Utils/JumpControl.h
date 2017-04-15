//
//  JumpControl.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JumpControl : NSObject

+ (void)jumpToHome;

+ (void)jumpProject;

+ (void)project:(UIViewController*)nav dictionary:(NSDictionary*)dic;

+ (void)jumpChatView;

+ (void)jumpToContactView;

@end
