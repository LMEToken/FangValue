//
//  CustomStatueBar.m
//  CustomStatueBar
//
//  Created by 贺 坤 on 12-5-21.
//  Copyright (c) 2012年 深圳市瑞盈塞富科技有限公司. All rights reserved.
//

#import "CustomStatueBar.h"

@implementation CustomStatueBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal;
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor orangeColor];
        
        defaultLabel = [[BBCyclingLabel alloc]initWithFrame:[UIApplication sharedApplication].statusBarFrame andTransitionType:BBCyclingLabelTransitionEffectScrollUp];
        defaultLabel.backgroundColor = [UIColor clearColor];
        defaultLabel.textColor = [UIColor whiteColor];
        defaultLabel.font = [UIFont systemFontOfSize:10.0f];
        defaultLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:defaultLabel];
//        [defaultLabel setText:@"default label text" animated:NO];
        defaultLabel.transitionDuration = 0.75;
        defaultLabel.shadowOffset = CGSizeMake(0, 1);
        defaultLabel.font = [UIFont systemFontOfSize:15];
        defaultLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        defaultLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.75];
        defaultLabel.clipsToBounds = YES;
        
        isFull = NO;

    }
    return self;
}
- (void)fullStatueBar{
    isFull = !isFull;
    if (isFull) {
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:1.0f];
        self.frame =CGRectMake(320, 0,40, 20);
        [UIView commitAnimations];
    }else {
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:1.0f];
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        [UIView commitAnimations];
    }
}
- (void)showStatusMessage:(NSString *)message{
//    self.hidden = NO;
//    self.alpha = 1.0f;
//    [defaultLabel setText:@"你有一条新消息" animated:NO];
    
    CGSize totalSize = self.frame.size;
    self.frame = (CGRect){ self.frame.origin, 0, totalSize.height };
    
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = (CGRect){ self.frame.origin, totalSize };
    } completion:^(BOOL finished){
        defaultLabel.text = message;
    }];
}
- (void)hide{
    self.alpha = 1.0f;
    
    [UIView animateWithDuration:1.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        defaultLabel.text = @"";
        self.hidden = YES;
    }];;

}
- (void)changeMessge:(NSString *)message{
    [defaultLabel setText:message animated:YES];
}

@end
