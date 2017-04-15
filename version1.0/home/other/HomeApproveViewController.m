//
//  HomeApproveViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-10-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//认证页面
#import "HomeApproveViewController.h"
//创业者
#import "HomeEntreViewController.h"
//投资者
#import "homeInvestorViewController.h"
//方创主界面
#import "FangChuangInsiderViewController.h"
//获取token值
#import "NetTest.h"
//项目介绍
#import "HomeEntreInstructionViewController.h"
//公司介绍
#import "HomeInvestorInstructionViewController.h"



@interface HomeApproveViewController ()

@end

@implementation HomeApproveViewController

@synthesize flag;

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
    [self setTitle:@"认证"];
    
    //返回按钮
    [self addBackButton];
    
    //初始化背景图
    [self initBackgroundView];
    
    //隐藏工具条
    [self setTabBarHidden:YES];
    
}
#pragma -mark -doClickActions
//返回按钮
- (void) backButtonAction : (id) sender
{
    NSLog(@"--backButtonAction---");
    if ([self.flag isEqualToString:@"entre"]) {
        HomeEntreInstructionViewController *entre=[[HomeEntreInstructionViewController alloc]init];
        [self.navigationController pushViewController:entre animated:NO];

    }else if ([self.flag isEqualToString:@"investor"]){
        
        HomeInvestorInstructionViewController *invest=[[HomeInvestorInstructionViewController alloc]init];
        [self.navigationController pushViewController:invest animated:NO];
    }
        
   
}
//开始方创按钮
-(void)doClickBeginButton:(UIButton *)btn
{
    //将名片信息传到服务器。同时跳转到方创界面
    NSLog(@"---doClickBeginButton---");
    
    username=[[NSUserDefaults standardUserDefaults]objectForKey:@"tele"];
    password=[[NSUserDefaults standardUserDefaults]objectForKey:@"pass"];
    verificationcode=[[NSUserDefaults standardUserDefaults]objectForKey:@"veri"];
    mobile=[[NSUserDefaults standardUserDefaults]objectForKey:@"tele"];
    realname=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    comname=[[NSUserDefaults standardUserDefaults]objectForKey:@"company"];
    position=[[NSUserDefaults standardUserDefaults]objectForKey:@"compostion"];
    email=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    comurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"url"];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"iden"]isEqualToString:@"entre"]) {
        
        registerType=@"0";
        
        fmoney=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-money-e"];
        statge=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-stage-e"];
        industry=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-business-e"];
        pdesc=[[NSUserDefaults standardUserDefaults]objectForKey:@"team-e"];
        teamsize=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-stage-e"];
        
        proteam=@"";
        currency=@"";
        
    }else{
        
        registerType=@"1";
        
        fmoney=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-money-i"];
        statge=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-turn-i"];
        industry=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-zone-i"];
        pdesc=[[NSUserDefaults standardUserDefaults]objectForKey:@"team-i"];
        currency=[[NSUserDefaults standardUserDefaults]objectForKey:@"server-currency-i"];
        
        proteam=@"";
        teamsize=@"";

    }
    
    
    //判断名片是否为空。
    if (!headImage.image) {
        
        /*
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请上传名片" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
         */
       
    }
    
    //上传名片
    NSString* path =  [Utils ImagePath:headImage.image];
    [[NetManager sharedManager] uptcardWithUsername:username apptoken:[[UserInfo sharedManager] apptoken] userpicture:path hudDic:nil success:^(id responseDic) {
        NSLog(@"--picture--responseDic--%@--",responseDic);
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"名片上传成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        
        
    } fail:^(id errorString) {
        NSLog(@"-picture--errorString--");
        
        return ;
    }];

    
    /*[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"] */
    /*@"a54db1cbaf33fc465799bd89a0edda32972dae2d50639231f306d39f1264edd5"*/
    
   // [[UserInfo sharedManager] apptoken]
    //@"app5472a7d5b8372"
    
    //上传基本信息
    [[NetManager sharedManager] getRegisterWithusername:username apptoken:[[UserInfo sharedManager] apptoken] password:password registertype:registerType deviceid:[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"] verificationcode:verificationcode mobile:mobile realname:realname comname:comname position:position email:email comurl:comurl fmoney:fmoney statge:statge industry:industry pdesc:pdesc proteam:proteam teamsize:teamsize currency:currency hudDic:nil success:^(id responseDic) {
        NSLog(@"-approve--responseDic--%@-",responseDic);
        
        
       //登陆的操作
        
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"--arr--%@",arr);
        
        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            
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

            //投资人
            /*
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"currency"]];//币种
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"fmoney"]];//偏好额度
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"statge"]];//投资伦次
            [[UserInfo sharedManager] setRongzi:[arr objectForKey:@"industry"]];//关注领域
             */
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
            [[UserInfo sharedManager] setDiffID:@"1"];

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
            [[UserInfo sharedManager] setDiffID:@"0"];

        }
        
        [[UserInfo sharedManager] setPost:[arr objectForKey:@"postion"]];
        [[UserInfo sharedManager] setComname:[arr objectForKey:@"comname"] !=nil ? [arr objectForKey:@"comname"]:@""];
        [[UserInfo sharedManager] setBase:[arr objectForKey:@"base"]];
        [[UserInfo sharedManager] setUsertype:[arr objectForKey:@"usertype"]];
        [[UserInfo sharedManager] setUser_name:[arr objectForKey:@"realname"]];
        [[UserInfo sharedManager] setUsername:[arr objectForKey:@"username"]];
        [[UserInfo sharedManager] setUserid:[arr objectForKey:@"userid"]];
        [[UserInfo sharedManager] setUseremail:[arr objectForKey:@"email"]];
        [[UserInfo sharedManager] setIslogin:YES];
        [[UserInfo sharedManager] setUserphone:[arr objectForKey:@"mobile"]];
        [[UserInfo sharedManager] setUserpicture:[arr objectForKey:@"picurl2"]];
        NSString* xb =[arr objectForKey:@"gendar"];
        [[UserInfo sharedManager] setUsergender:xb];
        
        [[UserInfo sharedManager] setWeixin:[arr objectForKey:@"weixin"]];
        [[UserInfo sharedManager] setRecord:[arr objectForKey:@"record"]];
        
        [[UserInfo sharedManager] setDivide:[arr objectForKey:@"divide"]];
        [[UserInfo sharedManager] setDuty:[arr objectForKey:@"duty"]];
        
        
        if ([[arr objectForKey:@"isuploadpro"] isEqualToString:@"0"]) {
            [[UserInfo sharedManager] setIsUploadProject:NO];
        }else{
            [[UserInfo sharedManager] setIsUploadProject:YES];
        }
        
        
        NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
        NSLog(@"----------tokenpushString-----%@----",tokenPushString);
        
        //进行信鸽推送
        [[NetManager sharedManager] getPushTokenWithpushtoken:tokenPushString
                                                       hudDic:nil success:^(id responseDic) {
                                                           
                                                           //将用户名，密码保存到本地
                                                           
                                                           NSUserDefaults *loginDefalt=[NSUserDefaults standardUserDefaults];
                                                           [loginDefalt setObject:username forKey:@"accout"];
                                                           [loginDefalt setObject:password  forKey:@"password"];
                                                           [loginDefalt synchronize];
                                                           
                                                           
                                                           //为注册后，重新跳转到首页服务
                                                           NSUserDefaults *beginDefault=[NSUserDefaults standardUserDefaults];
                                                           [beginDefault setObject:username forKey:@"usernameid"];
                                                           [beginDefault setObject:password forKey:@"usernamepwd"];
                                                           [beginDefault synchronize];
                                                           
                                                           
                                                           
                                                           //当点击开始方创的时候，跳到方创主界面
                                                           FangChuangInsiderViewController *insideView=[[FangChuangInsiderViewController alloc]init];
                                                           [self.navigationController pushViewController:insideView animated:NO];
                                                           
 
                                                           
                                                       } fail:^(id errorString) {
                                                           return ;
                                                       }];
        
        
   
        
        
        
    } fail:^(id errorString) {
        NSLog(@"---approve---errorString--%@-",errorString);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        return ;
    }];
    
    
    
    
}
//点击头像上传按钮
-(void)doClickHeadButton:(UIButton *)btn
{
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    
}

