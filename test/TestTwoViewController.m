//
//  TestTwoViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "TestTwoViewController.h"
#import "NetManagerNew.h"

@interface TestTwoViewController ()

@end

@implementation TestTwoViewController

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
    // Do any additional setup after loading the view.
    [self initView];
    
    number=0;
    
}
#pragma -mark -functions
-(void)initView
{
    self.view.backgroundColor=[UIColor orangeColor];
    [self initBackButton];
    [self initTestTitle];
    [self initTextLabel];
    [self initExplainLabel];
    [self initSendButton];
}
-(void)initExplainLabel
{
    UILabel *explainLabel=[[UILabel alloc]init];
    explainLabel.frame=CGRectMake(5, 220, 310, 150);
    explainLabel.numberOfLines=0;
    explainLabel.textAlignment=NSTextAlignmentLeft;
    explainLabel.font=[UIFont systemFontOfSize:15];
    explainLabel.text=@"说明:\n点击“发送”按钮的时候，t001会向“106测试群”发送ios,同时在群组中不会收到发送的文本消息“ios”";
    explainLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:explainLabel];
    
}
-(void)initSendButton
{
    UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.frame=CGRectMake(0, 400, 320, 30);
    sendButton.backgroundColor=[UIColor redColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
}

-(void)initTextLabel
{
    stepLabel=[[UILabel alloc]init];
    stepLabel.frame=CGRectMake(5, 60, 310, 150);
    stepLabel.numberOfLines=0;
    stepLabel.textAlignment=NSTextAlignmentLeft;
    stepLabel.font=[UIFont systemFontOfSize:15];
    stepLabel.backgroundColor=[UIColor redColor];
    [self.view addSubview:stepLabel];
    
}

-(void)initBackButton
{
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame=CGRectMake(10, 10, 50, 50);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(doClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
-(void)initTestTitle
{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(130, 10, 100, 50);
    titleLabel.text=@"测试二";
    [self.view addSubview:titleLabel];
    
}

-(void)doClickBackButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
