//
//  HomeChooseIdentifyViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-29.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//请选择身份
#import "HomeChooseIdentifyViewController.h"
//完善个人资料
#import "HomePersonalInformationViewController.h"
//投资者
#import "HomeEntreViewController.h"
//创业者
#import "HomeInvestorViewController.h"
//获取token值
#import "NetTest.h"

@interface HomeChooseIdentifyViewController ()

@end

@implementation HomeChooseIdentifyViewController
@synthesize tyrantLabel;
@synthesize flagString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    //获取apptoken
    [NetTest netTest];

   }
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    [self setTitle:@"请选择身份"];
    
    //返回按钮
    [self addBackButton];
    
    //初始化背景图
    [self initBackgroundView];
    
    //隐藏工具条
    [self setTabBarHidden:YES];
}
#pragma -mark -functions
-(void)initBackgroundView
{
    
    
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    
    //背景图片
   
    detailView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 31)];
    detailView.image=[UIImage imageNamed:@"homechoosetyrantdetail"];
    [backScrollerView addSubview:detailView];
    
    //显示土豪
    tyrantLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 60, 20)];
    tyrantLabel.backgroundColor=[UIColor clearColor];
    tyrantLabel.textColor=[UIColor orangeColor];
    //此数据从服务器进行获取
    
    //从服务器获取土豪数
    [[NetManager sharedManager]gethaonumWithUsername:[[NSUserDefaults standardUserDefaults]objectForKey:@"tele"] apptoken:[[UserInfo sharedManager] apptoken] hudDic:nil success:^(id responseDic) {
        NSLog(@"---tuhao--responseDic--%@--",responseDic);
        
       NSDictionary *dic=[responseDic objectForKey:@"data"];
        NSLog(@"-tuhao--dic--%@--",dic);
        
        NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        
        tyrantLabel.text=[NSString stringWithFormat:@"%@%@",name,[dic objectForKey:@"haonum"]];
        
    } fail:^(id errorString) {
        NSLog(@"--tuhao--errString-%@--",errorString);
        tyrantLabel.text=@"土豪0";
    }];
    
    tyrantLabel.font=[UIFont fontWithName:KUIFont size:9];
    [detailView addSubview:tyrantLabel];
    
    //图片
    chooseImageView=[[UIImageView alloc]initWithFrame:CGRectMake(35, detailView.frame.origin.y+detailView.frame.size.height+15, 252, 252)];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"iden"]isEqualToString:@"entre"]) {
        chooseImageView.image=[UIImage imageNamed:@"homechooseentredownload"];
         flagString=@"entre";
    }else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"iden"] isEqualToString:@"investor"]){
        chooseImageView.image=[UIImage imageNamed:@"homechooseinvestordownload"];
        flagString=@"investor";
    }else{
        chooseImageView.image=[UIImage imageNamed:@"homechoosetyrantchooseImage"];
    }
    [backScrollerView addSubview:chooseImageView];
    
 
    for (int i=0; i<252; i++) {
        UIButton *entreButton=[UIButton buttonWithType:UIButtonTypeCustom];
        entreButton.frame=CGRectMake(chooseImageView.frame.origin.x+i, chooseImageView.frame.origin.y+i, chooseImageView.frame.size.width-i, 1);
        entreButton.backgroundColor=[UIColor clearColor];
        [entreButton addTarget:self action:@selector(doClickEntreButton:) forControlEvents:UIControlEventTouchUpInside];
        [backScrollerView addSubview:entreButton];
        
        UIButton *investorButton=[UIButton buttonWithType:UIButtonTypeCustom];
         investorButton.frame=CGRectMake(chooseImageView.frame.origin.x, chooseImageView.frame.origin.y+i, i, 1);        investorButton.backgroundColor=[UIColor clearColor];
        [investorButton addTarget:self action:@selector(doClickInvestorButton:) forControlEvents:UIControlEventTouchUpInside];
        [backScrollerView addSubview:investorButton];

    }
    
     
    //下一步按钮
    nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame=CGRectMake(22, chooseImageView.frame.origin.y+chooseImageView.frame.size.height+55, 275, 37);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"homepersonalinformationnextbutton"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(doClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:nextButton];

  
    
}
#pragma -mark -doClickActions
-(void)doClickEntreButton:(UIButton *)btn
{
    NSLog(@"--doClickEntreButton--");
    chooseImageView.image=[UIImage imageNamed:@"homechooseentredownload"];
    flagString=@"entre";
    
}
-(void)doClickInvestorButton:(UIButton *)btn
{
    NSLog(@"--doClickInvestorButton--");
    chooseImageView.image=[UIImage imageNamed:@"homechooseinvestordownload"];
    flagString=@"investor";
    
}
-(void)doClickNextButton:(UIButton *)btn
{
    if ([flagString isEqualToString:@"entre"]) {
        HomeEntreViewController *entre=[[HomeEntreViewController alloc]init];
        entre.whereFromString= CLH_NSSTRING_HOME_ENTRE_DETAIL;
        
        //创业者
        NSUserDefaults *enDefault = [NSUserDefaults standardUserDefaults];
        [enDefault setObject:@"entre" forKey:@"iden"];
        [enDefault synchronize];

        
        [self.navigationController pushViewController:entre animated:NO];

    }else if ([flagString isEqualToString:@"investor"]){
        HomeInvestorViewController *investor=[[HomeInvestorViewController alloc]init];
        investor.whereFromString= CLH_NSSTRING_HOME_INVEST_DETAIL;
        
        //投资者
        NSUserDefaults *inDefault = [NSUserDefaults standardUserDefaults];
        [inDefault setObject:@"investor" forKey:@"iden"];
        [inDefault synchronize];
        
        [self.navigationController pushViewController:investor animated:NO];

    }else{
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请选择身份" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    
    HomePersonalInformationViewController *personView=[[HomePersonalInformationViewController alloc]init];
   [self.navigationController pushViewController:personView animated:NO];
}

#pragma -mark -systemFunctions
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
