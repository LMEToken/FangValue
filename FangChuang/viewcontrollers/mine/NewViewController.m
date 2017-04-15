//
//  NewViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//新消息提醒
//此功能添加到通用里，此页面暂时无用 2014.04.21 chenlihua
#import "NewViewController.h"
#import "AppDelegate.h"
@interface NewViewController ()
{
   
}
@end

@implementation NewViewController
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        self.view = nil;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTitle:@"新消息提醒"];
    [self setTabBarHidden:YES];
    
    isNewRemind = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isNewRemind"]boolValue];
    //背景框
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 480, 110/2)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
    [self.contentView addSubview:imageView];

    //新消息提醒Label
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 55)];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setTextAlignment:NSTextAlignmentLeft];
    [lab setTextColor:[UIColor orangeColor]];
    [lab setText:@"新消息提醒"];
    [lab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:lab];

    //新消息提醒选择按钮
    toggleViewBaseChange = [[ToggleView alloc]initWithFrame:CGRectMake(250, 17, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    toggleViewBaseChange.toggleDelegate = self;
    [self.contentView addSubview:toggleViewBaseChange];

    
    UIImage *onImage = [UIImage imageNamed:@"71_dian_2.png"];
    UIImage *offImage = [UIImage imageNamed:@"64tongyong_icon02.png"];
    onView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [onView setImage:onImage];
    [self.contentView addSubview:onView];

    offView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [offView setImage:offImage];
    [self.contentView addSubview:offView];

    if (isNewRemind) {
        [onView setFrame:CGRectMake(272, 17, 19, 19)];
        [offView setFrame:CGRectMake(272, 17, 19, 19)];
        [onView setHidden:YES];
        [offView setHidden:NO];
        [toggleViewBaseChange setSelectedButton:ToggleButtonSelectedLeft];
    }else{
        [onView setFrame:CGRectMake(290, 17, 19, 19)];
        [offView setFrame:CGRectMake(290, 17, 19, 19)];
        [offView setHidden:YES];
        [onView setHidden:NO];
        [toggleViewBaseChange setSelectedButton:ToggleButtonSelectedRight];
    }
}
#pragma mark - ToggleViewDelegate
- (void)selectLeftButton:(ToggleView*)toggleView
{
    if (!isNewRemind) {
        [UIView animateWithDuration:0.3 animations:^{
            [offView setHidden:NO];
            [onView setHidden:YES];
            [offView setFrame:CGRectMake(272, 17, 19, 19)];
            [onView setFrame:CGRectMake(272, 17, 19, 19)];
        }];
    }
    isNewRemind = YES;
    //全局变量赋值
    remind = YES;
    [[NSUserDefaults standardUserDefaults]setBool:isNewRemind forKey:@"isNewRemind"];
}
- (void)selectRightButton:(ToggleView*)toggleView
{
    if (isNewRemind) {
        [UIView animateWithDuration:0.3 animations:^{
            [offView setHidden:YES];
            [onView setHidden:NO];
            [onView setFrame:CGRectMake(290, 17, 19, 19)];
            [offView setFrame:CGRectMake(290, 17, 19, 19)];
        }];
    }
    isNewRemind = NO;
    remind = NO ;
    [[NSUserDefaults standardUserDefaults]setBool:isNewRemind forKey:@"isNewRemind"];
}
@end
