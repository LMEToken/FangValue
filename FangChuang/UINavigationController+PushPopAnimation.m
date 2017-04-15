//
//  UINavigationController+PushPopAnimation.m
//  FangChuang
//
//  Created by omni on 14-4-14.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "UINavigationController+PushPopAnimation.h"

@implementation UINavigationController (PushPopAnimation)

- (void)pushAnimationDidStop {
    
}



- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition {
    
    [self pushViewController:controller animated:NO];
    
    
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.8];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    
    [UIView commitAnimations];
    
}



- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.8];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    
    [UIView commitAnimations];
    
    
    
    return poppedController;
    
}

@end
