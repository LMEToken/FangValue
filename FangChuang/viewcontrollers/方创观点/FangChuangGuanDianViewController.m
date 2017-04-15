//
//  FangChuangGuanDianViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//方创观点
#import "FangChuangGuanDianViewController.h"
#import "GuanDianBianJiViewController.h"

@interface FangChuangGuanDianViewController ()

@end
@implementation FangChuangGuanDianViewController

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
    [self setTabBarHidden:YES];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
//    [self setTitle:@"方创观点"];
    self.titleLabel.text = @"方创观点";

    if (self.proid) {
        [self loadData];

    }
    //右侧编辑按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BianJiEvent:) forControlEvents:UIControlEventTouchUpInside];
    //2014.08.08 chenlihua 编辑按钮去掉
    //[self addRightButton:rightButton isAutoFrame:NO];

    //方创观点背景图
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 310, 330/2)];
    [imageView1 setImage:[UIImage imageNamed:@"21_shurukuang_1.png"]];
    [self.contentView addSubview:imageView1];
}
#pragma -mark -functions
- (void)loadData
{
    [[NetManager sharedManager]getFangchuangStandpointWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)initContentView
{
    //UITextView
    UITextView *xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 15, 310, 330/2)] ;
    [xiatextView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiatextView size:16];
    [xiatextView setFont:[UIFont fontWithName:KUIFont size:14]];
    [xiatextView.layer setCornerRadius:10];
    [xiatextView setDelegate:self];
    [xiatextView setBackgroundColor:[UIColor clearColor]];
    [xiatextView setText:[dataDic objectForKey:@"content"]];
    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
    [xiatextView setScrollEnabled:YES];
    xiatextView.editable=NO;
    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview: xiatextView];
}
#pragma -mark -doClickAction
- (void)BianJiEvent:(UIButton*)sender{
    NSLog(@"编辑");
    GuanDianBianJiViewController *view=[[GuanDianBianJiViewController alloc]init];
    view.content = [dataDic objectForKey:@"content"];
    NSLog(@"------content=%@",view.content);
    [self.navigationController pushViewController:view animated:YES];
}
#pragma -mark -UITextView Delegate
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
