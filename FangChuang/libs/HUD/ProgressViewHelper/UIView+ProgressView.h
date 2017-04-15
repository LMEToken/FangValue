//
//  UIView+ProgressView.h
//  GlacierFramework
//
//  Created by cnzhao on 13-6-11.
//  Copyright (c) 2013年 Glacier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (ProgressView)
- (void)showActivityForText:(NSString*) text;
- (void)showActivity;
- (void)showActivity:(bool)userInteractionEnabled;
- (void)removeActivity;
- (void)removeActivity:(bool)animated;
- (void)showActivityForFinish:(NSString *)text delegate:(id<MBProgressHUDDelegate>)delegate;
- (void)showActivity:(NSString *)text forSeconds:(float)seconds userEnabled:(bool)enabled;
- (void)showActivityOnlyLabel:(NSString *)text forSeconds:(float)seconds;
- (void)showActivityOnlyLabelWithOneMiao:(NSString *)text;


//判断手机号
- (BOOL)checkPhoneNumber:(NSString*)text;

//判断邮箱
- (BOOL)checkEmail:(NSString*)text;

//判断QQ号码
- (BOOL)checkQQ:(NSString*)text;
@end
