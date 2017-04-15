//
//  ParentViewController.h
//  community
//
//  Created by 潘鸿吉 on 13-8-13.
//  Copyright (c) 2013年 BlueMobi BlueMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ParentViewController : UIViewController
{
    int     statusBarHeight;
   
//    int TABBARHEIGHT;
}

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIView *navigationView;
@property (nonatomic , strong) UIView *backview;
@property (nonatomic , strong) UIView *contentView;
@property (nonatomic , strong) UIView *tabbarView;
@property (nonatomic , strong) UIView *statusBarBackgroundView;
@property (nonatomic , assign , readonly) float   contentViewHeight;
- (void) addbackview;
- (void) setTabBarIndex : (int) index;
- (void) setTabBarHidden : (BOOL) hidden;
- (void) addBackButton;
- (void) addLeftButton : (UIButton*) leftButton isAutoFrame : (BOOL) isAutoFrame;
- (void) addRightButton : (UIButton*) rightButton isAutoFrame : (BOOL) isAutoFrame;
- (void) setTitle:(NSString *)title;
- (void) setNavigationViewHidden : (BOOL) hidden;
@end
