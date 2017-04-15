//
//  FangChuangRenwuOKViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//方创任务完成
#import "FangChuangRenwuOKViewController.h"

@interface FangChuangRenwuOKViewController ()

@end

@implementation FangChuangRenwuOKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)loadData
{
    [[NetManager sharedManager]getTaskInfoWithTaskid:self.taskid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responseDic=%@",responseDic);
        if ([responseDic objectForKey:@"data"]) {
            self.dataDic = [responseDic objectForKey:@"data"];
            [self initContentView];
        }
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"方创任务"];
	// Do any additional setup after loading the view.
    
    //右侧完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(WanChengEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rightButton isAutoFrame:NO];

}
#pragma -mark -functions
- (void)initContentView
{
    //UIScrollView
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myScrollView setBackgroundColor:[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]];
    [myScrollView setShowsHorizontalScrollIndicator:YES];
    [myScrollView setContentSize:CGSizeMake(320, 890)];
    [self.contentView addSubview:myScrollView];

    //基本信息背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 310, 110 - 20)];
    [imageView setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [myScrollView addSubview:imageView];

    //工时信息Label
    UILabel *neironglab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) - 10, 80, 50)];
    [neironglab setBackgroundColor:[UIColor clearColor]];
    [neironglab setTextColor:[UIColor orangeColor]];
    [neironglab setText:@"工时信息:"];
    [myScrollView addSubview:neironglab];

    
    //工时信息背景图片
    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(5, 170, 310, 60)];
    [imageView2 setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [myScrollView addSubview:imageView2];

    
    NSArray *array2=[NSArray arrayWithObjects:@"【截止日期】",@"【最初预计】", nil];
    for (int i = 0; i < 2; i++) {
        
        //UILabel
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(5, 170+23*i, 90, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor orangeColor]];
        [Utils setDefaultFont:lab size:14];
        [lab setText:[array2 objectAtIndex:i]];
        [myScrollView addSubview:lab];

        //":"Label
        UILabel *dianlab4 =[[UILabel alloc]initWithFrame:CGRectMake(85, 170+23*i, 2, 20)];
        [dianlab4 setBackgroundColor:[UIColor clearColor]];
        [dianlab4 setTextColor:[UIColor blackColor]];
        [dianlab4 setText:@":"];
        [myScrollView addSubview:dianlab4];
    }
    
    //截止日期内容Label
    UILabel *riqilab4 =[[UILabel alloc]initWithFrame:CGRectMake(89, 170+23*0, 200, 20)];
    [riqilab4 setBackgroundColor:[UIColor clearColor]];
    [riqilab4 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:riqilab4 size:14];
    [riqilab4 setText:  [Utils getString:[self.dataDic objectForKey:@"end_time"]]];
    [myScrollView addSubview:riqilab4];

    //最初预计内容Label
    UILabel *yujilab4 =[[UILabel alloc]initWithFrame:CGRectMake(89, 170+23*1, 200, 20)];
    [yujilab4 setBackgroundColor:[UIColor clearColor]];
    [yujilab4 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:yujilab4 size:14];
    [yujilab4 setText:[Utils getString:[self.dataDic objectForKey:@"predict"]]];
    [myScrollView addSubview:yujilab4];
    
    //任务的一生Label
    UILabel *liuyanlab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView2.frame)+0, 100, 50)];
    [liuyanlab setBackgroundColor:[UIColor clearColor]];
    [liuyanlab setTextColor:[UIColor orangeColor]];
    [liuyanlab setText:@"任务的一生:"];
    [myScrollView addSubview:liuyanlab];

    //分割线
    UIImageView *xianIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(liuyanlab.frame)-5, 320, 1)];
    //    [xianIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
    [xianIMG setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG];

    NSArray *renWuArray=[NSArray arrayWithObjects:@"有谁建成",@"有谁完成",@"有谁取消",@"有谁关闭",@"关闭原因",@"最后编辑", nil];
    NSArray *renWuArray2=[NSArray arrayWithObjects:
                          [Utils getString:[self.dataDic objectForKey:@"who_built"]],[Utils getString:[self.dataDic objectForKey:@"who_finish"]],[Utils getString:[self.dataDic objectForKey:@"who_cancel"]],[Utils getString:[self.dataDic objectForKey:@"who_close"]],[Utils getString:[self.dataDic objectForKey:@"close_reason"]],[Utils getString:[self.dataDic objectForKey:@"final_edit"]], nil];
    for (int j=0; j<6; j++) {
        
        //前半部分名称Label
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(liuyanlab.frame)+20*j, 80, 20)];
        [titleLable setBackgroundColor:[UIColor clearColor]];
        [titleLable setTextColor:[UIColor grayColor]];
        [titleLable setText:[renWuArray objectAtIndex:j]];
        [Utils setDefaultFont:titleLable size:14];
        [myScrollView addSubview:titleLable];

        //后半部分内容Label
        UILabel *titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(liuyanlab.frame)+20*j, 230, 20)];
        [titleLable2 setBackgroundColor:[UIColor clearColor]];
        [titleLable2 setTextColor:[UIColor grayColor]];
        [titleLable2 setText:[NSString stringWithFormat:@":%@",[renWuArray2 objectAtIndex:j]]];
        [Utils setDefaultFont:titleLable2 size:14];
        [myScrollView addSubview:titleLable2];
        
        [myScrollView setContentSize:CGSizeMake(320, CGRectGetMaxY(titleLable2.frame) + 20)];
    }
    /*
     
     zhutc 去掉留言
     
     */
    [self initView];
    return;
    
    //以下内容暂时不执行
    UIImageView *xianIMG1=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(liuyanlab.frame)+20*5+5, 320, 0.5)];
    [xianIMG1 setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG1];

    
    UILabel *miaoshuLab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(xianIMG1.frame), 80, 50)];
    [miaoshuLab setBackgroundColor:[UIColor clearColor]];
    [miaoshuLab setTextColor:[UIColor orangeColor]];
    [miaoshuLab setText:@"任务描述:"];
    [myScrollView addSubview:miaoshuLab];

    
    UIImageView *xianIMG2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshuLab.frame)-5, 320, 0.5)];
    [xianIMG2 setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG2];

    
    UILabel *caiwumoxingLab=[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(xianIMG2.frame), 120, 20)];
    [caiwumoxingLab setBackgroundColor:[UIColor clearColor]];
    [caiwumoxingLab setTextColor:[UIColor colorWithRed:66/255. green:70/255. blue:74/255. alpha:1.0]];
    [caiwumoxingLab setText:@"【财务模型审核】"];
    [Utils setDefaultFont:caiwumoxingLab size:13];
    [myScrollView addSubview:caiwumoxingLab];

    
    
    NSArray *shenHeArray=[NSArray arrayWithObjects:@"关联文档1", @"关联文档2",@"关联文档3",nil];
    
    for (int g=0 ; g<3; g++) {
        
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(caiwumoxingLab.frame)+5+20*g, 80, 20)];
        [titleLable setBackgroundColor:[UIColor clearColor]];
        [titleLable setTextColor:[UIColor grayColor]];
        [titleLable setText:[shenHeArray objectAtIndex:g]];
        [Utils setDefaultFont:titleLable size:14];
        [myScrollView addSubview:titleLable];

        
        UILabel *wendangLable=[[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(caiwumoxingLab.frame)+5+20*g, 80, 20)];
        [wendangLable setBackgroundColor:[UIColor clearColor]];
        [wendangLable setTextColor:[UIColor grayColor]];
        [titleLable setText:[NSString stringWithFormat:@"%@:",[shenHeArray objectAtIndex:g]]];
        [Utils setDefaultFont:wendangLable size:14];
        [myScrollView addSubview:wendangLable];

        
    }
    
    [self initView];
    
    
    UIImageView *xianIMG3=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(caiwumoxingLab.frame)+10+20*3, 320, 0.5)];
    [xianIMG3 setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG3];

    
    
   
    
    UILabel *liuYanLab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(xianIMG3.frame), 80, 50)];
    [liuYanLab setBackgroundColor:[UIColor clearColor]];
    [liuYanLab setTextColor:[UIColor orangeColor]];
    [liuYanLab setText:@"留言:"];
    [myScrollView addSubview:liuYanLab];

    
    UIImageView *xianIMG4=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(liuYanLab.frame), 320, 0.5)];
    [xianIMG4 setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG4];

    
    
    
    
    
    NSArray *liuYanArray=[NSArray arrayWithObjects:@"发表于",@"标题",@"回复内容", nil];
    NSArray *liuYanArray2=[NSArray arrayWithObjects:@"2013-12-13 15:55",@"2013-12-13 15:55",@"不靠谱", nil];
    
    for (int f=0; f<3; f++) {
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(xianIMG4.frame)+20*f, 60, 20)];
        [titleLable setBackgroundColor:[UIColor clearColor]];
        [titleLable setTextColor:[UIColor grayColor]];
        [titleLable setText:[liuYanArray objectAtIndex:f]];
        [Utils setDefaultFont:titleLable size:14];
        [myScrollView addSubview:titleLable];

        
        UILabel *titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(xianIMG4.frame)+20*f, 200, 20)];
        [titleLable2 setBackgroundColor:[UIColor clearColor]];
        [titleLable2 setTextColor:[UIColor grayColor]];
        [titleLable2 setText:[NSString stringWithFormat:@":%@",[liuYanArray2 objectAtIndex:f]]];
        [Utils setDefaultFont:titleLable2 size:14];
        [myScrollView addSubview:titleLable2];

        
    }
    
    UIImageView *xianIMG5=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(xianIMG4.frame)+20*3, 320, 0.5)];
    [xianIMG5 setBackgroundColor:[UIColor colorWithRed:188/255. green:188/255. blue:188/255. alpha:1.0]];
    [myScrollView addSubview:xianIMG5];

    
    UILabel *tiltelab =[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(xianIMG5.frame)+10, 50, 30)];
    [tiltelab setBackgroundColor:[UIColor clearColor]];
    [tiltelab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:tiltelab size:13];
    [tiltelab setText:@"标题:"];
    [myScrollView addSubview:tiltelab];

    
    UIImageView *kuangimageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(xianIMG5.frame)+10, 260, 30)];
    [kuangimageView setImage:[UIImage imageNamed:@"10_shurukuang_3"]];
    [myScrollView addSubview:kuangimageView];

    
    UITextField *titleTextfield=[[UITextField alloc]initWithFrame:CGRectMake(55, CGRectGetMaxY(xianIMG5.frame)+10+2, 260-10, 30-4)];
    [titleTextfield setBackgroundColor:[UIColor clearColor]];
    [titleTextfield setFont:[UIFont systemFontOfSize:15]];
    [titleTextfield setBorderStyle:UITextBorderStyleNone];
    [titleTextfield setKeyboardType:UIKeyboardTypeEmailAddress];
    [titleTextfield setDelegate:self];
    [myScrollView addSubview:titleTextfield];

    
    UIImageView *kuangImageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)];
    [kuangImageView setImage:[UIImage imageNamed:@"10_shurukuang_4"]];
    [myScrollView addSubview:kuangImageView];

    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)] ;
    [textView setTextColor:[UIColor blackColor]];
    [Utils setDefaultFont:textView size:14];
    [textView.layer setCornerRadius:10];
    [textView setDelegate:self];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setText:@"请输入文本"];
    [textView setReturnKeyType:UIReturnKeyDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setScrollEnabled:YES];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [myScrollView addSubview: textView];

    
    
    UIImage *image2=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(textView.frame)+20, 508/2, 66/2)];
    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:button];
    
    [self initView];
}
//基本信息初始化
- (void)initView{
    
    //基本信息Label
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [titleLab setTextColor:[UIColor orangeColor]];
    [titleLab setText:@"基本信息:"];
    [myScrollView addSubview:titleLab];

    //所属项目Label
    UILabel *suolab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50+20*0, 90, 20)];
    [suolab setBackgroundColor:[UIColor clearColor]];
    [suolab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:suolab size:14];
    [suolab setText:@"【所属项目】"];
    [myScrollView addSubview:suolab];

    //任务类型Label
    UILabel *renlab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50+20*1, 90, 20)];
    [renlab setBackgroundColor:[UIColor clearColor]];
    [renlab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:renlab size:14];
    [renlab setText:@"【任务类型】"];
    [myScrollView addSubview:renlab];

    //任务状态Label
    UILabel *wulab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50+20*2, 90, 20)];
    [wulab setBackgroundColor:[UIColor clearColor]];
    [wulab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:wulab size:14];
    [wulab setText:@"【任务状态】"];
    [myScrollView addSubview:wulab];
    
    //所属项目内容
    UILabel *xiangmulab =[[UILabel alloc]initWithFrame:CGRectMake(89, 50+23*0, 150, 20)];
    [xiangmulab setBackgroundColor:[UIColor clearColor]];
    [xiangmulab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiangmulab size:14];
    [xiangmulab setNumberOfLines:0];
    [xiangmulab setText:[NSString stringWithFormat:@":%@",[Utils getString:[self.dataDic objectForKey:@"proname"]]]];
    [myScrollView addSubview:xiangmulab];

    
