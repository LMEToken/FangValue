//
//  UIView+ProgressView.m
//  GlacierFramework
//
//  Created by cnzhao on 13-6-11.
//  Copyright (c) 2013年 Glacier. All rights reserved.
//

#import "UIView+ProgressView.h"
#import "MBProgressHUD.h"

#define PHONEFORGET     @"请输入手机号码"
#define PHONEWARN       @"请输入正确的手机号码"

#define EMAILFORGET     @"请输入邮箱"
#define EMAILWARN       @"请输入正确的邮箱"

#define QQFORGET        @"请输入QQ号"
#define QQWARN          @"请输入正确的QQ号"


@implementation UIView (ProgressView)


- (BOOL)checkPhoneNumber:(NSString*)text
{
    if (text == nil || text.length == 0) {
        [self showActivityOnlyLabelWithOneMiao:PHONEFORGET];
        return YES;
    }
    
    NSRegularExpression* regular = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[3458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [regular numberOfMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    
    if (number != 1) {
        [self showActivityOnlyLabelWithOneMiao:PHONEWARN];
        return YES;
    }
    
    
    
    return NO;
}

- (BOOL)checkEmail:(NSString*)text
{
    
    if (text == nil || text.length == 0) {
        [self showActivityOnlyLabelWithOneMiao:EMAILFORGET];
        return YES;
    }
    
    NSRegularExpression* regular = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSUInteger number = [regular numberOfMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    
    if (number != 1) {
        [self showActivityOnlyLabelWithOneMiao:EMAILWARN];
        return  YES;
    }
    
    return NO;
    
}


- (BOOL)checkQQ:(NSString *)text
{
//    [1-9][0-9]{4,}
    
    if (text == nil || text.length == 0) {
        [self showActivityOnlyLabelWithOneMiao:QQFORGET];
        return YES;
    }
    
    NSRegularExpression* regular = [NSRegularExpression regularExpressionWithPattern:@"[1-9][0-9]{4,}" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSUInteger number = [regular numberOfMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    
    if (number != 1) {
        [self showActivityOnlyLabelWithOneMiao:QQWARN];
        return  YES;
    }
    
    return NO;

}



- (MBProgressHUD *)showHUD
{
    [[MBProgressHUD allHUDsForView:self] enumerateObjectsUsingBlock:^(MBProgressHUD * obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self
                                               animated:true];
    
    hud.removeFromSuperViewOnHide = true;
    return hud;
}

- (void)showActivity:(NSString *)text forSeconds:(float)seconds userEnabled:(bool)enabled
{
    MBProgressHUD * hud = [self showHUD];
    hud.userInteractionEnabled = !enabled;
    hud.labelText = text;
    [hud hide:true afterDelay:seconds];
}

//显示一秒
- (void)showActivityOnlyLabelWithOneMiao:(NSString *)text
{
    MBProgressHUD * hud = [self showHUD];
    hud.margin = 15.f;
    hud.detailsLabelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = false;
    [hud hide:true afterDelay:1.f];
}


- (void)showActivityOnlyLabel:(NSString *)text forSeconds:(float)seconds
{
    MBProgressHUD * hud = [self showHUD];
    hud.margin = 15.f;
    hud.detailsLabelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = false;
    [hud hide:true afterDelay:seconds];
}

- (void)showActivityForFinish:(NSString *)text delegate:(id<MBProgressHUDDelegate>)delegate
{
    MBProgressHUD * hud = [self showHUD];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/37x-Checkmark.png"]];
	
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
    hud.delegate = delegate;
	hud.detailsLabelText = text;
    [hud hide:true afterDelay:2];
}

- (void)showActivityForText:(NSString*) text
{
    MBProgressHUD * hud = [self showHUD];
    hud.userInteractionEnabled = true;
    hud.detailsLabelText = text;
    hud.minShowTime = 3000.0f;
    [hud hide:true];
}

- (void)showActivity
{
    [self showActivity:@"Waiting..." forSeconds:10 userEnabled:false];
}

- (void)showActivity:(bool)userInteractionEnabled
{
    [self showActivity:@"Waiting..." forSeconds:10 userEnabled:userInteractionEnabled];
}

- (void)removeActivity
{
    [self removeActivity:true];
}

- (void)removeActivity:(bool)animated
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:self];
    if (hud)
    {
        [hud hide:animated];
    }
}
@end
