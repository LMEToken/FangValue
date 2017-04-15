//
//  HomeForgetPasswordViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-11-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//忘记密码
#import "HomeForgetPasswordViewController.h"
//登陆
#import "HomeLoginViewController.h"
//手机号验证
#import "HomeTeleNumberViewController.h"
//判断是否有网络
#import "Reachability.h"

@interface HomeForgetPasswordViewController ()

@end

@implementation HomeForgetPasswordViewController

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
    [self setTitle:@"重置密码"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //初始化背景图
    [self initBackgroundView];
    
    //隐藏工具条
    [self setTabBarHidden:YES];

}
#pragma -mark -funcitons
-(void)initRightButton
{
    
    UIButton *enLargeRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enLargeRightButton setFrame:CGRectMake(200, -14, 120, 59)];
    [enLargeRightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    enLargeRightButton.backgroundColor=[UIColor clearColor];
    [self addRightButton:enLargeRightButton isAutoFrame:NO];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(56, 19,60, 44)];
    [rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
    
}
-(void)initBackgroundView
{
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:YES];
    [backScrollerView setContentSize:CGSizeMake(320,700)];
    [backScrollerView setDelegate:self];
    backScrollerView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:backScrollerView];
    
    //上面的图标
    upImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 320, 100)];
    upImageView.image=[Utils getImageFromProject:@"home-forgetpassword-up"];
    [backScrollerView addSubview:upImageView];
    
    //手机textField
    teleField=[[UITextField alloc]initWithFrame:CGRectMake(15, upImageView.frame.origin.y+60, 230, 30)];
    teleField.placeholder=@"请输入您的手机号码";
    teleField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"forget-tele"];
    teleField.textColor=[UIColor grayColor];
    teleField.font=[UIFont fontWithName:KUIFont size:13];
    teleField.backgroundColor=[UIColor clearColor];
    teleField.delegate=self;
    [backScrollerView addSubview:teleField];
    
    //下面的图标
    downImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, upImageView.frame.size.height+upImageView.frame.origin.y+15, 110, 12)];
    downImageView.image=[Utils getImageFromProject:@"home-forgetPassword-down"];
    [backScrollerView addSubview:downImageView];
    
    
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
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    
    HomeLoginViewController *login=[[HomeLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:NO];
    
}
//右侧按钮
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton--");
    
    if ([teleField.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"手机号不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (![self validateMobile:teleField.text]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"知道了"
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

    HomeTeleNumberViewController *tele=[[HomeTeleNumberViewController alloc]init];
    
    NSUserDefaults *teleDefault = [NSUserDefaults standardUserDefaults];
    [teleDefault setObject:teleField.text forKey:@"forget-tele"];
    [teleDefault synchronize];
    
    [self.navigationController pushViewController:tele animated:NO];
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
