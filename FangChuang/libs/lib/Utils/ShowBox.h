//
//  ShowBox.h
//  RongYi
//
//  Created by BlueMobi BlueMobi on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShowBox : NSObject <UIAlertViewDelegate>
+(void)showError:(NSString *)content;

+(void)showCollectSuccess:(NSString *)content controller:(UIViewController *) controller;

+(BOOL)alertPhoneNo:(NSString *)phoneNo;
+(BOOL)alertTextNull:(NSString *)text message:(NSString *)message;

+(void)showSuccess:(NSString *)content;
//判断是否登录  登录返回NO 不登录返回yes 有alert
+(BOOL)alertNoLogin;
 
  
+(BOOL)alertEmail:(NSString *)Email require:(BOOL)require;
+(BOOL)alertPhoneNo:(NSString *)phoneNo require:(BOOL)require;
+(BOOL)alertPassWord:(NSString *)password;
+(BOOL)alertCardNo:(NSString *)cardNo require:(BOOL)require;
+(BOOL)alertNoLoginWithPush:(UIViewController *) view;
+(BOOL)alertLoginName:(NSString *)loginName require:(BOOL)require;
+(void)showAll;
@end
