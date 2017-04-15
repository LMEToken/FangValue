//
//  HomeEntreInstructionViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-11-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//项目介绍
#import "HomeEntreInstructionViewController.h"
//创业者
#import "HomeEntreViewController.h"
//认证页面
#import "HomeApproveViewController.h"



@interface HomeEntreInstructionViewController ()

@end

@implementation HomeEntreInstructionViewController

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
    
    //标题
    [self setTitle:@"项目介绍"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //背景图
    [self initBakcGroundView];

    //隐藏工具条
    [self setTabBarHidden:YES];
}
#pragma -mark -funcitons
//背景图
-(void)initBakcGroundView
{
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];

    //背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    imageView.image=[Utils getImageFromProject:@"homeEntreInstructions"];
    [backScrollerView addSubview:imageView];
    
    //输入框
    textCompanyView=[[UITextView alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+18, imageView.frame.origin.y+50, imageView.frame.size.width-40, imageView.frame.size.height-50)];
    textCompanyView.delegate=self;
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"]) {
        textCompanyView.text=@"介绍公司和产品的基本情况(限500字)";
        
    }else{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"] isEqualToString:@""]) {
            textCompanyView.text=@"介绍公司和产品的基本情况(限500字)";
        }else{
            textCompanyView.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"];
            
        }
    }

    textCompanyView.textColor=[UIColor grayColor];
    textCompanyView.font=[UIFont fontWithName:KUIFont size:10];
    textCompanyView.backgroundColor=[UIColor clearColor];
    [backScrollerView addSubview:textCompanyView];
    
}
//右侧按钮
-(void)initRightButton
{
    
    //右侧添加按钮
    
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(58, 17, 60, 44)];
    [rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
}
#pragma -mark -doClickActions
//右侧按钮
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton--");
    
    
    if ([textCompanyView.text isEqualToString:@"介绍公司和产品的基本情况(限500字)"]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入内容" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if([textCompanyView.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"输入内容不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if(textCompanyView.text.length>500){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已超出500字，请重新编辑" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }


    
    NSUserDefaults *entreDefault = [NSUserDefaults standardUserDefaults];
    [entreDefault setObject:textCompanyView.text forKey:@"team-e"];
    
    HomeApproveViewController *approve=[[HomeApproveViewController alloc]init];
    approve.flag=@"entre";
    [self.navigationController pushViewController:approve animated:NO];
    
}
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction--");
    
    
    
    NSUserDefaults *entreDefault = [NSUserDefaults standardUserDefaults];
    if ([textCompanyView.text isEqualToString:@""]) {
        [entreDefault setObject:@"介绍公司和产品的基本情况(限500字)" forKey:@"team-e"];
    }else{
        [entreDefault setObject:textCompanyView.text forKey:@"team-e"];
    }
   
    
    HomeEntreViewController *entre=[[HomeEntreViewController alloc]init];
    [self.navigationController pushViewController:entre animated:NO];
    
}
#pragma -mark -UITextFieldDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"]) {
        textCompanyView.text=@"";
        
    }else{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"] isEqualToString:@""]) {
            textCompanyView.text=@"";
        }else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"] isEqualToString:@"介绍公司和产品的基本情况(限500字)"]){
            textCompanyView.text=@"";
        }else{
            textCompanyView.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"];
            
        }
    }

    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
         [textCompanyView resignFirstResponder];
        
         NSUserDefaults *entreDefault = [NSUserDefaults standardUserDefaults];
         [entreDefault setObject:textCompanyView.text forKey:@"team-e"];
        
        return NO;
    }
    return YES;
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
