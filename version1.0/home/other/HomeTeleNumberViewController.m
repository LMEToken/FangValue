//
//  HomeTeleNumberViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-11-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//手机号验证
#import "HomeTeleNumberViewController.h"
//密码重置
#import "HomeForgetPasswordViewController.h"
//登陆
#import "HomeLoginViewController.h"
//获取token值
#import "NetTest.h"

@interface HomeTeleNumberViewController ()

@end

@implementation HomeTeleNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma -makr -systemFuncitons
//将验证码发送到服务器
-(void)viewWillAppear:(BOOL)animated
{
    //获取apptoken
    [NetTest netTest];
    
    timeStart=YES;
    sysTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    // 可以通过fire这个方法去触发timer，即使timer的firing time没有到达
    [sysTimer fire];
    [self getAuthCode];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    [self setTitle:@"手机号验证"];
    
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
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
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
    upImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 65, 10)];
    upImageView.image=[Utils getImageFromProject:@"home-telenumber-up"];
    [backScrollerView addSubview:upImageView];
    
    //显示电话
    teleLabel=[[UILabel alloc]initWithFrame:CGRectMake(upImageView.frame.origin.x+upImageView.frame.size.width+10, upImageView.frame.origin.y, 100, 10)];
    teleLabel.textColor=[UIColor blueColor];
    teleLabel.backgroundColor=[UIColor clearColor];
    teleLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"forget-tele"];
    teleLabel.font=[UIFont fontWithName:KUIFont size:9];
    [backScrollerView addSubview:teleLabel];
    
    //中间的图标
    downImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 320, 100)];
    downImageView.image=[Utils getImageFromProject:@"home-telenumber-middle"];
    [backScrollerView addSubview:downImageView];
    
    
    //验证码textField
    testField=[[UITextField alloc]initWithFrame:CGRectMake(15, downImageView.frame.origin.y+12, 230, 30)];
     testField.placeholder=@"请输入验证码";
     testField.textColor=[UIColor grayColor];
     testField.font=[UIFont fontWithName:KUIFont size:12];
     testField.backgroundColor=[UIColor clearColor];
     testField.delegate=self;
    testField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"forget-test"];
     [backScrollerView addSubview: testField];


    //密码 textField
    passField=[[UITextField alloc]initWithFrame:CGRectMake(15, downImageView.frame.origin.y+60, 230, 30)];
    passField.placeholder=@"设置登录密码，不少于6位";
    passField.textColor=[UIColor grayColor];
    passField.font=[UIFont fontWithName:KUIFont size:12];
    passField.backgroundColor=[UIColor clearColor];
    passField.delegate=self;
    passField.secureTextEntry=YES;
    passField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"forget-pass"];
    [backScrollerView addSubview: passField];


    UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(20, downImageView.frame.origin.y+downImageView.frame.size.height+18, 278, 40);
    [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"发送验证码到手机上" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
    [self.contentView addSubview:sendButton];

}
//随时更新验证码发送的时间
- (void)timerFireMethod:(NSTimer *)timer

{
    //定义一个NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //初始化目标时间...
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //得到当前时间
    NSDate *today = [NSDate date];
    NSDate *date = [NSDate dateWithTimeInterval:60 sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    
    if(timeStart) {
        //从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart = NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    
    //把目标时间装载入date
    NSDate *todate = [cal dateFromComponents:endTime];
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSLog(@"----%d---",[d second]);
    if([d second] < 60 && [d second] > 0) {
        NSString *miao = [NSString stringWithFormat:@"%d",[d second]];
        NSLog(@"---miao----%@",miao);
        
        UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(20, downImageView.frame.origin.y+downImageView.frame.size.height+18, 278, 40);
        [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
        [sendButton setTitle:[NSString stringWithFormat:@"重新发送短信(%@)",miao] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sendButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
        [self.contentView addSubview:sendButton];
    }else if([d second] == 0) {
        [sysTimer invalidate];
        
        UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(20, downImageView.frame.origin.y+downImageView.frame.size.height+18, 278, 40);
        [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [sendButton setTitle:@"发送验证码到手机上" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sendButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
        [self.contentView addSubview:sendButton];
    }
}
- (void)getAuthCode{
    
    //将电话号码发送到服务器，服务器返回验证码。
    
    NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
    //@"a54db1cbaf33fc465799bd89a0edda32972dae2d50639231f306d39f1264edd5"
    
    [[NetManager sharedManager] GetverifycodeWithmobile:teleLabel.text apptoken:[[UserInfo sharedManager] apptoken] rflag:@"2" deviceid:tokenPushString hudDic:nil success:^(id responseDic) {
        NSLog(@"--pass-verify--responseDic--%@",responseDic);
        
        verifyService=[Utils checkKey:responseDic key:@"verifycode"];
        NSLog(@"---verifyService--%@",verifyService);
        
    } fail:^(id errorString) {
        NSLog(@"--verify---errorString--%@",errorString);
        
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请确定手机号已注册同时请检查您的网络是否良好" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
         */

    }];
    
   
}

#pragma -mark -doClickActions
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    
    HomeForgetPasswordViewController *forget=[[HomeForgetPasswordViewController alloc]init];
    
    NSUserDefaults *testDefault = [NSUserDefaults standardUserDefaults];
    [testDefault setObject:testField.text forKey:@"forget-test"];
    [testDefault synchronize];
    
    NSUserDefaults *passDefault = [NSUserDefaults standardUserDefaults];
    [passDefault setObject:passField.text forKey:@"forget-pass"];
    [passDefault synchronize];


    [self.navigationController pushViewController:forget animated:NO];
    
}
//右侧按钮
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"--doClickRightButton--");
    
    NSLog(@"---testField.text--%@",testField.text);
    NSLog(@"---passField.text--%@",passField.text);
    
    if ([testField.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"验证码不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if(![testField.text isEqualToString:verifyService]){
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"验证码输入错误" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        */
        
    }
    
    
    if ([passField.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
        
    }else if (passField.text.length<6) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码不应小于6位" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (passField.text.length>16) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码不应大于16位" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if ([passField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length!=passField.text.length){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"密码中不能有空格" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }

    
    
    //将新的用户名，密码上传到服务器，同时跳转到登陆页面,若成功，则弹出提示，修改密码成功。否则失败。
    //要验证验证码是否正确
    
   
    [[NetManager sharedManager] resetPasswordWithusername:teleLabel.text apptoken:[[UserInfo sharedManager] apptoken] verifycode:verifyService newpassword:passField.text hudDic:nil success:^(id responseDic) {
        NSLog(@"--reset--responseDic--%@",responseDic);
        
        //保存用户名，密码到本地，以便于登陆
               
        NSUserDefaults *loginDefalt=[NSUserDefaults standardUserDefaults];
        [loginDefalt setObject:teleLabel.text forKey:@"accout"];
        [loginDefalt setObject:passField.text  forKey:@"password"];
        [loginDefalt synchronize];

        
        HomeLoginViewController *login=[[HomeLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:NO];
    } fail:^(id errorString) {
        NSLog(@"---errorString--%@",errorString);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];

        
    }];
    
}

-(void)doClickSendButton:(UIButton *)btn
{
    NSLog(@"--doClickSendButton---");
    
    timeStart=YES;
    sysTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    // 可以通过fire这个方法去触发timer，即使timer的firing time没有到达
    [sysTimer fire];
    [self getAuthCode];
    
    
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
