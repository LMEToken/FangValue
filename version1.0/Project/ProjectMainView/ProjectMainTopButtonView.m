//
//  ProjectMainTopButtonView.m
//  FangChuang
//
//  Created by chenlihua on 14-9-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//项目部分上面的条
#import "ProjectMainTopButtonView.h"

#define BUTTONTAG 11111

@implementation ProjectMainTopButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma -mark - 宽 320
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 320  , 58 / 2)];
    
    if (self) {
        
        _delegate = delegate;
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"project-top-normal",@"project-top-normal",@"project-top-normal",nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"project-top-down",@"project-top-down",@"project-top-down", nil];
        
        
        NSArray* titles = [NSArray arrayWithObjects:@"关注",@"融资",@"并购",nil];
        
        for (int i = 0; i < titles.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateSelected];
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont: [UIFont fontWithName:KUIFont size:14]];
            [button setFrame:CGRectMake(107* i, 0, 107, 58 / 2.)];
            [self addSubview:button];
            
            if (i == 0) {
                [button setSelected:YES];
                [button setUserInteractionEnabled:NO];
                 currentIndex =0;
                
            }
            
        }
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame delegate:(id)delegate titles:(NSArray*)array
{
    self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 300  , 58 / 2)];
    
    if (self) {
        
        _delegate = delegate;
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"project-top-normal",@"project-top-normal",@"project-top-normal",nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"project-top-down",@"project-top-down",@"project-top-down",nil];
        
        for (int i = 0; i < array.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateHighlighted];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithUserClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
            [button setFrame:CGRectMake(300 / 3 * i, 0, 300 / 3, 58 / 2.)];
            [self addSubview:button];
            
            
            if (i == 0) {
                
                currentIndex = - 1;
            }
        }
        
        
    }
    
    return self;
}

#pragma mark - button action
- (void)buttonClick:(UIButton*)button
{
    
    UIButton* btn = (UIButton*)[self viewWithTag:currentIndex + BUTTONTAG];
    [btn setSelected:NO];
    [btn setUserInteractionEnabled:YES];
    
    [button setUserInteractionEnabled:NO];
    [button setSelected:YES];
    
    currentIndex = button.tag - BUTTONTAG;
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonViewSelectIndex:buttonView:)]) {
        [_delegate buttonViewSelectIndex:currentIndex buttonView:self];
    }
    
    
}


#pragma mark - 按钮可以随便点击
- (void)buttonWithUserClick:(UIButton*)button
{
    
    [button setHighlighted:YES];
    currentIndex = button.tag - BUTTONTAG;
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonViewSelectIndex:buttonView:)]) {
        [_delegate buttonViewSelectIndex:currentIndex buttonView:self];
    }
}


@end
