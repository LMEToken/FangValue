//
//  InformationViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//第一步注册页面

#import "InformationViewController.h"
#import "RegistrationViewController.h"
@interface InformationViewController ()
{
    NSTimer* sysTimer;
    BOOL timeStart;
    BOOL isSending;
}
@property (nonatomic,strong) RegistrationViewController *tl;


@property (nonatomic,strong) UIButton* sendYZM;
//@property (nonatomic,retain) UIButton *twoSend;
//@property (nonatomic,retain) UIButton *oneSend;

@end

@implementation InformationViewController

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
    
    //返回按钮
    [self addBackButton];
    //题目
    [self setTitle:@"注册"];
    //隐藏tabbar,也就是下面的4个模块
    [self setTabBarHidden:YES];
    isSending = NO;
    

	// “方创”背景图片
    UIImage *image=[UIImage imageNamed:@"ic_logo"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(55, 20, 210, 110)];
    //调整图片以适应大小
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:image];
    //此处是继承了parentViewController,所以是self.contentView
    [self.contentView addSubview:imageView];
   
    
    //有黄边的背景图片
    UIImage *image001=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *imageView001=[[UIImageView alloc]initWithFrame:CGRectMake(33, CGRectGetMaxY(imageView.frame)+10, 320-66, 40)];
    [imageView001 setBackgroundColor:[UIColor clearColor]];
    [imageView001 setImage:image001];
    [self.contentView addSubview:imageView001];

    
    //输入手机号的textField
   // telTextField=[[UITextField alloc]initWithFrame:CGRectMake(33+40, CGRectGetMaxY(imageView.frame)+10, 320-26, 40)];
    telTextField=[[UITextField alloc]initWithFrame:CGRectMake(33+40, CGRectGetMaxY(imageView.frame)+10, 215, 40)];
    [telTextField setBackgroundColor:[UIColor clearColor]];
    [telTextField setPlaceholder:@"请输入注册手机号"];
    [telTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [telTextField setClearsContextBeforeDrawing:YES];
    [telTextField setDelegate:self];
    [telTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:telTextField];
    
    
    //邮件的图标
    UIImage *imageZH=[UIImage imageNamed:@"01_tubiao_2"];
    UIImageView *nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake(43, CGRectGetMaxY(imageView.frame)+20, 36/2, 39/2)];
    [nameImageView setImage:imageZH];
    [nameImageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:nameImageView];

    
    
    //输入验证码的背景图片
    //    UIImage *image1=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(33, CGRectGetMaxY(telTextField.frame)+10, 320-66, 30)];
    [image1 setImage:[UIImage imageNamed:@"01_shurukuang_2"]];
    [self.contentView addSubview:image1];

    
    //输入验证码 textField
    yanzTextField=[[UITextField alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(telTextField.frame)+10, 320-70, 30)];
    [yanzTextField setBackgroundColor:[UIColor clearColor]];
    //    [yanzTextField setBackground:image1];
    [yanzTextField setPlaceholder:@"请输入验证码"];
    //2014.08.19 chenlihua 将输入验证码的键盘变为正常键盘。
   // [yanzTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [yanzTextField setClearsContextBeforeDrawing:YES];
    [yanzTextField setDelegate:self];
    [yanzTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:yanzTextField];
    
    
    
    
    _sendYZM=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendYZM setFrame:CGRectMake(100, CGRectGetMaxY(yanzTextField.frame)+5, 180, 20)];
    [self.sendYZM setBackgroundColor:[UIColor clearColor]];
    //设置字体为15
    [Utils setDefaultFont:self.sendYZM size:15];
    [self.sendYZM setTitle:@"发送注册验证码到手机上" forState:UIControlStateNormal];
    [self.sendYZM setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.sendYZM addTarget:self action:@selector(senderYAMEvent:) forControlEvents:UIControlEventTouchUpInside];
    //2014.07.04 chenlihua 暂时取消原来按钮
   // [self.contentView addSubview:self.sendYZM];
   
    
    //2014.07.04 chenlihua 新增按钮
    UIButton *newSend=[UIButton buttonWithType:UIButtonTypeCustom];
    [newSend setFrame:CGRectMake(100, CGRectGetMaxY(yanzTextField.frame)+5, 180, 20)];
    [newSend setBackgroundColor:[UIColor clearColor]];
    //设置字体为15
    [Utils setDefaultFont:newSend size:15];
    [newSend setTitle:@"发送注册验证码到手机上" forState:UIControlStateNormal];
    [newSend setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
    [newSend addTarget:self action:@selector(senderYAMEvent:) forControlEvents:UIControlEventTouchUpInside];
    newSend.tag=1000000;
    [newSend setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:newSend];
    
    
    //发送验证码到手机上，下划线
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(105, CGRectGetMaxY(yanzTextField.frame)+22, 170, 0.5)];
    [lab setBackgroundColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0]];
    [self.contentView addSubview:lab];

    
    //请输入密码背景图
    UIImage *image002=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *imageView002=[[UIImageView alloc]initWithFrame:CGRectMake(33, CGRectGetMaxY(self.sendYZM.frame)+10, 320-66, 40)];
    [imageView002 setBackgroundColor:[UIColor clearColor]];
    [imageView002 setImage:image002];
    [self.contentView addSubview:imageView002];

    
    //请输入密码-textField
    passwdTextField=[[UITextField alloc]initWithFrame:CGRectMake(33+40, CGRectGetMaxY(self.sendYZM.frame)+10, 215, 40)];
  //  passwdTextField=[[UITextField alloc]initWithFrame:CGRectMake(33+40, CGRectGetMaxY(newSendYZM.frame)+10, 215, 40)];
    [passwdTextField setBackgroundColor:[UIColor clearColor]];
    //    [passwdTextField setBackground:image1];
    [passwdTextField setPlaceholder:@"请输入密码"];
    [passwdTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [passwdTextField setClearsContextBeforeDrawing:YES];
    [passwdTextField setSecureTextEntry:YES];
    [passwdTextField setDelegate:self];
    [passwdTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:passwdTextField];
    
    
    //请输入密码前面的图标
    UIImage *imageMM=[UIImage imageNamed:@"01_tubiao_1"];
    UIImageView *passimageView=[[UIImageView alloc]initWithFrame:CGRectMake(33+10, CGRectGetMaxY(self.sendYZM.frame)+20, 36/2, 39/2)];
   // UIImageView *passimageView=[[UIImageView alloc]initWithFrame:CGRectMake(33+10, CGRectGetMaxY(newSendYZM.frame)+20, 36/2, 39/2)];
    [passimageView setImage:imageMM];
    [passimageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:passimageView];

    
    //请重新输入密码背景图
    UIImage *image003=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *imageView003=[[UIImageView alloc]initWithFrame:CGRectMake(33, CGRectGetMaxY(passwdTextField.frame)+10, 320-66, 40)];
    [imageView003 setBackgroundColor:[UIColor clearColor]];
    [imageView003 setImage:image003];
    [self.contentView addSubview:imageView003];

    //请重新输入密码-textField
    pswdTextField=[[UITextField alloc]initWithFrame:CGRectMake(33+40, CGRectGetMaxY(passwdTextField.frame)+10, 215, 40)];
    [pswdTextField setBackgroundColor:[UIColor clearColor]];
    //    [pswdTextField setBackground:image1];
    [pswdTextField setPlaceholder:@"请重新输入密码"];
    [pswdTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [pswdTextField setClearsContextBeforeDrawing:YES];
    [pswdTextField setSecureTextEntry:YES];
    [pswdTextField setDelegate:self];
    [pswdTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:pswdTextField];
    
    
    //请重新输入密码，前面的图标
    UIImage *imageMM2=[UIImage imageNamed:@"01_tubiao_1"];
    UIImageView *pswdimageView=[[UIImageView alloc]initWithFrame:CGRectMake(43, CGRectGetMaxY(passwdTextField.frame)+20, 36/2, 39/2)];
    [pswdimageView setImage:imageMM2];
    [pswdimageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:pswdimageView];

    
    
    //下一步按钮
   // UIImage *image3=[UIImage imageNamed:@"03_anniu_1"];
    //2014.07.29 chenlihua 修改“下一步”图标
    UIImage *image3=[UIImage imageNamed:@"退出登录|下一步"];
    
    UIButton *nextBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [nextBut setFrame:CGRectMake((320-508/2)/2, CGRectGetMaxY(pswdTextField.frame)+20, 508/2, 66/2)];
    [nextBut setBackgroundColor:[UIColor clearColor]];
    [nextBut setBackgroundImage:image3 forState:UIControlStateNormal];
    [nextBut setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBut addTarget:self action:@selector(nextEvent:) forControlEvents:UIControlEventTouchUpInside];
    nextBut.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:nextBut];
    
}


