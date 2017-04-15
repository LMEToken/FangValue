//
//  HomeVerifyViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//验证页面
#import "HomeVerifyViewController.h"
//注册页面
#import "HomeRegisterViewController.h"
//完善个人信息
#import "HomePersonalInformationViewController.h"
//获取token值
#import "NetTest.h"

@interface HomeVerifyViewController ()

@end

@implementation HomeVerifyViewController




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
    [self setTitle:@"验证"];
    
    //返回按钮
    [self addBackButton];
    
    //右侧按钮
    [self initRightButton];
    
    //初始化背景图
    [self initBackGroundView];
    
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
    [rightButton setFrame:CGRectMake(66, 19, 44, 44)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:16];
    [rightButton addTarget:self action:@selector(doClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    [enLargeRightButton addSubview:rightButton];
    
    
}
-(void)initBackGroundView
{
    detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
    detailLabel.text=@"验证码短信已发送到:";
    detailLabel.font=[UIFont fontWithName:KUIFont size:10];
    detailLabel.backgroundColor=[UIColor clearColor];
    detailLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:detailLabel];
    
    numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x+detailLabel.frame.size.width, detailLabel.frame.origin.y, 100, 20)];
    numberLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"tele"];
    numberLabel.backgroundColor=[UIColor clearColor];
    numberLabel.textColor=[UIColor redColor];
    numberLabel.font=[UIFont fontWithName:KUIFont size:10];
    numberLabel.textColor=[UIColor colorWithRed:142/255.0 green:173/255.0 blue:234/255.0 alpha:1.0];
    [self.contentView addSubview:numberLabel];
    
    
    backView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 50)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    
    iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, 10, 29, 29)];
    iconImageView.image=[UIImage imageNamed:@"homeVerfify"];
    [backView addSubview:iconImageView];
    
    
    vertyView=[[UITextField alloc]initWithFrame:CGRectMake(iconImageView.frame.origin.x+iconImageView.frame.size.width+25, iconImageView.frame.origin.y+5, 200, 20)];
    vertyView.font=[UIFont fontWithName:KUIFont size:13];
    vertyView.placeholder=@"请输入短信验证码";
    vertyView.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"veri"];
    vertyView.delegate=self;
    vertyView.textColor=[UIColor grayColor];
    vertyView.backgroundColor=[UIColor clearColor];
    [backView addSubview:vertyView];
    
    
    UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(20, backView.frame.origin.y+backView.frame.size.height+18, 278, 40);
    [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"发送注册验证码到手机上" forState:UIControlStateNormal];
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
        sendButton.frame=CGRectMake(20, backView.frame.origin.y+backView.frame.size.height+18, 278, 40);
        [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
        [sendButton setTitle:[NSString stringWithFormat:@"重新发送验证码(%@秒)",miao] forState:UIControlStateNormal];
        sendButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
        [self.contentView addSubview:sendButton];
    }else if([d second] == 0) {
        [sysTimer invalidate];
        
        UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(20, backView.frame.origin.y+backView.frame.size.height+18, 278, 40);
        [sendButton setBackgroundImage:[UIImage imageNamed:@"homevertifyButton"] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [sendButton setTitle:@"发送注册验证码到手机上" forState:UIControlStateNormal];
        sendButton.titleLabel.font=[UIFont fontWithName:KUIFont size:12];
        [self.contentView addSubview:sendButton];
    }
}
- (void)getAuthCode{
    
    //将电话号码发送到服务器，服务器返回验证码。
    /*
    -verify--responseDic--{
        data =     {
            verifycode = 7398;
        };
        msg = "\U60a8\U7684\U9a8c\U8bc1\U7801\U662f\Uff1a\U30107398\U3011\U3002\U8bf7\U4e0d\U8981\U628a\U9a8c\U8bc1\U7801\U6cc4\U9732\U7ed9\U5176\U4ed6\U4eba\U3002\U6765\U81ea\U65b9\U521bAPP";
        status = 0;
    }*/

    NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
    //@"a54db1cbaf33fc465799bd89a0edda32972dae2d50639231f306d39f1264edd5"
    
    [[NetManager sharedManager] GetverifycodeWithmobile:numberLabel.text apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1" deviceid:tokenPushString hudDic:nil success:^(id responseDic) {
        NSLog(@"---verify--responseDic--%@",responseDic);
        
        verifyService=[Utils checkKey:responseDic key:@"verifycode"];
        NSLog(@"---verifyService--%@",verifyService);
        
    } fail:^(id errorString) {
        NSLog(@"--verify---errorString--%@",errorString);
        
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请确定手机号未注册同时请检查您的网络是否良好" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
         */
        
    }];
    
   
 
}

#pragma -mark -doClickAction
-(void)doClickRightButton:(UIButton *)btn
{
    NSLog(@"---doClickRightButton--");
    
    if ([vertyView.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"验证码不能为空" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else if (![vertyView.text isEqualToString:verifyService]){
        
       /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误,请重新进行输入" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
       
        */
    }
    
    //将服务器返回的验证码和用户输入的一样的时候，则可以跳转到下一页面，否则弹出提示。
    
    
    HomePersonalInformationViewController *personView=[[HomePersonalInformationViewController alloc]init];
 
    //短信验证码
    NSUserDefaults *veriDefault = [NSUserDefaults standardUserDefaults];
    [veriDefault setObject:vertyView.text forKey:@"veri"];
    [veriDefault synchronize];
    
    [self.navigationController pushViewController:personView animated:NO];
    
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
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
   
    HomeRegisterViewController *regisView=[[HomeRegisterViewController alloc]init];
    
    //短信验证码
    //返回的时候不保存短信验证码
    /*
    NSUserDefaults *veriDefault = [NSUserDefaults standardUserDefaults];
    [veriDefault setObject:vertyView.text forKey:@"veri"];
    [veriDefault synchronize];
    */
    [self.navigationController pushViewController:regisView animated:NO];
  
}
#pragma -mark -UITextFieldDelegate
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
