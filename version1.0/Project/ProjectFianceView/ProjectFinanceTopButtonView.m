//
//  ProjectFinanceTopButtonView.m
//  FangChuang
//
//  Created by chenlihua on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//融资进程主页面上面的栏
#import "ProjectFinanceTopButtonView.h"
#define BUTTONTAG 11111
@implementation ProjectFinanceTopButtonView

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
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"project-finance-top-button-up",@"project-finance-top-button-up",@"project-finance-top-button-up",@"project-finance-top-button-up",nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"project-finance-top-buton-down",@"project-finance-top-buton-down",@"project-finance-top-buton-down",@"project-finance-top-buton-down", nil];
        
        
        NSArray* titles = [NSArray arrayWithObjects:@"重点跟进",@"已见面",@"已推进",@"已否决",nil];
        
        for (int i = 0; i < titles.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateSelected];
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont: [UIFont fontWithName:KUIFont size:13]];
            [button setFrame:CGRectMake(80* i, 0, 80, 58 / 2.)];
            [self addSubview:button];
            
            if (i == 0) {
                [button setSelected:YES];
                [button setUserInteractionEnabled:NO];
                currentIndex = 0;
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
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"project-finance-top-button-up",@"project-finance-top-button-up",@"project-finance-top-button-up",@"project-finance-top-button-up",nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"project-finance-top-buton-down",@"project-finance-top-buton-down",@"project-finance-top-buton-down",@"project-finance-top-buton-down", nil];
        
        for (int i = 0; i < array.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateHighlighted];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithUserClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
            [button setFrame:CGRectMake(300 / 4 * i, 0, 300 / 4, 58 / 2.)];
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
