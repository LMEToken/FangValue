//
//  SignInViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//登录界面
#import "SignInViewController.h"
#import "ForgotPasswordViewController.h"
#import "LookViewController.h"


#import "AppDelegate.h"
#import "SQLite.h"

@interface SignInViewController ()
{
    NSMutableDictionary *configList;
}
@end

@implementation SignInViewController
@synthesize verificationcode;
@synthesize tokenPushString;

//@synthesize signSocket;

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
//     signSocket   =[socketNet sharedSocketNet];
//    signSocket.delegate=self;
	// Do any additional setup after loading the view.
    [self addBackButton];
    [self setTitle:@"登录"];
	[self setTabBarHidden:YES];
    //2014.07.24 chenlihua 隐藏上面的工具条 (alan)
    //2014.08.02 chenlihua 当在同时有“登陆”和“注册”的页面，跳转到登陆界面的时候，不想登陆时，无法返回到同时有“登陆”和“注册”的页面
    // [self setNavigationViewHidden:YES];
    
    //登录背景图片
   // UIImage *image1=[UIImage imageNamed:@"ic_login_bg"];
    //2014.07.24 chenlihua 登陆背景图
    UIImage *image1=[UIImage imageNamed:@"登陆背景图"];
    UIImageView *maneimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 1136/2)];
    [maneimageView setImage:image1];
    [maneimageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:maneimageView];
    
    
    //手机号/邮箱、请输入密码，整个的背景图片
  //  UIImage *image=[UIImage imageNamed:@"01_shurukuang_1"];
    //2014.07.24 chenlihua 修改图标
    UIImage *image=[UIImage imageNamed:@"手机号邮箱整个的背景图片"];
    
  //  UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 140, 507/2, 168/2)];
    //2014.07.24 chenlihua 登陆按钮下移(alan)下移120
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 140+100, 507/2, 168/2)];
    //    [imageView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    [imageView setImage:image];
    [self.contentView addSubview:imageView];
    
    
    //邮箱小图标
  //  UIImage *image0=[UIImage imageNamed:@"ic_phone_email"];
    //2014.07.24 chenlihua 修改了邮箱的图标，变成了人
    UIImage *image0=[UIImage imageNamed:@"用户名图标"];
  //  UIImageView *nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2+15, 150, 45/2, 39/2)];
    //2014.07.24 chenliha 下移120
    UIImageView *nameImageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2+15, 150+100, 45/2, 39/2)];
    [nameImageView setImage:image0];
    [nameImageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:nameImageView];
    
    //密码小图标
  //  UIImage *image2=[UIImage imageNamed:@"ic_password"];
    //2014.07.24 chenlihua 修改密码图标
    UIImage *image2=[UIImage imageNamed:@"密码图标"];
 //   UIImageView *passimageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2+15, 140+51, 45/2, 39/2)];
    //2014.07.24 chenliha 下移120 （alan)
    UIImageView *passimageView=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2+15, 140+51+100, 45/2, 39/2)];
    [passimageView setImage:image2];
    [passimageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:passimageView];
    
    //手机号/邮箱
   // nameTextField=[[UITextField alloc]initWithFrame:CGRectMake((320-507/2)/2+45, 141, 200, 40)];
    //2014.07.24 chenlihua 下移120
    nameTextField=[[UITextField alloc]initWithFrame:CGRectMake((320-507/2)/2+45, 141+100, 200, 40)];
    [nameTextField setBackgroundColor:[UIColor clearColor]];
  //  [nameTextField setPlaceholder:@"手机号/邮箱"];
    //2014.04.21 chenlihua 将手机号/邮箱，改为手机号
    [nameTextField setPlaceholder:@"手机号"];
    [nameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [nameTextField setReturnKeyType:UIReturnKeyNext];
    [nameTextField setDelegate:self];
    [nameTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:nameTextField];
    
    //请输入密码
  //  passTextField=[[UITextField alloc]initWithFrame:CGRectMake((320-507/2)/2+45, 182, 200, 40)];
    //2014.07.24 chenlihua 下移120
    passTextField=[[UITextField alloc]initWithFrame:CGRectMake((320-507/2)/2+45, 182+100, 200, 40)];
    [passTextField setBackgroundColor:[UIColor clearColor]];
    [passTextField setPlaceholder:@"请输入密码"];
    [passTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [passTextField setReturnKeyType:UIReturnKeyNext];
    [passTextField setSecureTextEntry:YES];
    [passTextField setDelegate:self];
    [passTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:passTextField];
    
    //2014.07.01 chenlihua 保存密码
    /*
    [nameTextField setText:@"t001"];
    [passTextField setText:@"123456"];
    */
    NSLog(@"----开始保存-------");
    
    //2014.07.02 chenlihua 使软件登陆后记住密码。若有则直接显示，若没有，则保存为空。
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"accout"] length]) {
        [nameTextField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"accout"]];
        //2014.07.01 chenlihua 保存密码
        [passTextField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];

    }else{
        
         [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"accout"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //获取验证码部分，已经取消
    UIImage *image4=[UIImage imageNamed:@"01_anniu_1"];
    UIButton *huoqueBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [huoqueBut setFrame:CGRectMake((320-507/2)/2, CGRectGetMaxY(imageView.frame)+35/2, 102/2, 33)];
    [huoqueBut.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [huoqueBut setBackgroundImage:image4 forState:UIControlStateNormal];
    [huoqueBut setTitle:@"获取" forState:UIControlStateNormal];
    [huoqueBut addTarget:self action:@selector(HYZMchangeVualeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [huoqueBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[self.contentView addSubview:huoqueBut];
    
    
    UIImage *image5=[UIImage imageNamed:@"01_shurukuang_2"];
    UIImageView *yzimageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(huoqueBut.frame)+20, CGRectGetMaxY(imageView.frame)+35/2, 370/2, 33)];
    [yzimageView setImage:image5];
    [yzimageView setBackgroundColor:[UIColor clearColor]];
    //    [self.contentView addSubview:yzimageView];
    
    
    yzTextField=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(huoqueBut.frame)+30, CGRectGetMaxY(imageView.frame)+35/2, 370/2-20, 33)];
    [yzTextField setBackgroundColor:[UIColor clearColor]];
    [yzTextField setPlaceholder:@"点击获取验证码"];
    [yzTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    yzTextField.enabled = NO;
    //    [yzTextField setReturnKeyType:UIReturnKeyNext];
    [yzTextField setDelegate:self];
    [yzTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    //    [self.contentView addSubview:yzTextField];
    
    
    
    //登录button
    //  UIImage *image6=[UIImage imageNamed:@"03_anniu_1"];
    //2014.07.24 chenlihua 登陆图标
     UIImage *image6=[UIImage imageNamed:@"登陆图标"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    // [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(yzTextField.frame)+20, 508/2, 66/2)];
    //2014.04.21 chenlihua 登录按钮上移
   // [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(yzTextField.frame)-30, 508/2, 66/2)];
    //2014.07.24 chenliha 下移120
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(yzTextField.frame)-30, 508/2, 66/2)];
    
    [button setBackgroundImage:image6 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:button];
    
    //    UIImage *image6=[UIImage imageNamed:@"03_anniu_1"];
    //    UIButton* KKbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [KKbutton setFrame:CGRectMake(140, CGRectGetMaxY(button.frame)+5, 80, 66/2)];
    //    [KKbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [Utils setDefaultFont:KKbutton size:16];
    //    [KKbutton setTitle:@"随便看看" forState:UIControlStateNormal];
    //    [KKbutton addTarget:self action:@selector(Look:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.contentView addSubview:KKbutton];
    
    
    //    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(147, CGRectGetMaxY(button.frame)+30, 66, 0.5)];
    //    [lable setBackgroundColor:[UIColor blueColor]];
    //    [self.contentView addSubview:lable];
    //    [lable release];
    
    
    //    UIImage *image6=[UIImage imageNamed:@"03_anniu_1"];
    
    
    //忘记密码button
    UIButton* WJMMbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [WJMMbutton setFrame:CGRectMake(210, CGRectGetMaxY(button.frame)+5, 90, 66/2)];
    //[WJMMbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //2014.07.24 chenlihua 将忘记密码改成白色
    [WJMMbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:WJMMbutton size:16];
    [WJMMbutton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [WJMMbutton addTarget:self action:@selector(ForgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:WJMMbutton];
    
    
    //忘记密码下划线
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(220, CGRectGetMaxY(button.frame)+30, 70, 0.5)];
   // [lab2 setBackgroundColor:[UIColor blueColor]];
    //2014.07.24 chenlihua 将忘记密码下面的线改成白色
    [lab2 setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:lab2];
    
    
    
    //投资人
    //    [nameTextField setText:@"i002"];
    //    [passTextField setText:@"123456"];
    
    //方创员工
    //    [nameTextField setText:@"t001"];
    //    [passTextField setText:@"123456"];
    
    
    //融资
    //    [nameTextField setText:@"p001"];
    //    [passTextField setText:@"123456"];
    
}
#pragma -mark -doClickAction
//登录

- (void)login:(UIButton*)button
{
    
    //2014.07.02 chenlihua 使软件登陆后，记住密码。
    if ([nameTextField.text isEqualToString:@""]||[passTextField.text isEqualToString:@""]) {
        
        if ([nameTextField.text isEqualToString:@""]) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入完整的账号名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];

        }else if ([passTextField.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入完整的密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
       
    }else{
        

        //2014-08-05 Tom  账号密码输入正确是保持账号密码到文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentD = [paths objectAtIndex:0];
        
        NSString *configFile = [documentD stringByAppendingPathComponent:@"login.plist"];
        configList =[[NSMutableDictionary alloc] initWithContentsOfFile:configFile];
        if ( ![fileManager fileExistsAtPath:configFile]) {
            
            [fileManager createFileAtPath:configFile contents:nil attributes:nil];
        }
        configList = [[NSMutableDictionary alloc] initWithObjectsAndKeys: nameTextField.text,@"username",passTextField.text,@"password",nil];
  
        [configList writeToFile:configFile atomically:YES];
        
        
         [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:@"accout"];
         [[NSUserDefaults standardUserDefaults] setObject:passTextField.text forKey:@"password"];
    }
   
     
    //判断验证码
    //    if (self.verificationcode.length == 0) {
    //        [self.view showActivityOnlyLabel:@"请输入验证码" forSeconds:1.f];
    //        return ;
    //    }
    //    if ([self.verificationcode compare:yzTextField.text] != NSOrderedSame) {
    //        [self.view showActivityOnlyLabel:@"验证码不正确" forSeconds:1.f];
    //        return ;
    //    }
    
    NSLog(@"login.....");
   
    
    [[NetManager sharedManager] LoginWithusername:[nameTextField text] password:[passTextField text] verificationcode:[yzTextField text] hudDic:nil success:^(id responseDic) {
        
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"%@",arr);
        
        
        
        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            //投资人
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"currency"]];//币种
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"idealsize"]];//偏好额度
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"statge"]];//投资伦次
            [[UserInfo sharedManager] setRongzi:[arr objectForKey:@"industry"]];//关注领域
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
        }else
        {
            //创业者权限
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"industry"]];
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"statge"]];
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"teamsize"]];
            [[UserInfo sharedManager] setRongzi:@""];
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
        }
        
        [[UserInfo sharedManager] setPost:[arr objectForKey:@"postion"]];
        [[UserInfo sharedManager] setComname:[arr objectForKey:@"comname"] !=nil ? [arr objectForKey:@"comname"]:@""];
        [[UserInfo sharedManager] setBase:[arr objectForKey:@"base"]
         !=nil ? [arr objectForKey:@"base"]:@""];
        [[UserInfo sharedManager] setUsertype:[arr objectForKey:@"usertype"]!=nil ? [arr objectForKey:@"usertype"]:@""];
        [[UserInfo sharedManager] setUser_name:[arr objectForKey:@"realname"]!=nil ? [arr objectForKey:@"realname"]:@""];
        [[UserInfo sharedManager] setUsername:[arr objectForKey:@"username"]!=nil ? [arr objectForKey:@"username"]:@""];
        [[UserInfo sharedManager] setUserid:[arr objectForKey:@"userid"]!=nil ? [arr objectForKey:@"userid"]:@""];
        [[UserInfo sharedManager] setUseremail:[arr objectForKey:@"email"]!=nil ? [arr objectForKey:@"email"]:@""];
        [[UserInfo sharedManager] setIslogin:YES];
        [[UserInfo sharedManager] setUserphone:[arr objectForKey:@"mobile"]!=nil ? [arr objectForKey:@"mobile"]:@""];
        [[UserInfo sharedManager] setUserpicture:[arr objectForKey:@"picurl2"]
         !=nil ? [arr objectForKey:@"picurl2"]:@""];
        NSString* xb =[arr objectForKey:@"gendar"];
        [[UserInfo sharedManager] setUsergender:xb];
        
        [[UserInfo sharedManager] setWeixin:[arr objectForKey:@"weixin"]];
        [[UserInfo sharedManager] setRecord:[arr objectForKey:@"record"]];
        
        [[UserInfo sharedManager] setDivide:[arr objectForKey:@"divide"]!=nil ? [arr objectForKey:@"divide"]:@""];
        [[UserInfo sharedManager] setDuty:[arr objectForKey:@"duty"]!=nil ? [arr objectForKey:@"duty"]:@""];
        
        
        if ([[arr objectForKey:@"isuploadpro"] isEqualToString:@"0"]) {
            [[UserInfo sharedManager] setIsUploadProject:NO];
        }else{
            [[UserInfo sharedManager] setIsUploadProject:YES];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LogDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [Utils changeViewControllerWithTabbarIndex:5];
        
        NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
        NSLog(@"----------tokenpushString-----%@----",tokenPushString);
        
        [[NetManager sharedManager] getPushTokenWithpushtoken:tokenPushString
                                                       hudDic:nil success:^(id responseDic) {
                                                           
                                                           ;
                                                           
                                                       } fail:^(id errorString) {
                                                           ;
                                                       }];
        
        
    } fail:^(id errorString) {
        
        //hud 冲突
        sleep(2);
        //                                              [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
        [self.view showActivityOnlyLabel:errorString forSeconds:5];
    }];
}
 - (void)viewDidDisappear:(BOOL)animated
{
    
   
}
//忘记密码
- (void)ForgotPassword:(UIButton *)sender{
    ForgotPasswordViewController *tl=[[ForgotPasswordViewController alloc]init];
    [self.navigationController pushViewController:tl animated:YES];
    
}
#pragma -mark -doClickAction
//返回按钮
- (void) backButtonAction : (id) sender
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView commitAnimations];
}