#pragma -mark -fucntions
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

    //背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 35, 320, 206)];
    imageView.image=[Utils getImageFromProject:@"homeApproveBackNew"];
    imageView.backgroundColor=[UIColor clearColor];
    [backScrollerView addSubview:imageView];
    
    //开始方创按钮
    UIButton *beginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    beginButton.frame=CGRectMake(15, imageView.frame.origin.y+imageView.frame.size.height+90, 275, 37);
    [beginButton setImage:[UIImage imageNamed:@"homeApproveBegin"] forState:UIControlStateNormal];
    [beginButton addTarget:self action:@selector(doClickBeginButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:beginButton];
    
    
    //头像背景图片
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake(19, imageView.frame.origin.y+18, 150, 120)];
    [headImage.layer setCornerRadius:18.0f];
    [headImage.layer setMasksToBounds:YES];
    [headImage setBackgroundColor:[UIColor clearColor]];
    
    
    NSData* data = [[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
    id image= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    headImage.image=image;
    [backScrollerView addSubview:headImage];
    
    
    //上传名片按钮
    /*
    UIButton *headImageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [headImageBut setFrame:CGRectMake(19, imageView.frame.origin.y+18, 150, 120)];
    [headImageBut setBackgroundColor:[UIColor redColor]];
    [headImageBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [headImageBut.layer setCornerRadius:18.0f];
    [headImageBut.layer setMasksToBounds:YES];
    [headImageBut addTarget:self action:@selector(doClickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:headImageBut];
    */
    
    //改成所有的白色区域可以点击
    UIButton *headImageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    headImageBut.frame=imageView.frame;
    [headImageBut setBackgroundColor:[UIColor clearColor]];
    [headImageBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [headImageBut addTarget:self action:@selector(doClickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:headImageBut];


}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    
    switch (buttonIndex) {
        case 0:
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设为不可编辑，可把相机中的编辑框去掉
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设为可编辑，可把相册中的照片显示出来，否则会直接加载
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *images = nil;
    if([[[UIDevice currentDevice] systemVersion] integerValue] < 6.0)
    {
        images = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    else
    {
        images = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    CGSize newSize = CGSizeMake(152, 152);
    UIGraphicsBeginImageContext(newSize);
    [images drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    headImage.image = newImage;
    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:newImage];
    NSUserDefaults *imageDefault = [NSUserDefaults standardUserDefaults];
    [imageDefault setObject:data forKey:@"image"];
    [imageDefault synchronize];
    
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