#pragma -mark -doClickAction
//发送验证码到手机上
- (void)senderYAMEvent:(UIButton *)sender{
    
    if (![self validateMobile:telTextField.text]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请正确输入手机号"];
        return;
    }
    
    if (!isSending){
        isSending = YES;
        [self startTimerCount];
    }
    if (![yanzTextField isFirstResponder]) {
        [self.view resignFirstResponder];
        [yanzTextField becomeFirstResponder];

    }

}
- (void)nextEvent:(UIButton *)sender{
    
    
    if (![self validateMobile:telTextField.text]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请正确输入手机号"];
        return;
    }
    
    if ( yanzTextField.text.length == 0 || [self.verificationcode compare:yanzTextField.text] != NSOrderedSame) {
        [self.view showActivityOnlyLabelWithOneMiao:@"验证码错误"];
        return ;
    }
    
    if (passwdTextField.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请输入密码"];
        return;
    }
    
    if (pswdTextField.text.length == 0) {
        [self.view showActivityOnlyLabelWithOneMiao:@"请再次输入密码"];
        return;
    }
    if (![passwdTextField.text isEqualToString:passwdTextField.text]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"两次输入的密码不一致"];
        return ;
    }
    _tl = [[RegistrationViewController alloc]initavlueNextaccout:telTextField.text password:passwdTextField.text verificationcode:yanzTextField.text];
    self.tl.data = [NSDictionary dictionaryWithObjectsAndKeys:telTextField.text,@"phone",passwdTextField.text,@"password",self.verificationcode,@"code", nil];
    [self.navigationController pushViewController:self.tl animated:YES];
}
- (void) backButtonAction : (id) sender
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView commitAnimations];
    
}

