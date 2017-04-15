//
//  passwdViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//修改密码
#import "passwdViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface passwdViewController ()

@end

@implementation passwdViewController
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
    [self setTitle:@"修改密码"];
	
    //右边完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:14];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    
    for (int i=1; i<4; i++) {
        //白色的背景
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 65*(i-1), 480, 110/2)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
        [self.contentView addSubview:imageView];
        
        NSArray *array=[NSArray arrayWithObjects:@"原始码:",@"新密码:",@"再次输入新密码:", nil];
        //原始码前Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, (65*(i-1)), 80, 55)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setNumberOfLines:0];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:(i-1)]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [self.contentView addSubview:lab];
        
        //右侧的框
        UIImageView *backimageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 15+65*(i-1), 350/2, 25)];
        [backimageView setBackgroundColor:[UIColor clearColor]];
        [backimageView setImage:[UIImage imageNamed:@"62_kuang_1"]];
        [self.contentView addSubview:backimageView];
    }
    mimaText1=[[UITextField alloc]initWithFrame:CGRectMake(105, 17+65*0, 350/2-10, 25-4)];
    [mimaText1 setBackgroundColor:[UIColor clearColor]];
    [mimaText1 setDelegate:self];
    [mimaText1 setSecureTextEntry:YES];
    [mimaText1 setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:mimaText1];
    
    mimaText2=[[UITextField alloc]initWithFrame:CGRectMake(105, 17+65*1, 350/2-10, 25-4)];
    [mimaText2 setBackgroundColor:[UIColor clearColor]];
    [mimaText2 setDelegate:self];
    [mimaText2 setSecureTextEntry:YES];
    [mimaText2 setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:mimaText2];
    
    mimaText3=[[UITextField alloc]initWithFrame:CGRectMake(105, 17+65*2, 350/2-10, 25-4)];
    [mimaText3 setBackgroundColor:[UIColor clearColor]];
    [mimaText3 setDelegate:self];
    [mimaText3 setSecureTextEntry:YES];
    [mimaText3 setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:mimaText3];
}

#pragma  -mark  -textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:mimaText1]) {
        [mimaText2 becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:mimaText2]){
        [mimaText3 becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:mimaText3]){
        [mimaText3 resignFirstResponder];
        return YES;
    }
    return NO;
}
#pragma  -mark  -doClickAction
- (void)done:(UIButton*)sender
{
    if (mimaText1.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请输入原始密码"];
        return;
    }
    if (mimaText2.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请输入新密码"];
        return;
    }
    if (mimaText3.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请再次输入新密码"];
        return;
    }
    
    if ([mimaText1.text isEqualToString:mimaText2.text]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"原密码与新密码一样"];
        return;
    }

    if (![mimaText2.text isEqualToString:mimaText3.text]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"两次输入的新密码不一致"];
        return;
    }
    
    
    [[NetManager sharedManager]changePasswordWithUsername:[[UserInfo sharedManager]username] oldpassword:mimaText1.text newpassword:mimaText2.text hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
     
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
    
    
    
}


@end
