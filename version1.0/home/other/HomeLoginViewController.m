//
//  HomeLoginViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-9-27.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//登陆页面

#import "HomeLoginViewController.h"
//注册页面
#import "HomeRegisterViewController.h"
//方创主界面
#import "FangChuangInsiderViewController.h"
//获取token值
#import "NetTest.h"
//忘记密码界面
#import "HomeForgetPasswordViewController.h"

@interface HomeLoginViewController ()

@end

@implementation HomeLoginViewController


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
#pragma  -mark -数据库语句
-(void)execSql:(NSString *)sql
{
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != 0) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    sqlite3_close(db);
    db = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *sqlQuery =[NSString stringWithFormat:@"DELETE FROM %@", @"UNREAD4"];
    [self execSql:sqlQuery];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"tuichudenglu"];
    [userDefaults synchronize];
    // Do any additional setup after loading the view.
    //标题
    [self setTitle:@"登录"];
    
    //初始化背景图
    [self initBackgroundView];
    
    //隐藏工具条
    [self setTabBarHidden:YES];
//  [self login:teleField.text password:passField.text];
}
#pragma -mark -functions
-(void)initBackgroundView
{
    
    //背景UIScrollerView
    backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [backScrollerView setBackgroundColor:[UIColor clearColor]];
    [backScrollerView setShowsVerticalScrollIndicator:NO];
    [backScrollerView setContentSize:CGSizeMake(320,self.contentViewHeight+3
                                                )];
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
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"accout"]) {
        teleField.placeholder=@"请输入您的手机号码";
    }else{
        teleField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"accout"];
    }
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
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"password"]) {
        passField.placeholder=@"请输入您的密码";
    }else{
        passField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    }
    passField.textColor=[UIColor grayColor];
    passField.font=[UIFont fontWithName:KUIFont size:13];
    passField.backgroundColor=[UIColor clearColor];
    passField.secureTextEntry=YES;
    passField.delegate=self;
    [passWordView addSubview:passField];
    
    
    //注册账号
    registerButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerButton.frame=CGRectMake(passImageView.frame.origin.x,passWordView.frame.origin.y+passWordView.frame.size.height+15, 49, 13);
    [registerButton setBackgroundImage:[UIImage imageNamed:@"homeloginregisterButton"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(doClickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:registerButton];
    
    //注册账号下的线
    registerLine=[[UIImageView alloc]initWithFrame:CGRectMake(registerButton.frame.origin.x, registerButton.frame.origin.y+registerButton.frame.size.height+2, 50, 0.5)];
    registerLine.backgroundColor=[UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:0.3];
    [backScrollerView addSubview:registerLine];
    
    
    //忘记密码按钮
    passButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    passButton.frame=CGRectMake(registerButton.frame.origin.x+230,passWordView.frame.origin.y+passWordView.frame.size.height+15, 62, 13);
    [passButton setBackgroundImage:[UIImage imageNamed:@"homeloginpasswordbutton"] forState:UIControlStateNormal];
    [passButton addTarget:self action:@selector(doClickPassButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:passButton];
    
    
    //忘记密码下的线
    passLine=[[UIImageView alloc]initWithFrame:CGRectMake(passButton.frame.origin.x, passButton.frame.origin.y+passButton.frame.size.height+2, 50, 0.5)];
    passLine.backgroundColor=[UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:0.3];
    [backScrollerView addSubview:passLine];
    
    //登陆按钮
    loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame=CGRectMake(20, passWordView.frame.origin.y+passWordView.frame.size.height+75, 275, 37);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"homeloginButtonLogin"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(doClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:loginButton];
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
- (void) login:(NSString *)username password:(NSString *)password
{
    [[NetManager sharedManager] LoginWithusername:username password:password verificationcode:@"" hudDic:nil success:^(id responseDic) {
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"---login--%@",arr);

        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            //投资人
            //币种
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"2" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
               
               [[UserInfo sharedManager] setLingyu:chooseStr];//币种
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //偏好额度
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"5" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
               [[UserInfo sharedManager] setJieduan:chooseStr];//偏好额度
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //投资轮次
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                 [[UserInfo sharedManager] setGuimo:chooseStr];//投资伦次
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //关注领域
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"4" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                 [[UserInfo sharedManager] setRongzi:chooseStr];//关注领域
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
           
            
            /*
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"currency"]];//币种
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"idealsize"]];//偏好额度
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"statge"]];//投资伦次
            [[UserInfo sharedManager] setRongzi:[arr objectForKey:@"industry"]];//关注领域
             */
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
             
        }else
        {
            
            //所属领域
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"4" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setLingyu:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //阶段
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"3" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                 [[UserInfo sharedManager] setJieduan:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //团队规模
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"6" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
               [[UserInfo sharedManager] setGuimo:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //融资状态
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
               [[UserInfo sharedManager] setRongzi:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            

            //创业者权限
            /*
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"industry"]];
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"statge"]];
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"teamsize"]];
            [[UserInfo sharedManager] setRongzi:@""];
             */
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
        
       
        
        NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
        NSLog(@"----------tokenpushString-----%@----",tokenPushString);
        
        [[NetManager sharedManager] getPushTokenWithpushtoken:tokenPushString
                                                       hudDic:nil success:^(id responseDic) {
                                                           
                                                           ;
                                                           
                                                       } fail:^(id errorString) {
                                                           return ;
                                                       }];
        
        [Utils changeViewControllerWithTabbarIndex:5];
        
        
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"登录成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
       */

        
    } fail:^(id errorString) {
        
        /*
        HomeLoginViewController *rootVC=[[HomeLoginViewController alloc]init];
        [self.navigationController pushViewController:rootVC animated:NO];
         */
        NSLog(@"-login--errorString--%@",errorString);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"登录失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];

        
    }];
    
    
}
#pragma -mark -doClickActions
//注册账号
-(void)doClickRegisterButton:(UIButton *)btn
{
    NSLog(@"--doClickRegisterButton--");
    
    HomeRegisterViewController *resView=[[HomeRegisterViewController alloc]init];
    
    //用户名清空
    
    NSUserDefaults *teleDefault = [NSUserDefaults standardUserDefaults];
    [teleDefault setObject:@"" forKey:@"tele"];
    [teleDefault synchronize];
    
    //密码清空
    NSUserDefaults *passDefault=[NSUserDefaults standardUserDefaults];
    [passDefault setObject:@"" forKey:@"pass"];
    [passDefault synchronize];
   
    //短信验证码
    NSUserDefaults *veriDefault = [NSUserDefaults standardUserDefaults];
    [veriDefault setObject:@"" forKey:@"veri"];
    [veriDefault synchronize];
    
    //完善个人资料
     NSUserDefaults *infoDefault = [NSUserDefaults standardUserDefaults];
    [infoDefault setObject:@"" forKey:@"name"];
    [infoDefault setObject:@"" forKey:@"company"];
    [infoDefault setObject:@"" forKey:@"compostion"];
    [infoDefault setObject:@"" forKey:@"email"];
    [infoDefault setObject:@"" forKey:@"url"];
    [infoDefault synchronize];
    
    
    //完善创业者资料
    NSUserDefaults *entreDefault = [NSUserDefaults standardUserDefaults];
    [entreDefault setObject:@"" forKey:@"scale-e"];
    [entreDefault setObject:@""  forKey:@"money-e"];
    [entreDefault setObject:@"" forKey:@"stage-e"];
    [entreDefault setObject:@""  forKey:@"business-e"];
    [entreDefault setObject:@""  forKey:@"team-e"];
    [entreDefault synchronize];


    //完善投资者资料
    NSUserDefaults *investDefault = [NSUserDefaults standardUserDefaults];
    [investDefault setObject:@"" forKey:@"scale-i"];
    [investDefault setObject:@"" forKey:@"money-i"];
    [investDefault setObject:@"" forKey:@"stage-i"];
    [investDefault setObject:@"" forKey:@"business-i"];
    [investDefault setObject:@"" forKey:@"team-i"];
    [investDefault synchronize];

    //创业者清空
    NSUserDefaults *enDefault = [NSUserDefaults standardUserDefaults];
    [enDefault setObject:@"" forKey:@"iden"];
    [enDefault synchronize];
    
    //投资者清空
    NSUserDefaults *inDefault = [NSUserDefaults standardUserDefaults];
    [inDefault setObject:@"" forKey:@"iden"];
    [inDefault synchronize];
    
    //创业者坐标清空
    NSUserDefaults *servere=[NSUserDefaults standardUserDefaults];
    [servere setObject:@"" forKey:@"server-business-e"];
    [servere setObject:@"" forKey:@"server-money-e"];
    [servere setObject:@"" forKey:@"server-scale-e"];
    [servere setObject:@"" forKey:@"server-stage-e"];
    [servere synchronize];

    //投资者坐标清空
     NSUserDefaults *serveri=[NSUserDefaults standardUserDefaults];
     [serveri setObject:@"" forKey:@"server-currency-i"];
     [serveri setObject:@"" forKey:@"server-money-i"];
     [serveri setObject:@"" forKey:@"server-turn-i"];
     [serveri setObject:@"" forKey:@"server-zone-i"];
     [serveri synchronize];
    
    //名片清空
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:[UIImage imageNamed:@""]];
    NSUserDefaults *imageDefault = [NSUserDefaults standardUserDefaults];
    [imageDefault setObject:data forKey:@"image"];
    [imageDefault synchronize];



    [self.navigationController pushViewController:resView animated:NO];
}
//忘记密码
-(void)doClickPassButton:(UIButton *)btn
{
    NSLog(@"--doClickPassButton--");
    
    //手机号码清空
    NSUserDefaults *teleDefault = [NSUserDefaults standardUserDefaults];
    [teleDefault setObject:@"" forKey:@"forget-tele"];
    [teleDefault synchronize];
    
    //验证码清空
    NSUserDefaults *testDefault = [NSUserDefaults standardUserDefaults];
    [testDefault setObject:@"" forKey:@"forget-test"];
    [testDefault synchronize];
    
    //密码清空
    NSUserDefaults *passDefault = [NSUserDefaults standardUserDefaults];
    [passDefault setObject:@"" forKey:@"forget-pass"];
    [passDefault synchronize];

    
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机找回密码", nil];
    [actionSheet showInView:self.view];
   
    
}
//登陆
-(void)doClickLoginButton:(UIButton *)btn
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
        
    }
  
    [self login:teleField.text password:passField.text];
 
    NSUserDefaults *loginDefalt=[NSUserDefaults standardUserDefaults];
    [loginDefalt setObject:teleField.text forKey:@"accout"];
    [loginDefalt setObject:passField.text  forKey:@"password"];
    [loginDefalt synchronize];
    
    
     [[NSUserDefaults standardUserDefaults] setObject:teleField.text forKey:@"usernameid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [[NSUserDefaults standardUserDefaults] setObject:passField.text forKey:@"usernamepwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   
    
}
#pragma -mark -UITextfieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            HomeForgetPasswordViewController *forget=[[HomeForgetPasswordViewController alloc]init];
            [self.navigationController pushViewController:forget animated:NO];
        }
            break;
        case 1:
        {
            ;
        }
            break;
        default:
            break;
    }
}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subViwe in actionSheet.subviews) {
        if ([subViwe isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subViwe;
            button.titleLabel.font=[UIFont fontWithName:KUIFont size:15];
           
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
