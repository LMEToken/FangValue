//
//  HomeRegisterViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//注册页面

#import "HomeRegisterViewController.h"
//登陆界面
#import "HomeLoginViewController.h"
//验证页面
#import "HomeVerifyViewController.h"
//判断是否有网络
#import "Reachability.h"

@interface HomeRegisterViewController ()

@end

@implementation HomeRegisterViewController

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
    [self setTitle:@"注册"];
    
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
    [backScrollerView setContentSize:CGSizeMake(320,self.contentViewHeight+3)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];

    //手机号码UIView
    teleView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 50)];
    teleView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:teleView];
    
    //手机图标
    teleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 30, 30)];
    teleImageView.image=[UIImage imageNamed:@"homeloginiphone"];
    [teleView addSubview:teleImageView];
    
    //手机textField
    teleField=[[UITextField alloc]initWithFrame:CGRectMake(teleImageView.frame.origin.x+teleImageView.frame.size.width+20, teleImageView.frame.origin.y, 230, 30)];
    teleField.placeholder=@"请输入您的手机号码";
    teleField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"tele"];
    teleField.textColor=[UIColor grayColor];
    teleField.font=[UIFont fontWithName:KUIFont size:13];
    teleField.backgroundColor=[UIColor clearColor];
    teleField.delegate=self;
    [teleView addSubview:teleField];
    
    
    //线
    lineView=[[UIView alloc]initWithFrame:CGRectMake(0, teleView.frame.size.height-1, 320, 1)];
    lineView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:241/255.0];
    [teleView addSubview:lineView];
    
    //密码UIView
    passWordView=[[UIView alloc]initWithFrame:CGRectMake(0, teleView.frame.size.height+teleView.frame.origin.y, 320, 50)];
    passWordView.backgroundColor=[UIColor whiteColor];
    [backScrollerView addSubview:passWordView];
    
    
    //密码图标UIImageView
    passImageView=[[UIImageView alloc]initWithFrame:CGRectMake(teleImageView.frame.origin.x, 10, 30, 30)];
    passImageView.image=[UIImage imageNamed:@"homeloginpassword"];
    [passWordView addSubview:passImageView];
    
    
    //密码textField
    passField=[[UITextField alloc]initWithFrame:CGRectMake(passImageView.frame.origin.x+passImageView.frame.size.width+20, passImageView.frame.origin.y, 230, 30)];
    passField.placeholder=@"请输入您的密码";
    passField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"pass"];
    passField.textColor=[UIColor grayColor];
    passField.font=[UIFont fontWithName:KUIFont size:13];
    passField.backgroundColor=[UIColor clearColor];
    passField.secureTextEntry=YES;
    passField.delegate=self;
    [passWordView addSubview:passField];
    
    
    //同意的图标
    agreenView=[[UIImageView alloc]initWithFrame:CGRectMake(passImageView.frame.origin.x+5, passWordView.frame.origin.y+passWordView.frame.size.height+15, 94, 13)];
    agreenView.image=[UIImage imageNamed:@"homeregisteragreen"];
    [backScrollerView addSubview:agreenView];
    
    
    //同意下的线
    accountLine=[[UIImageView alloc]initWithFrame:CGRectMake(agreenView.frame.origin.x+45, agreenView.frame.origin.y+agreenView.frame.size.height+2, 50, 0.5)];
    accountLine.backgroundColor=[UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:0.3];
    [backScrollerView addSubview:accountLine];

    
     //已有账号按钮
    accountButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    accountButton.frame=CGRectMake(agreenView.frame.origin.x+230,passWordView.frame.origin.y+passWordView.frame.size.height+15, 50, 15);
    [accountButton setBackgroundImage:[UIImage imageNamed:@"homeregisterhaveaccount"] forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(doClickAccountButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:accountButton];
    
    
    //已有账号下的线
    accountLine=[[UIImageView alloc]initWithFrame:CGRectMake(accountButton.frame.origin.x-2, accountButton.frame.origin.y+accountButton.frame.size.height, 50, 0.5)];
    accountLine.backgroundColor=[UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:0.3];
    [backScrollerView addSubview:accountLine];
    
    //下一步按钮
    nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame=CGRectMake(20, passWordView.frame.origin.y+passWordView.frame.size.height+75, 275, 37);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"homeloginnextbutton"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(doClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:nextButton];
}
//验证手机号码
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        
        return YES;
    }
    else
    {
        
        return NO;
    }
    
}
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}

#pragma -mark -doClickActions
//已有账号
-(void)doClickAccountButton:(UIButton *)btn
{
    NSLog(@"--doClickPassButton--");
    
    HomeLoginViewController *login=[[HomeLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:NO];
}
//下一步
-(void)doClickNextButton:(UIButton *)btn
{
    NSLog(@"--doClickLoginButton--");
    
    
    if ([teleField.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"手机号不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (![self validateMobile:teleField.text]) {
        
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
         */
        
    }else if ([passField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (passField.text.length<6){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码小于6位" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (passField.text.length>16){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码不能大于16位" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }else if ([passField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=passField.text.length){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码中不能有空格" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }

    
    if (![self isConnectionAvailable]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络异常!" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
        
    //同时上传手机号到到服务器，若有注册过，则提示。若无，则跳转到下一页面。
    
    HomeVerifyViewController *verifyView=[[HomeVerifyViewController alloc]init];
    
    NSUserDefaults *teleDefault = [NSUserDefaults standardUserDefaults];
    [teleDefault setObject:teleField.text forKey:@"tele"];
    [teleDefault synchronize];
    
    NSUserDefaults *passDefault=[NSUserDefaults standardUserDefaults];
    [passDefault setObject:passField.text forKey:@"pass"];
    [passDefault synchronize];
    
    [self.navigationController pushViewController:verifyView animated:NO];
    
}
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    
    HomeLoginViewController *loginView=[[HomeLoginViewController alloc]init];
    
    //用户名
    NSUserDefaults *teleDefault = [NSUserDefaults standardUserDefaults];
    [teleDefault setObject:teleField.text forKey:@"tele"];
    [teleDefault synchronize];
    
    //密码
    NSUserDefaults *passDefault=[NSUserDefaults standardUserDefaults];
    [passDefault setObject:passField.text forKey:@"pass"];
    [passDefault synchronize];

    [self.navigationController pushViewController:loginView animated:NO];
}
#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
