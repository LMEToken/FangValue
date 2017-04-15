//
//  ButtonColumnView.m
//  FangChuang
//
//  Created by chenlihua on 14-4-24.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//方创内部的切换栏 2014.04.24 chenlihua 新加页面。
//方创下的栏目：分为：方创人、项目方、投资方与对接群，这四个栏目，请修改相应的标志；方创人为内部人之间的聊天与群，项目方为我们与项目方的群，投资方为我们与投资方的群，对接群为我们拉各方参与的群；

#import "ButtonColumnView.h"
#define BUTTONTAG 11111


@implementation ButtonColumnView

@synthesize unGroupLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        currentIndex=4;
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
        
        /*
        NSArray* imageNames = [NSArray arrayWithObjects:@"56_anniu_1",@"56_anniu_2",@"56_anniu_2",@"56_anniu_3", nil];
        //2014.07.29 chenlihua 将图片换为深颜色
       // NSArray* imageSlNames = [NSArray arrayWithObjects:@"56_anniu_4",@"56_anniu_5",@"56_anniu_5",@"56_anniu_6", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"导航栏左",@"导航栏中",@"导航栏中",@"导航栏右", nil];
        */
        
        
        //2014.09.10 chenlihua alan
        
        NSArray* imageNames = [NSArray arrayWithObjects:@"fangchuangTopButtonUp",@"fangchuangTopButtonUp",@"fangchuangTopButtonUp",@"fangchuangTopButtonUp", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"fangchuangTopButtonDown",@"fangchuangTopButtonDown",@"fangchuangTopButtonDown",@"fangchuangTopButtonDown", nil];
        
        
        NSArray* titles = [NSArray arrayWithObjects:@"方创人",@"项目方",@"投资方",@"对接群", nil];

        
         for (int i = 0; i < titles.count; i ++ ) {
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:[imageSlNames objectAtIndex:i]] forState:UIControlStateSelected];
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:BUTTONTAG + i];
         //   [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
             [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            [button.titleLabel setFont: [UIFont fontWithName:KUIFont size:14]];
           // [button.titleLabel setFont: [UIFont fontWithName:@"FZLanTingHei-R-G dBK" size:14]];
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
        
        /*
        NSArray* imageNames = [NSArray arrayWithObjects:@"56_anniu_1",@"56_anniu_2",@"56_anniu_2",@"56_anniu_3", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"56_anniu_4",@"56_anniu_5",@"56_anniu_5",@"56_anniu_6", nil];
        */
        //2014.09.10 chenlihua alan
        NSArray* imageNames = [NSArray arrayWithObjects:@"fangchuangTopButtonUp",@"fangchuangTopButtonUp",@"fangchuangTopButtonUp",@"fangchuangTopButtonUp", nil];
        NSArray* imageSlNames = [NSArray arrayWithObjects:@"fangchuangTopButtonDown",@"fangchuangTopButtonDown",@"fangchuangTopButtonDown",@"fangchuangTopButtonDown", nil];

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
    
//    
//    //Tom 20140808 本地计算
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
//    if (button.tag == 11111) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type1"];
//    }
//    if (button.tag == 11112) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type2"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type1"];
//    }
//
//    if (button.tag == 11113) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type3"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type1"];
//    }
//
//    if (button.tag == 11114) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type4"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type1"];
//    }

  
    
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
