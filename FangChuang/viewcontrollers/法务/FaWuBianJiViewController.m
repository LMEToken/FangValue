//
//  FaWuBianJiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//法务编辑
#import "FaWuBianJiViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FaWuBianJiViewController ()

@end

@implementation FaWuBianJiViewController
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
    [self setTitle:@"编辑"];
    [self setTabBarHidden:YES];
    
    //右侧保存按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitle:@"保存" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BaocunEvent:) forControlEvents:UIControlEventTouchUpInside];
  //  rightButton.backgroundColor=[UIColor redColor];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    //背景图片
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myScrollView setBackgroundColor:[UIColor clearColor]];
    [myScrollView setContentSize:CGSizeMake(320, 600)];
    [self.contentView addSubview:myScrollView];
    
    //公司法律架构Label
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 50)];
    [lab1 setBackgroundColor:[UIColor clearColor]];
    [lab1 setFont:[UIFont fontWithName:KUIFont size:14]];
    [lab1 setText:@"公司法律架构"];
    [lab1 setTextColor:[UIColor orangeColor]];
    [myScrollView addSubview:lab1];

    NSString *lawstruc = [self.dataDic objectForKey:@"legalstru"];
    NSLog(@"---lawstruc--%@",lawstruc);
    //2014.07.22 chenlihua 在项目中，添加项目列表中，跳转到法务编辑文件时，会出错。
    if (!lawstruc) {
        lawstruc=@"";
    }
    CGSize size = {300,9999};
    CGSize size1 = [lawstruc sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    //分司法律架构内容背景图
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 310, size1.height+5)];
    [imageView1 setImage:[UIImage imageNamed:@"17_shurukuang_1.png"]];
    [myScrollView addSubview:imageView1];

    //2014.07.22 chenlihua 公司法律框架填写
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 45, 310, size1.height+15)] ;
    [textView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:textView size:14];
  //  [textView.layer setCornerRadius:10];
    [textView setDelegate:self];
    //[textView setUserInteractionEnabled:NO];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setText:@""];
    [textView setReturnKeyType:UIReturnKeyDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setScrollEnabled:NO];
   // [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [myScrollView addSubview: textView];
    
    
    //公司法律架构内容Label
    UILabel *lawLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, size1.height)];
    [lawLabel setBackgroundColor:[UIColor clearColor]];
    [lawLabel setTextColor:[UIColor grayColor]];
    [lawLabel setNumberOfLines:0];
    [lawLabel setFont:[UIFont fontWithName:KUIFont size:16]];
    [lawLabel setText:lawstruc];
    [myScrollView addSubview:lawLabel];

    //分司股权结构Label
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView1.frame)+10, 310, 50)];
    [lab2 setBackgroundColor:[UIColor clearColor]];
    [lab2 setText:@"公司股权结构"];
    [lab2 setFont:[UIFont fontWithName:KUIFont size:16]];
    [lab2 setTextColor:[UIColor orangeColor]];
    [myScrollView addSubview:lab2];

    
    NSString *stockstruc = [self.dataDic objectForKey:@"stockstru"];
    //2014.07.22 chenlihua 欢迎添加新项目，添加项目信息，法务信息时，公司股权结构内空，会得很细。
    if (!stockstruc) {
        stockstruc=@"";
    }
    CGSize size2 = [stockstruc sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    //公司股权结构内容背景图
    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lab2.frame), 310, size2.height+5)];
    [imageView2 setImage:[UIImage imageNamed:@"17_shurukuang_1.png"]];
    [myScrollView addSubview:imageView2];
    
    //公司股权结构内容Label
    UILabel *stockLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab2.frame), 300, size2.height)];
    [stockLabel setBackgroundColor:[UIColor clearColor]];
    [stockLabel setTextColor:[UIColor grayColor]];
    [stockLabel setFont:[UIFont fontWithName:KUIFont size:16]];
    [stockLabel setNumberOfLines:0];
    [stockLabel setText:stockstruc];
    [myScrollView addSubview:stockLabel];
    
    //2014.07.22 chenlihua 公司股权结构填写
    UITextView *xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lab2.frame)-5, 310, size2.height+15)] ;
    [xiatextView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiatextView size:14];
    [xiatextView setFont:[UIFont fontWithName:KUIFont size:14]];
 //   [xiatextView.layer setCornerRadius:10];
    [xiatextView setDelegate:self];
  //  [xiatextView setUserInteractionEnabled:NO];
    [xiatextView setBackgroundColor:[UIColor clearColor]];
    [xiatextView setText:@""];
    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
    [xiatextView setScrollEnabled:NO];
    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [myScrollView addSubview: xiatextView];
    
    //公司股权结构Label
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView2.frame)+10, 310, 50)];
    [lab3 setBackgroundColor:[UIColor clearColor]];
    [lab3 setText:@"审计情况说明"];
    [lab3 setTextColor:[UIColor orangeColor]];
    [myScrollView addSubview:lab3];

    //第三部分背景图
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lab3.frame), 310, 70)];
    [imageView3 setImage:[UIImage imageNamed:@"17_shurukuang_1.png"]];
    [myScrollView addSubview:imageView3];

    
    NSArray *array=[NSArray arrayWithObjects:@"是否年度审计:",@"审计年度:",@"审计机构:", nil];
    for (int i = 0; i < 3; i++) {
        //是否年度审计等Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lab3.frame)+5+20*i, 100, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [Utils setDefaultFont:lab size:13];
        [lab setFont:[UIFont fontWithName:KUIFont size:13]];
        [lab setText:[array objectAtIndex:i]];
        [lab setTextColor:[UIColor grayColor]];
        [myScrollView addSubview:lab];
    }
    
    //是否年度审计内容Label
    /*
    UILabel *shifoulab=[[UILabel alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(lab3.frame)+5, 150, 20)];
    [shifoulab setBackgroundColor:[UIColor clearColor]];
    [shifoulab setText:@"是"];
    [Utils setDefaultFont:shifoulab size:13];
    [shifoulab setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:shifoulab];
    */
    
    //2014.07.22 chenlihua 由label改为textField
    UITextView *shifoulab=[[UITextView alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(lab3.frame), 200, 25)];
    [shifoulab setBackgroundColor:[UIColor clearColor]];
    [shifoulab setText:@""];
    [Utils setDefaultFont:shifoulab size:13];
    [shifoulab setFont:[UIFont fontWithName:KUIFont size:13]];
    [shifoulab setTextColor:[UIColor grayColor]];
    shifoulab.scrollEnabled=NO;
    [myScrollView addSubview:shifoulab];
    
    
    
    //":"Label
    UILabel *dianlab=[[UILabel alloc]initWithFrame:CGRectMake(85, CGRectGetMaxY(lab3.frame)+5, 2, 20)];
    [dianlab setBackgroundColor:[UIColor clearColor]];
    [dianlab setText:@":"];
    [Utils setDefaultFont:shifoulab size:13];
    [dianlab setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianlab setTextColor:[UIColor grayColor]];
   // [myScrollView addSubview:dianlab];

    //审计年度内容Label
    /*
    UILabel *timelab3=[[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+25, 150, 20)];
    [timelab3 setBackgroundColor:[UIColor clearColor]];
    [timelab3 setText:@"2013年"];
    [Utils setDefaultFont:timelab3 size:13];
    [timelab3 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:timelab3];
    */
    
    //2014.07.22 chenlihua 由label改为textField
    UITextView *timelab3=[[UITextView alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+20, 230, 25)];
    [timelab3 setBackgroundColor:[UIColor clearColor]];
    [timelab3 setText:@""];
    [Utils setDefaultFont:timelab3 size:13];
    [timelab3 setFont:[UIFont fontWithName:KUIFont size:13]];
    [timelab3 setTextColor:[UIColor grayColor]];
    timelab3.scrollEnabled=NO;
    [myScrollView addSubview:timelab3];
    
    
    //":"Label
    UILabel *dianlab2=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(lab3.frame)+25, 2, 20)];
    [dianlab2 setBackgroundColor:[UIColor clearColor]];
    [dianlab2 setText:@":"];
    [Utils setDefaultFont:shifoulab size:13];
    [dianlab2 setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianlab2 setTextColor:[UIColor grayColor]];
   // [myScrollView addSubview:dianlab2];
    
    //审计机构内容Label
    /*
    UILabel *jigoulab3=[[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+45, 150, 20)];
    [jigoulab3 setBackgroundColor:[UIColor clearColor]];
    [jigoulab3 setText:@"上海审机构"];
    [Utils setDefaultFont:jigoulab3 size:13];
    [jigoulab3 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:jigoulab3];
    */
    
    //2014.07.22 chenlihua 由label改为textField
    UITextView *jigoulab3=[[UITextView alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+40, 230, 25)];
    [jigoulab3 setBackgroundColor:[UIColor clearColor]];
    [jigoulab3 setText:@""];
    [Utils setDefaultFont:jigoulab3 size:13];
    [jigoulab3 setFont:[UIFont fontWithName:KUIFont size:14]];
    [jigoulab3 setTextColor:[UIColor grayColor]];
    jigoulab3.scrollEnabled=NO;
    [myScrollView addSubview:jigoulab3];

    //":"Label
    UILabel *dianlab3=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(lab3.frame)+45, 2, 20)];
    [dianlab3 setBackgroundColor:[UIColor clearColor]];
    [dianlab3 setText:@":"];
    [Utils setDefaultFont:dianlab3 size:13];
    [dianlab3 setFont:[UIFont fontWithName:KUIFont size:14]];
    [dianlab3 setTextColor:[UIColor grayColor]];
   // [myScrollView addSubview:dianlab3];
    
}
#pragma -mark -doClickAction
//保存
- (void)BaocunEvent:(UIButton*)sender{
    //2014.05.30 chenlihua 点击保存按钮时，使其跳转到法务界面。
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"保存");
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
