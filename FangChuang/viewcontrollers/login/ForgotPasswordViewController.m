//
//  ForgotPasswordViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//忘记密码
#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

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
    [self setTitle:@"找回密码"];
	
    //请输入手机号/邮箱地址背景图
    UIImage *image0=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 260, 40)];
    [imageView setImage:image0];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:imageView];

    //邮箱图片
    UIImage *image1=[UIImage imageNamed:@"01_tubiao_2"];
    UIImageView *nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 30, 36/2, 39/2)];
    [nameImageView setImage:image1];
    [nameImageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:nameImageView];

    //请输入手机号/邮箱地址 textField
    textField=[[UITextField alloc]initWithFrame:CGRectMake(60, 20, 225, 40)];
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setPlaceholder:@"请输入手机号/邮箱地址"];
    [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [textField setReturnKeyType:UIReturnKeyNext];
    [textField setDelegate:self];
    [self.contentView addSubview:textField];

    
    //提交button
    UIImage *image2=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(nameImageView.frame)+40, 508/2, 66/2)];
    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];

}


#pragma -mark  -doClickAction
- (void)Submit:(UIButton *)sender{
    
    if (textField.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请输入手机号"];
        
    }
    
    [[NetManager sharedManager]getPasswordWithUsername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        [self.view showActivityOnlyLabelWithOneMiao:[responseDic objectForKey:@"msg"]];

    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}

#pragma -mark  -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField1{
    [textField1 resignFirstResponder];
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
