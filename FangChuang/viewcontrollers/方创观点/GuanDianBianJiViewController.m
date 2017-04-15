//
//  GuanDianBianJiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//方创观点编辑
#import "GuanDianBianJiViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GuanDianBianJiViewController ()

@end
@implementation GuanDianBianJiViewController

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
    [self .titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
//    [self setTitle:@" 编辑"];
    self.titleLabel.text = @"编辑";
    [self setTabBarHidden:YES];
    
	
    //2014.05.30 chenlihua 添加保存按钮，使点击后跳转到”方创观点“
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitle:@"保存" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BaoCunEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    //输入框白色背景
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 310, 330/2)];
    [imageView1 setImage:[UIImage imageNamed:@"21_shurukuang_1.png"]];
    [self.contentView addSubview:imageView1];
    
    //输入框UIText
    UITextView *xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 15, 310, 330/2)] ;
    [xiatextView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiatextView size:16];
    [xiatextView setFont:[UIFont fontWithName:KUIFont size:16]];
    [xiatextView.layer setCornerRadius:10];
    [xiatextView setDelegate:self];
    [xiatextView setBackgroundColor:[UIColor clearColor]];
    [xiatextView setText:self.content];
    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
    [xiatextView setScrollEnabled:YES];
    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview: xiatextView];
}
#pragma -mark -doClickAction
//保存
//2014.05.30 chenlihua 添加保存按钮，使点击后跳转到”方创观点“
- (void)BaoCunEvent:(UIButton *)sender{
    //2014.05.30 chenlihua 使其在点击保存按钮时，跳转到”方创观点“界面。
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"保存");
}
#pragma -mark -UITextField Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