#pragma -mark -function
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
- (void)startTimerCount{
    
    timeStart = YES;
    sysTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    [sysTimer fire];
    telTextField.enabled = NO;
    self.sendYZM.enabled = NO;
    [self getAuthCode];

}
- (void)timerFireMethod:(NSTimer *)timer

{
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
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
    
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
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
    
     NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    
    //    NSString *fen = [NSString stringWithFormat:@"%d", [d minute]];
    //
    //    if([d minute] < 10) {
    //
    //        fen = [NSString stringWithFormat:@"0%d",[d minute]];
    //
    //    }
    
    //    NSString *miao = [NSString stringWithFormat:@"%d", [d second]];
    
    if([d second] < 180 && [d second] > 0) {
        NSString *miao = [NSString stringWithFormat:@"%d",[d second]];
        
        //2014.07.04 chenlihua 发送验证码，倒计时不成功
       
       /*
        [button setTitle:[NSString stringWithFormat:@"重新发送验证码(%@秒)",miao] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        */
        UIButton *oldSend=(UIButton *)[self.view viewWithTag:1000000];
        [oldSend removeFromSuperview];
        
        UIButton *oldTwoSend=(UIButton *)[self.view viewWithTag:1000001];
        [oldTwoSend removeFromSuperview];
        
        UIButton *oldThreeSend=(UIButton *)[self.view viewWithTag:1000002];
        [oldThreeSend removeFromSuperview];
        
        
        //2014.07.04 chenlihua 新增按钮
        UIButton *newSend=[UIButton buttonWithType:UIButtonTypeCustom];
        [newSend setFrame:CGRectMake(100, CGRectGetMaxY(yanzTextField.frame)+5, 180, 20)];
        [newSend setBackgroundColor:[UIColor clearColor]];
        //设置字体为15
        [Utils setDefaultFont:newSend size:15];
        [newSend setTitle:[NSString stringWithFormat:@"重新发送验证码(%@秒)",miao] forState:UIControlStateNormal];
        [newSend setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       // [newSend setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
        newSend.tag=1000001;
      //  [newSend addTarget:self action:@selector(senderYAMEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:newSend];
        
         //计时尚未结束，do_something
    }else if([d second] == 0) {
        isSending = NO;
        //计时1分钟结束，do_something
        [sysTimer invalidate];
        
        telTextField.enabled = YES;
        
        //2014.0704 chenlihua 发送验证码不成功
        /*
        [self.sendYZM setTitle:[NSString stringWithFormat:@"重新发送验证码"] forState:UIControlStateNormal];
        [self.sendYZM setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        self.sendYZM.enabled = YES;
        */
        
        UIButton *oldSend=(UIButton *)[self.view viewWithTag:1000000];
        [oldSend removeFromSuperview];
        
        UIButton *oldTwoSend=(UIButton *)[self.view viewWithTag:1000001];
        [oldTwoSend removeFromSuperview];
        
        //2014.07.04 chenlihua 新增按钮
        UIButton *newSend=[UIButton buttonWithType:UIButtonTypeCustom];
        [newSend setFrame:CGRectMake(100, CGRectGetMaxY(yanzTextField.frame)+5, 180, 20)];
        [newSend setBackgroundColor:[UIColor clearColor]];
        //设置字体为15
        [Utils setDefaultFont:newSend size:15];
        [newSend setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        [newSend setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
        newSend.tag=1000002;
        [newSend addTarget:self action:@selector(senderYAMEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:newSend];
        
       }
}
- (void)getAuthCode{
    [[NetManager sharedManager] GetRegisterVerificationCodeWithuserphonenumber:telTextField.text
                                                                        hudDic:nil
                                                                       success:^(id responseDic) {
                                                                           
                                                                           self.verificationcode = [Utils checkKey:responseDic key:@"verificationcode"];
                                                                           
                                                                           UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码已发送至您的手机！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                           
                                                                           [alert show];
                      
                                                                           
                                                                           
                                                                           NSLog(@"dic====%@",responseDic);
                                                                       } fail:^(id errorString) {
                                                                           
                                                                           [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                                           
                                                                       }];

}

#pragma -mark -textFielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:telTextField]) {
        [yanzTextField becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:yanzTextField]){
        [UIView beginAnimations:@"" context:nil];
        self.contentView.frame=CGRectMake(0, 65, 320, self.contentViewHeight);
        [UIView commitAnimations];
        [yanzTextField resignFirstResponder];
        return YES;
    }
    
    if ([textField isEqual:passwdTextField]) {
        [pswdTextField becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:pswdTextField]){
        [UIView beginAnimations:@"" context:nil];
        self.contentView.frame=CGRectMake(0, 65, 320, self.contentViewHeight);
        [UIView commitAnimations];
        [pswdTextField resignFirstResponder];
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:telTextField]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.frame = CGRectMake(0, -60, 320, self.contentViewHeight);
        } completion:^(BOOL finished) {
            
        }];
    }else if ([textField isEqual:passwdTextField]){
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.frame = CGRectMake(0, -70, 320, self.contentViewHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:telTextField]) {
        
        if (![self validateMobile:telTextField.text]) {
            [self.view showActivityOnlyLabelWithOneMiao:@"请正确输入手机号"];
            return;
        }else{
            if (!isSending) {
                isSending = YES;
                [self startTimerCount];
            }
         }
     }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
