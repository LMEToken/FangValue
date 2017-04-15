//
//  ButtonView.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//方创内部的切换栏 去掉最后的邮件功能,
//已经进行了重写，此文件暂时无用
#import "ButtonView.h"
#define BUTTONTAG 11111
@implementation ButtonView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - 宽 320
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 320  , 58 / 2)];
    
    if (self) {
        
        _delegate = delegate;
        
        /*
        NSArray* imageNames = [NSArray arrayWithObjects:@"56_anniu_1",@"56_anniu_2",@"56_anniu_2",@"56_anniu_3", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"56_anniu_4",@"56_anniu_5",@"56_anniu_5",@"56_anniu_6", nil];
        NSArray* titles = [NSArray arrayWithObjects:@"方创内部",@"项目方",@"投资方",@"敬请期待", nil];
        */
        //2014.04.21 chenlihua 修改方创中Tab,敬请期待,去掉
        NSArray* imageNames = [NSArray arrayWithObjects:@"56_anniu_1",@"56_anniu_2",@"56_anniu_3", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"56_anniu_4",@"56_anniu_5",@"56_anniu_5", nil];
        NSArray* titles = [NSArray arrayWithObjects:@"方创内部",@"项目方",@"投资方", nil];

        for (int i = 0; i < titles.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateSelected];
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
            // [button setFrame:CGRectMake(80* i, 0, 80, 58 / 2.)];
            //2014.04.21 chenlihua 修改方创中Tab,敬请期待,去掉,UI重新布局
            [button setFrame:CGRectMake(107*i, 0, 107, 58/2)];
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
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"56_anniu_1",@"56_anniu_2",@"56_anniu_2",@"56_anniu_3", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"56_anniu_4",@"56_anniu_5",@"56_anniu_5",@"56_anniu_6", nil];
        
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
