//
//  GuanYuViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//关于方创
#import "GuanYuViewController.h"
@interface GuanYuViewController ()

@end
@implementation GuanYuViewController
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
-(void)gotofavalue
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.favalue.com"]];
}
-(void)callphone
{
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"021－64262830"];

    NSURL *url = [[NSURL alloc] initWithString:telUrl];

    [[UIApplication sharedApplication] openURL:url];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTitle:@"关于方创"];
    [self setTabBarHidden:YES];
    self.contentView.backgroundColor = [UIColor whiteColor];
    backScrollerView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,self.contentViewHeight+3)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-70, 50, 249/2, 120/2)];
    [image setImage:[UIImage imageNamed:@"favaluelogo"]];
    [backScrollerView addSubview:image];
    UILabel *banben = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-30, 150, 249/2, 120/2)];
    [banben setText:@"版本 :"];
    [banben setFont:[UIFont fontWithName:KUIFont size:13]];
    [banben setTextColor:[UIColor grayColor]];
    [backScrollerView addSubview:banben];
    UILabel *banbentext = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2+10, 150, 249/2, 120/2)];
    [banbentext setText:@"0.0.3"];
    [banbentext setFont:[UIFont fontWithName:KUIFont size:13]];
    [banbentext setTextColor:[UIColor grayColor]];
    [backScrollerView addSubview:banbentext];
    UIImageView *banbenlin = [[UIImageView alloc]initWithFrame:CGRectMake(60, 200, self.contentView.frame.size.width-120, 1)];
    [banbenlin setImage:[UIImage imageNamed:@"favaluelogoxian"]];
    [backScrollerView addSubview:banbenlin];
    UILabel *guangwang = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-60, 250, 249/2, 120/2)];
    [guangwang setText:@"官网:"];
    [guangwang setFont:[UIFont fontWithName:KUIFont size:13]];
    [guangwang setTextColor:[UIColor grayColor]];
    [backScrollerView addSubview:guangwang];
    UIButton *guangwangtext = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-35, 265, 140, 30)];
    [guangwangtext setTitle:@"www.favalue.com" forState:UIControlStateNormal];
    [guangwangtext setFont:[UIFont fontWithName:KUIFont size:13]];
    [guangwangtext setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [guangwangtext addTarget:self action:@selector(gotofavalue) forControlEvents:UIControlEventTouchDown];
//    [guangwangtext setText:@"www.favalue.com"];
//    guangwangtext.backgroundColor = [UIColor grayColor];
//    [guangwangtext.titleLabel setText:@"aa"];
////     setTitle:@"www.favalue.com" forState:UIControlStateNormal];
//    [guangwangtext.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
//    [guangwangtext.titleLabel setTextColor:[UIColor blueColor]];
//    [guangwangtext setTextColor:[UIColor grayColor]];
    [backScrollerView addSubview:guangwangtext];
    
    UILabel *dianhua = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-60, 290, 249/2, 120/2)];
    [dianhua setText:@"电话:"];
    [dianhua setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianhua setTextColor:[UIColor grayColor]];
    [backScrollerView addSubview:dianhua];
//    UILabel *dianhuatext = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-20, 290, 249/2, 120/2)];
//    [dianhuatext setText:@"021－64262830"];
//    [dianhuatext setFont:[UIFont fontWithName:KUIFont size:13]];
//    [dianhuatext setTextColor:[UIColor grayColor]];
//    [backScrollerView addSubview:dianhuatext];
    UIButton *dianhuatext = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-40, 305, 140, 30)];
    [dianhuatext setTitle:@"021－64262830" forState:UIControlStateNormal];
    [dianhuatext setFont:[UIFont fontWithName:KUIFont size:13]];
    [dianhuatext setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dianhuatext addTarget:self action:@selector(callphone) forControlEvents:UIControlEventTouchDown];
    [backScrollerView addSubview:dianhuatext];
   
//    //第一个模块的背景图
//    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0*(102.5+10), 640/2, 205/2)];
//    [imageView1 setImage:[UIImage imageNamed:@"59_kuang_1"]];
//    [self.contentView addSubview:imageView1];
//
//    //第二个模块的背景图
//    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 1*(102.5+10), 640/2, 205/2)];
//    [imageView2 setImage:[UIImage imageNamed:@"59_kuang_1"]];
//    [self.contentView addSubview:imageView2];
//   
//    for (int i=0; i<3 ; i ++) {
//        NSArray *array=[NSArray arrayWithObjects:@"方创",@"version 1.0 build 20141011",@"上海统创投资管理有限公司", nil];
//        //第一个模块的文字
//        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 102.5/3*i, 320, 102.5/3)];
//        [lab setBackgroundColor:[UIColor clearColor]];
//        [lab setText:[array objectAtIndex:i]];
//        [lab setTextAlignment:NSTextAlignmentCenter];
//        [lab setTextColor:[UIColor orangeColor]];
//        [lab setFont:[UIFont fontWithName:KUIFont size:14]];
//        [self.contentView addSubview:lab];
//    }
//   
//    for (int j=0; j<3 ; j ++) {
//        NSArray *array=[NSArray arrayWithObjects:@"电话：021-64262830",@"邮箱：smith@favlaue.com",@"地址：上海市徐汇区宜山路425号光启城2010单元", nil];
//        
//        //第二个模块的文字
//            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView1.frame)+10+102.5/3*j, 320, 102.5/3)];
//            [lab setBackgroundColor:[UIColor clearColor]];
//            [lab setText:[array objectAtIndex:j]];
//            [lab setTextAlignment:NSTextAlignmentCenter];
//            [lab setTextColor:[UIColor orangeColor]];
//           [lab setFont:[UIFont fontWithName:KUIFont size:14]];
//            [self.contentView addSubview:lab];
//            
//        
//    }
//    
//    //企业文化内容
//    NSString *sizeStr=@"               永不自我设限、积极他我实现";
//    
//    CGSize size=[sizeStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
//    //第三部分的背景图
//    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2*(102.5+10), 640/2, size.height+40)];
//    [imageView3 setImage:[UIImage imageNamed:@"59_kuang_1"]];
//    [self.contentView addSubview:imageView3];
//    
//    //第三部分标题Label
//    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView2.frame)+10, 320, 102.5/4)];
//    [lab3 setBackgroundColor:[UIColor clearColor]];
//    [lab3 setText:@"企业文化"];
//    [lab3 setTextAlignment:NSTextAlignmentCenter];
//    [lab3 setTextColor:[UIColor orangeColor]];
//    [lab3 setFont:[UIFont fontWithName:KUIFont size:14]];
//    [self.contentView addSubview:lab3];
//    //第三部分内容Label
//    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(lab3.frame), 300, size.height)];
//    [lab4 setBackgroundColor:[UIColor clearColor]];
//    [lab4 setNumberOfLines:0];
//    [Utils setDefaultFont:lab4 size:14];
//    [lab4 setText:sizeStr];
//    [lab4 setTextColor:[UIColor orangeColor]];
//    [lab4 setFont:[UIFont fontWithName:KUIFont size:14]];
//    [self.contentView addSubview:lab4];
//
}


@end