//    UILabel *xiangmuneironglab =[[UILabel alloc]initWithFrame:CGRectMake(89, CGRectGetMaxY(suolab.frame), 220, 20)];
//    [xiangmuneironglab setBackgroundColor:[UIColor clearColor]];
//    [xiangmuneironglab setTextColor:[UIColor grayColor]];
//    [Utils setDefaultFont:xiangmuneironglab size:14];
//    [xiangmuneironglab setNumberOfLines:0];
//    [xiangmuneironglab setText:[NSString stringWithFormat:@":%@",@"saidjasj于2012-10-12"]];
//    [myScrollView addSubview:xiangmuneironglab];
//    [xiangmuneironglab release];

    
    //任务类型内容
    UILabel *biaotilab =[[UILabel alloc]initWithFrame:CGRectMake(89, 50+20*1, 150, 20)];
    [biaotilab setBackgroundColor:[UIColor clearColor]];
    [biaotilab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:biaotilab size:14];
    [biaotilab setText:[NSString stringWithFormat:@":%@",[Utils getString:[self.dataDic objectForKey:@"task_style"]]]];
    [myScrollView addSubview:biaotilab];

    //任务状态内容
    UILabel *faburenlab2 =[[UILabel alloc]initWithFrame:CGRectMake(89, 50+20*2, 100, 20)];
    [faburenlab2 setBackgroundColor:[UIColor clearColor]];
    [faburenlab2 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:faburenlab2 size:14];
    [faburenlab2 setText:[NSString stringWithFormat:@":%@",[Utils getString:[self.dataDic objectForKey:@"task_status"]]]];
    [myScrollView addSubview:faburenlab2];

    //优先级Label
    UILabel *dianlab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50+20*3, 90, 20)];
    [dianlab setBackgroundColor:[UIColor clearColor]];
    [dianlab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:dianlab size:14];
    [dianlab setText:@"【优先级】"];
    [myScrollView addSubview:dianlab];

    //优先级内容
    UILabel *xiaoxilab2 =[[UILabel alloc]initWithFrame:CGRectMake(75, 50+20*3, 100, 20)];
    [xiaoxilab2 setBackgroundColor:[UIColor clearColor]];
    [xiaoxilab2 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiaoxilab2 size:14];
    [xiaoxilab2 setText:[NSString stringWithFormat:@"   :%@",[Utils getString:[self.dataDic objectForKey:@"priority"]]]];
    [myScrollView addSubview:xiaoxilab2];
}
#pragma -mark -TextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:@"" context:nil];
    self.contentView.frame=CGRectMake(0, -64, 320, self.contentViewHeight);
    [UIView commitAnimations];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [UIView beginAnimations:@"" context:nil];
        self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
        [UIView commitAnimations];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma -mark -doClickAction
//完成按钮
- (void)WanChengEvent:(UIButton *)sender{
    NSLog(@"完成");
    [self.navigationController popViewControllerAnimated:YES];
}
//暂时未用到
- (void)Submit:(UIButton *)sender{
    NSLog(@"发送");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