//- (void)Look:(UIButton *)sender{
//    LookViewController *look=[[LookViewController alloc]init];
//    [self.navigationController pushViewController:look animated:YES];
//    [look release];
//}

//发送验证码，已经取消
-(void)HYZMchangeVualeEvent:(UIButton *)sender{
    NSLog(@"发送验证码");
    
    [[NetManager sharedManager] GetLoginVerificationCodeWithusername:nameTextField.text
                                                              hudDic:nil
                                                             success:^(id responseDic) {
                                                                 self.verificationcode = [Utils checkKey:responseDic key:@"verificationcode"];
                                                                 [yzTextField setText:self.verificationcode];
                                                                 //                                                                 [sender setTitle:self.verificationcode forState:UIControlStateNormal];
                                                                 
                                                             }
                                                                fail:^(id errorString) {
                                                                    [self.view showActivityOnlyLabel:[NSString stringWithFormat:@"%@",errorString] forSeconds:1.f];
                                                                }];
}

#pragma -mark  -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:nameTextField]) {
        [passTextField becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:passTextField]){
        [yzTextField becomeFirstResponder];
        return YES;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            if ([[Utils systemVersion] floatValue] >= 7.) {
               self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
               
            }
            else
            {
                
                self.contentView.frame=CGRectMake(0, 44, 320, self.contentViewHeight);
                
                
            }
        } completion:^(BOOL finished) {
            
        }];
        
        [yzTextField resignFirstResponder];
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
       // self.contentView.frame=CGRectMake(0, -70, 320, self.contentViewHeight);
        //2014.07.25 chenlihua 解决3.5寸的时候，登陆按钮会看不见的问题
        self.contentView.frame=CGRectMake(0, -120, 320, self.contentViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}
#pragma -mark -iphone翻转
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait||toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
- (BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//
//#pragma -mark -AsyncSocketDelegate
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    
//    
//    
//    [signSocket readDataWithTimeout:-1 tag:200];
//    
//}
//- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
//
//    return YES;
//}
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [signSocket readDataWithTimeout:-1 tag:200];
//    
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//    
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    
//    [signSocket disconnect];
//    
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//}
@end
