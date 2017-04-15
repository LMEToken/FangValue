//
//  FaWuViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//法务
#import "FaWuViewController.h"
#import "FaWuBianJiViewController.h"

@interface FaWuViewController ()

@end
@implementation FaWuViewController

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
    [self setTitle:@"法务"];
    [self setTabBarHidden:YES];
	
    NSLog(@"---self.proid--%@",self.proid);
    if (self.proid) {
        [self loadData];
    }
    
    //右侧编辑按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BianJiEvent:) forControlEvents:UIControlEventTouchUpInside];
    //2014.08.08 chenlihua 将编辑按钮去掉
    // [self addRightButton:rightButton isAutoFrame:NO];
    
}
#pragma -mark -functions
- (void)loadData
{
    NSLog(@"---loadData--");
    [[NetManager sharedManager]getLawworksListWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)initContentView
{
    //整个背景
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myScrollView setBackgroundColor:[UIColor clearColor]];
    [myScrollView setContentSize:CGSizeMake(320, 600)];
    [self.contentView addSubview:myScrollView];

    //公司法律架构Label
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 50)];
    [lab1 setBackgroundColor:[UIColor clearColor]];
    [lab1 setText:@"公司法律架构"];
    [lab1 setTextColor:[UIColor orangeColor]];
    [myScrollView addSubview:lab1];

    NSString *lawstruc = [dataDic objectForKey:@"legalstru"];
    CGSize size = {300,9999};
    
       //公司法律架构内容背景图
        CGSize size1 = [lawstruc sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 310, size1.height+5)];
        [imageView1 setImage:[UIImage imageNamed:@"17_shurukuang_1.png"]];
        [myScrollView addSubview:imageView1];
    
        //分司法律架构Label
        UILabel *lawLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, size1.height)];
        [lawLabel setBackgroundColor:[UIColor clearColor]];
        [lawLabel setTextColor:[UIColor grayColor]];
        [lawLabel setNumberOfLines:0];
        [lawLabel setFont:[UIFont fontWithName:KUIFont size:16]];
        [lawLabel setText:lawstruc];
        [myScrollView addSubview:lawLabel];
        
        //公司股权结构Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView1.frame)+10, 310, 50)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setText:@"公司股权结构"];
        [lab2 setTextColor:[UIColor orangeColor]];
        [myScrollView addSubview:lab2];

    //    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 50, 310, size1.height)] ;
//    [textView setTextColor:[UIColor grayColor]];
//    [Utils setDefaultFont:textView size:16];
//    [textView.layer setCornerRadius:10];
//    [textView setDelegate:self];
//    [textView setUserInteractionEnabled:NO];
//    [textView setBackgroundColor:[UIColor clearColor]];
//    [textView setText:@"的说法是打发第三方的发生范德萨发生地发呆时发送到发送到"];
//    [textView setReturnKeyType:UIReturnKeyDefault];
//    [textView setKeyboardType:UIKeyboardTypeDefault];
//    [textView setScrollEnabled:YES];
//    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
//    [myScrollView addSubview: textView];
//    [textView release];



        NSString *stockstruc = [dataDic objectForKey:@"stockstru"];
        CGSize size2 = [stockstruc sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
        //公司股权结构内容背景色
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
    
        //审计情况说明:Label
        UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView2.frame)+10, 310, 50)];
        [lab3 setBackgroundColor:[UIColor clearColor]];
        [lab3 setText:@"审计情况说明:"];
        [lab3 setTextColor:[UIColor orangeColor]];
        [myScrollView addSubview:lab3];
        
        //审计情况说明内容背景图
        UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lab3.frame), 310, 70)];
        [imageView3 setImage:[UIImage imageNamed:@"17_shurukuang_1.png"]];
        [myScrollView addSubview:imageView3];

//    UITextView *xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lab2.frame), 310, size2.height)] ;
//    [xiatextView setTextColor:[UIColor grayColor]];
//    [Utils setDefaultFont:xiatextView size:16];
//    [xiatextView.layer setCornerRadius:10];
//    [xiatextView setDelegate:self];
//    [xiatextView setUserInteractionEnabled:NO];
//    [xiatextView setBackgroundColor:[UIColor clearColor]];
//    [xiatextView setText:@"dafds "];
//    [xiatextView setReturnKeyType:UIReturnKeyDefault];
//    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
//    [xiatextView setScrollEnabled:YES];
//    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
//    [myScrollView addSubview: xiatextView];
//    [xiatextView release];
    
    


    NSArray *array=[NSArray arrayWithObjects:@"是否年度审计",@"审计年度",@"审计机构", nil];
    for (int i = 0; i < 3; i++) {
        //审计情况说明内容Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(lab3.frame)+5+20*i, 80, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [Utils setDefaultFont:lab size:13];
        [lab setFont:[UIFont fontWithName:KUIFont size:13]];
        [lab setText:[array objectAtIndex:i]];
        [lab setTextColor:[UIColor grayColor]];
        [myScrollView addSubview:lab];
    }
    //是否年度审计内容
    UILabel *shifoulab=[[UILabel alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(lab3.frame)+5, 150, 20)];
    [shifoulab setBackgroundColor:[UIColor clearColor]];
    [shifoulab setText:@"是"];
    [Utils setDefaultFont:shifoulab size:13];
    [shifoulab setFont:[UIFont fontWithName:KUIFont size:13]];
    [shifoulab setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:shifoulab];

    //":"Label
    UILabel *dianlab=[[UILabel alloc]initWithFrame:CGRectMake(85, CGRectGetMaxY(lab3.frame)+5, 2, 20)];
    [dianlab setBackgroundColor:[UIColor clearColor]];
    [dianlab setText:@":"];
    [Utils setDefaultFont:shifoulab size:13];
    [dianlab setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianlab setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:dianlab];

    //审计年度内容Label
    UILabel *timelab3=[[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+25, 150, 20)];
    [timelab3 setBackgroundColor:[UIColor clearColor]];
    [timelab3 setText:@"2013年"];
//    [Utils setDefaultFont:timelab3 size:13];
[ timelab3   setFont:[UIFont fontWithName:KUIFont size:13]];
    [timelab3 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:timelab3];

    //":"Label
    UILabel *dianlab2=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(lab3.frame)+25, 2, 20)];
    [dianlab2 setBackgroundColor:[UIColor clearColor]];
    [dianlab2 setText:@":"];
    [Utils setDefaultFont:shifoulab size:13];
    [dianlab setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianlab2 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:dianlab2];

    //审计机构内容Label
    UILabel *jigoulab3=[[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(lab3.frame)+45, 150, 20)];
    [jigoulab3 setBackgroundColor:[UIColor clearColor]];
    [jigoulab3 setText:@"上海审机构"];
    [Utils setDefaultFont:jigoulab3 size:13];
    [jigoulab3 setFont:[UIFont fontWithName:KUIFont size:13]];
    [jigoulab3 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:jigoulab3];

    //":“Label
    UILabel *dianlab3=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(lab3.frame)+45, 2, 20)];
    [dianlab3 setBackgroundColor:[UIColor clearColor]];
    [dianlab3 setText:@":"];
    [Utils setDefaultFont:dianlab3 size:13];
    [dianlab3 setTextColor:[UIColor grayColor]];
    [myScrollView addSubview:dianlab3];
}
#pragma -mark -doClickAction
- (void)BianJiEvent:(UIButton*)sender{
    NSLog(@"编辑");
    FaWuBianJiViewController *view=[[FaWuBianJiViewController alloc]init];
    view.dataDic = dataDic;
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
