//
//  UINavigationController+PushPopAnimation.h
//  FangChuang
//
//  Created by omni on 14-4-14.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PushPopAnimation)

- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition;

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;

@end
