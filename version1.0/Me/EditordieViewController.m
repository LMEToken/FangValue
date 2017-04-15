//
//  EditordieViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//我的资料编辑页面
#import "EditordieViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MineInFoemationViewController.h"
#import "CacheImageView.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"
//2014.09.12 chenlihua 自定义相机
#import "PostViewController.h"
#import "Reachability.h"
#import "FvaMyVC.h"


//投资者，创业者所有的机构信息页面
#import "MeInvestorFieldViewController.h"
#import "MeInvestorStageViewController.h"
#import "MeInvestorTeamScaleViewController.h"
#import "MeInvestorStateViewController.h"
#import "MeEntreCurrencyViewController.h"
#import "MeEntreMoneyViewController.h"
#import "MeEntreTurnViewController.h"
#import "MeEntreZoomViewController.h"
//资料管理
#import "TMeansManageVC.h"
#import "FMeansManageVC.h"

@interface EditordieViewController ()

@end

@implementation EditordieViewController
@synthesize XBTextField;
@synthesize whereFromString;

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

- (id)initWithText:(NSString *)text1 Text:(NSString *)text2 Text:(NSString *)text3 Text:(NSString *)text4 Text:(NSString *)text5 Text:(NSString *)text6 Text:(NSString *)text7 Text:(NSString *)text8 Text:(NSString *)text9
{
    self=[super init];
    if (self) {
        textStr1 = [[NSString alloc] initWithFormat:@"%@",text1];
        textStr2 = [[NSString alloc] initWithFormat:@"%@",text2];
        textStr3 = [[NSString alloc] initWithFormat:@"%@",text3];
        textStr4 = [[NSString alloc] initWithFormat:@"%@",text4];
        textStr5 = [[NSString alloc] initWithFormat:@"%@",text5];
        textStr6 = [[NSString alloc] initWithFormat:@"%@",text6];
        textStr7 = [[NSString alloc] initWithFormat:@"%@",text7];
        textStr8 = [[NSString alloc] initWithFormat:@"%@",text8];
        textStr9 = [[NSString alloc] initWithFormat:@"%@",text9];
    }
    return self;
}
-(void)changetext:(NSNotification*) notification
{
    NSString *sex = notification.object;
    
    [XBTextField setText:sex];
}
-(void)changeSubord:(NSNotification*) notification
{
    /*
    NSLog(@"%@",notification.object);
    NSMutableArray *arr= notification.object;
    if (arr.count==0) {
        WXHTextField.text = @"必选";
    }
    if (arr.count==1) {
        WXHTextField.text =[arr objectAtIndex:0];
    }
    if (arr.count>=2) {
        WXHTextField.text =  [NSString stringWithFormat:@"%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
     */
    
    //searchData
    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
  
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-field"]) {
                  WXHTextField.text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-field"] isEqualToString:@""]) {
                     WXHTextField.text=@"必选";
                }else{
                    WXHTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-field"];
                }
            }
            
            
        }else
        {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"]) {
                WXHTextField.text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"] isEqualToString:@""]) {
                    WXHTextField.text=@"必选";
                }else{
                    WXHTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"];
                }
            }

        }

    }else{
        WXHTextField.text=@"必选";
    }
    
    
    
    
}
-(void)changeStaga:(NSNotification*) notification
{
    
    NSMutableArray *arr= notification.object;
    if (arr.count==0) {
        EmailTextField.text = @"必选";
    }
    if (arr.count==1) {
        EmailTextField.text =[arr objectAtIndex:0];
    }
    if (arr.count>=2) {
        EmailTextField.text =  [NSString stringWithFormat:@"%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
}
-(void)changeTeam:(NSNotification*) notification
{
    
    NSMutableArray *arr= notification.object;
    if (arr.count==0) {
        xiatextView.text = @"必选";
    }
    if (arr.count==1) {
        xiatextView.text =[arr objectAtIndex:0];
    }
    if (arr.count>=2) {
        xiatextView.text =  [NSString stringWithFormat:@"%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
}
//changeRaise:
-(void)changeRaise:(NSNotification*) notification
{
    
    NSMutableArray *arr= notification.object;
    if (arr.count==0) {
        rongziField.text = @"必选";
    }
    if (arr.count==1) {
        rongziField.text =[arr objectAtIndex:0];
    }
    if (arr.count>=2) {
        rongziField.text =  [NSString stringWithFormat:@"%@,%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
}
//调用更改数据接口
-(void)changedata
{
    if (![self isConnectionAvailable]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    if (![self isValidateEmail:SJTextField.text]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的邮箱地址" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[[UserInfo sharedManager]usertype]isEqualToString:@"1"]) {
        
        /*
        if ([WXHTextField.text isEqualToString:@""]||[WXHTextField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"基金币种不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([EmailTextField.text isEqualToString:@""]||[EmailTextField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"偏好额度不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([xiatextView.text isEqualToString:@""]||[xiatextView.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"投资轮次不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([rongziField.text isEqualToString:@""]||[rongziField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"关注领域不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        */
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"修改成功",@"success", nil];
        [[NetManager sharedManager]setUserInfoWithUsername:[[UserInfo sharedManager]username] user_name:XMTextField.text usergender:XBTextField.text post:FGTextField.text base:ZWTextField.text comname:GWTextField.text email:SJTextField.text fmoney:EmailTextField.text  statge:xiatextView.text  frounds2:@"" pdesc:gongsijj.text teamsize:@"" industry:rongziField.text currency:WXHTextField.text  apptoken:[[UserInfo sharedManager]apptoken]  hudDic:dic success:^(id responseDic){
            NSLog(@"%@",responseDic);
            
            
            
           // [[UserInfo sharedManager] setUserpicture:[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]];
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]) {
                ;
            }else {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"] isEqualToString:@""]) {
                    ;
                }else{
                    [[UserInfo sharedManager] setUserpicture:[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]];
                }
            }
            
            

            
            [[UserInfo sharedManager] setUser_name:XMTextField.text];
            if ([XBTextField.text isEqualToString:@"男"]) {
                [[UserInfo sharedManager] setUsergender:@"m"];
            }else
            {
                [[UserInfo sharedManager] setUsergender:@"f"];
            }
            [[UserInfo sharedManager] setPost:FGTextField.text];
            [[UserInfo sharedManager] setBase:ZWTextField.text];
            [[UserInfo sharedManager]setComname:GWTextField.text];
            [[UserInfo sharedManager] setUseremail:SJTextField.text];
            [[UserInfo sharedManager] setLingyu:WXHTextField .text];
            [[UserInfo sharedManager] setJieduan:EmailTextField.text];
            [[UserInfo sharedManager] setGuimo:xiatextView.text];
            [[UserInfo sharedManager] setRongzi:rongziField.text];
            [[UserInfo sharedManager] setGongsijianjie:gongsijj.text];
            
            //[Utils changeViewControllerWithTabbarIndex:5];
            
            UIAlertView *show = [[UIAlertView alloc]initWithTitle:@"修改成功" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [show show];
            
            
           
            TMeansManageVC *tMeans=[[TMeansManageVC alloc]init];
            [self.navigationController pushViewController:tMeans animated:NO];
           
            /*
            FMeansManageVC *vc=[[FMeansManageVC alloc]init];
            [self.navigationController pushViewController:vc
                                                 animated:NO];
             */
            
            /*
            FvaMyVC *vc = [[FvaMyVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            */
            
            
        }fail:^(id dufuit)
         {
             [self.view showActivityOnlyLabelWithOneMiao:@"修改失败"];;
         }];
        
        
        
    }else
    {
        /*
        if ([WXHTextField.text isEqualToString:@""]||[WXHTextField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"所属领域不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([EmailTextField.text isEqualToString:@""]||[EmailTextField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"阶段不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([xiatextView.text isEqualToString:@""]||[xiatextView.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"团队规模不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([rongziField.text isEqualToString:@""]||[rongziField.text isEqualToString:@"必选"]) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"融资状态不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        */
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"修改成功",@"success", nil];
        [[NetManager sharedManager]setUserInfoWithUsername:[[UserInfo sharedManager]username] user_name:XMTextField.text usergender:XBTextField.text post:FGTextField.text base:ZWTextField.text comname:GWTextField.text email:SJTextField.text fmoney:@""  statge:EmailTextField.text  frounds2:rongziField.text pdesc:gongsijj.text teamsize:xiatextView.text industry:WXHTextField.text currency:@""  apptoken:[[UserInfo sharedManager]apptoken]  hudDic:dic success:^(id responseDic){
            NSLog(@"%@",responseDic);
            
           // [[UserInfo sharedManager] setUserpicture:[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]];
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]) {
                ;
            }else {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"] isEqualToString:@""]) {
                    ;
                }else{
                    [[UserInfo sharedManager] setUserpicture:[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"]];
                }
            }
            
            

            
            [[UserInfo sharedManager] setUser_name:XMTextField.text];
            if ([XBTextField.text isEqualToString:@"男"]) {
                [[UserInfo sharedManager] setUsergender:@"m"];
            }else
            {
                [[UserInfo sharedManager] setUsergender:@"f"];
            }
            [[UserInfo sharedManager] setPost:FGTextField.text];
            [[UserInfo sharedManager] setBase:ZWTextField.text];
            [[UserInfo sharedManager]setComname:GWTextField.text];
            [[UserInfo sharedManager] setUseremail:SJTextField.text];
            [[UserInfo sharedManager] setLingyu:WXHTextField .text];
            [[UserInfo sharedManager] setJieduan:EmailTextField.text];
            [[UserInfo sharedManager] setGuimo:xiatextView.text];
            [[UserInfo sharedManager] setRongzi:rongziField.text];
            [[UserInfo sharedManager] setGongsijianjie:gongsijj.text];
            
            //[Utils changeViewControllerWithTabbarIndex:5];
            
            UIAlertView *show = [[UIAlertView alloc]initWithTitle:@"修改成功" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [show show];
            
            
            /*
            FvaMyVC *vc = [[FvaMyVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            */
           
            
            TMeansManageVC *tMeans=[[TMeansManageVC alloc]init];
            [self.navigationController pushViewController:tMeans animated:NO];
           /*
            FMeansManageVC *vc=[[FMeansManageVC alloc]init];
            [self.navigationController pushViewController:vc
                                                 animated:NO];
           */
            
        }fail:^(id dufuit)
         {
             [self.view showActivityOnlyLabelWithOneMiao:@"修改失败"];
         }];
        
        
        
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"我的资料"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2014.09.13 chenlihua 自定义相机，头像changeStagachangeTeam
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changetext:) name:@"changesex"object:nil];
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSubord:) name:@"changeSubord"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStaga:) name:@"changeStaga"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTeam:) name:@"changeTeam"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRaise:) name:@"changeRaise"object:nil];
     */
    /*
    //声明通知中心,获得默认的通知中心changeRaise
    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    //添加观察者
    [notiCenter addObserver:self selector:@selector(sendSureMessage:) name:@"Click" object:nil];
    */
    
    
    //右侧完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    //    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(changedata) forControlEvents:UIControlEventTouchDown];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    //UIScrollView
    /*
     UIScrollView *inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
     [inforView setBackgroundColor:[UIColor redColor]];
     [inforView setShowsVerticalScrollIndicator:YES];
     [inforView setContentSize:CGSizeMake(320, 530)];
     [inforView setDelegate:self];
     [self.contentView addSubview:inforView];
     */
    
    inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [inforView setBackgroundColor:[UIColor clearColor]];
    [inforView setShowsVerticalScrollIndicator:YES];
    inforView.userInteractionEnabled=YES;
   // [inforView setContentSize:CGSizeMake(320, 750)];
    [inforView setContentSize:CGSizeMake(320, 800)];
    [inforView setDelegate:self];
    [self.contentView addSubview:inforView];
    
    
    
    //上半部分背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 305/2+10)];
    [imageView setImage:[UIImage imageNamed:@"withback"]];
    [inforView addSubview:imageView];
    
    //头像Label
    UILabel *headlab=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 80, 25)];
    [headlab setBackgroundColor:[UIColor clearColor]];
    [headlab setText:@"头像:"];
    [headlab setFont:[UIFont fontWithName:KUIFont size:13]];
    [headlab setTextColor:[UIColor grayColor]];
    [inforView addSubview:headlab];
    
    
    //头像图片
    /*
     headimageView=[[CacheImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
     [headimageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
     [headimageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
     */
    //2014.06.13 cehnlihua 修改图片缓存方式
    headimageView=[[UIImageView alloc]initWithFrame:CGRectMake(320-55-15, 8, 46, 46)];
    
    
   // [headimageView setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    
    if ([whereFromString isEqualToString:@"0"]) {
        
      [headimageView setImageWithURL:[[NSUserDefaults standardUserDefaults]objectForKey:@"me-photo"] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        
    }else{
        
        
        
       [headimageView setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        
        NSUserDefaults *photo=[NSUserDefaults standardUserDefaults];
        [photo setObject:[[UserInfo sharedManager] userpicture]forKey:@"me-photo"];
        [photo synchronize];
    }
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 10, 20)];
    imageview.image = [UIImage imageNamed:@"accessory"];
   // [inforView addSubview:imageview];
    
    //2014.05.13 chenlihua 暂时去掉圆角，好与微信做对比。
    [headimageView.layer setCornerRadius:10.0f];
    [headimageView.layer setMasksToBounds:YES];
    [inforView addSubview:headimageView];
    
    //头像点击按钮
    UIButton *headBUT=[UIButton buttonWithType:UIButtonTypeCustom];
    [headBUT setFrame:CGRectMake(200, 8, 120, 46)];
    [headBUT setBackgroundColor:[UIColor clearColor]];
    [headBUT addTarget:self action:@selector(headerEditordEvent:) forControlEvents:UIControlEventTouchUpInside];
    headBUT.backgroundColor=[UIColor clearColor];
    [inforView addSubview:headBUT];
    
    NSArray *basicArray=[NSArray arrayWithObjects:@"真实姓名:",@"性别:", @"",nil];
    for (int i=1; i<4; i++) {
        //下划线
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5+45*i, 300, 1)];
        [imageView setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [inforView addSubview:imageView];
        
        //姓名，性别:Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+10, 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        
        [lab setText:[basicArray objectAtIndex:(i-1)]];
        [lab setFont:[UIFont fontWithName:KUIFont size:13]];
        [lab setTextColor:[UIColor grayColor]];
        [inforView addSubview:lab];
        
    }
    
   // XMTextField=[[UITextField alloc]initWithFrame:CGRectMake(210, 29.5+45*1, 100, 49/2-4)];
    XMTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, 29.5+45*1, 120, 49/2-4)];
    [XMTextField setBorderStyle:UITextBorderStyleNone];
    XMTextField.layer.borderWidth = .5;
    XMTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    XMTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [XMTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [XMTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    [XMTextField setPlaceholder:@"请输入您的姓名"];
    XMTextField.textColor=[UIColor grayColor];
   // XMTextField.text=[[UserInfo sharedManager] user_name];
    
    if ([whereFromString isEqualToString:@"0"]) {
        XMTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-name"];
        
    }else{
       XMTextField.text=[[UserInfo sharedManager] user_name];
        
    }

   // [XMTextField setText:textStr1];
    
    //2014.08.19 chenlihua 将next按钮去掉
    //[XMTextField setReturnKeyType:UIReturnKeyNext];
    [XMTextField setDelegate:self];
    [XMTextField setReturnKeyType:UIReturnKeyDefault];
    // XMTextField.backgroundColor=[UIColor redColor];
   [inforView addSubview:XMTextField];
    
    XBTextField=[[UITextField alloc]initWithFrame:CGRectMake(240, 27.5+45*2, 100, 49/2)];
    [XBTextField setBorderStyle:UITextBorderStyleNone];
    [XBTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [XBTextField setPlaceholder:@"选择性别"];
    [XBTextField setEnabled:NO];
    XBTextField.textColor=[UIColor grayColor];
    NSLog(@"%@",[[UserInfo sharedManager]usergender]);
    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-sex"] isEqualToString:@"f"]) {
            [XBTextField setText:@"女"];
        }else
        {
            [XBTextField setText:@"男"];
        }

        
    }else{
        
        if ([[[UserInfo sharedManager]usergender] isEqualToString:@"f"]) {
            [XBTextField setText:@"女"];
        }else
        {
            [XBTextField setText:@"男"];
        }

        
    }


    
    [XBTextField setReturnKeyType:UIReturnKeyNext];
    [XBTextField setDelegate:self];
    
    [XBTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    [inforView addSubview:XBTextField];
    UIButton *bt1 = [[UIButton alloc]initWithFrame:CGRectMake(260, 19.5+45*2,60,60)];
    //    bt1.backgroundColor = [UIColor redColor];
    bt1.tag=0;
    [bt1 addTarget:self action:@selector(changes:) forControlEvents:UIControlEventTouchDown ];
    [inforView addSubview:bt1];
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 27.5+45*2,10,20)];
    imageview2.image = [UIImage imageNamed:@"accessory"];
    [inforView addSubview:imageview2];
    
    //    if ([textStr2 isEqualToString:@"女"]) {
    //        [XBTextField setText:@"女"];
    //          [XBTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    //            [XBTextField setTextColor:[UIColor grayColor]];
    //        isNewRemind = YES;
    //    }
    //    else
    //    {
    //        isNewRemind = NO;
    //        [XBTextField setText:@"男"];
    //           [XBTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    //        [XBTextField setTextColor:[UIColor grayColor]];
    //
    //    }
    
    //    //选择按钮
    //    toggleViewBaseChange = [[ToggleView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10, CGRectGetMinY(XBTextField.frame) + 3, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    //    toggleViewBaseChange.toggleDelegate = self;
    //    [inforView addSubview:toggleViewBaseChange];
    
    
    UIImage *onImage = [UIImage imageNamed:@"71_dian_2.png"];
    UIImage *offImage = [UIImage imageNamed:@"64tongyong_icon02.png"];
    onView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [onView setImage:onImage];
    [inforView addSubview:onView];
    
    offView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [offView setImage:offImage];
    [inforView addSubview:offView];
    
    if (isNewRemind) {
        
        [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        [onView setHidden:YES];
        [offView setHidden:NO];
        [toggleViewBaseChange setSelectedButton:ToggleButtonSelectedLeft];
        
    }else{
        [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        [offView setHidden:YES];
        [onView setHidden:NO];
        [toggleViewBaseChange setSelectedButton:ToggleButtonSelectedRight];
    }
    
    //第二部分背景图片
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 305/2-10, 320, 900/2+160)];
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView1 setImage:[UIImage imageNamed:@"withback"]];
    [inforView addSubview:imageView1];
    
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 305/2+11, 300, 1)];
    [imageView3 setImage:[UIImage imageNamed:@"60_fengexian_1"]];
    [inforView addSubview:imageView3];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"quanxian"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //读取
    NSArray *moreArray;
    if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"])
    {
        
        moreArray= [NSArray arrayWithObjects:@"所在地:",@"公司:",@"职位:",@"邮箱:",@"机构信息",@"基金币种:",@"偏好额度",@"投资论处",@"关注领域",@"公司简介",nil];
    }else
    {
        moreArray=[NSArray arrayWithObjects:@"所在地:",@"公司:",@"职位:",@"邮箱:",@"机构信息",@"所属领域:",@"阶段:",@"团队规模:",@"融资状态",@"公司简介",nil];
    }
    
    
    for (int k=1 ; k<11; k++) {
        //职位等Label
        if (k>5&&k<10) {
            
          //  UIButton *bt1 = [[UIButton alloc]initWithFrame:CGRectMake(250, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 80, 25)];
            UIButton *bt1 = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 250, 25)];
            bt1.tag=k-5;
            bt1.backgroundColor=[UIColor clearColor];
            [bt1 addTarget:self action:@selector(changes:) forControlEvents:UIControlEventTouchDown ];
            [inforView addSubview:bt1];
            
            UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(290, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 10, 20)];
            imageview2.image = [UIImage imageNamed:@"accessory"];
            [inforView addSubview:imageview2];
            
        }
        if (k==5) {
            //            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 80, 25)];
            //            [lab setBackgroundColor:[UIColor redColor]];
            //
            //            [lab setText:[moreArray objectAtIndex:(k-1)]];
            //            [lab setFont:[UIFont fontWithName:KUIFont size:13]];
            //            [lab setTextColor:[UIColor grayColor]];
            //            [inforView addSubview:lab];
        }else
        {
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 70, 25)];
            [lab setBackgroundColor:[UIColor clearColor]];
            
            [lab setText:[moreArray objectAtIndex:(k-1)]];
            [lab setFont:[UIFont fontWithName:KUIFont size:13]];
            [lab setTextColor:[UIColor grayColor]];
            [inforView addSubview:lab];
        }
        
        
    }
    for (int j=1; j<11; j++) {
        //下划线
        if (j==5) {
            UIImageView *imageViewk=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)-20+45*j, 320, 30)];
            //            imageViewk.backgroundColor = [UIColor grayColor];
            [imageViewk setImage:[UIImage imageNamed:@"jigou"]];
            [inforView addSubview:imageViewk];
        }else if
            (j==10) {
                UIImageView *imageViewk=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)-20+45*j, 320, 30)];
                //            imageViewk.backgroundColor = [UIColor grayColor];
                [imageViewk setImage:[UIImage imageNamed:@"gongsijianjie"]];
                [inforView addSubview:imageViewk];
            }
        else
        {
            UIImageView *imageViewk=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10+45*j, 300, 1)];
            [imageViewk setImage:[UIImage imageNamed:@"60_fengexian_1"]];
            [inforView addSubview:imageViewk];
        }
        
        
        //        //右侧黄色的背景框图片
        //        UIImageView *imageViewtext=[[UIImageView alloc]initWithFrame:CGRectMake(310-204.5, CGRectGetMaxY(imageView.frame)+20+45*(j-1), 409/2, 49/2)];
        //        [imageViewtext setImage:[UIImage imageNamed:@"61_kuang_1"]];
        //        [inforView addSubview:imageViewtext];
    }
    
    
    ZWTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(1-1), 120, 49/2-4)];
    [ZWTextField setBorderStyle:UITextBorderStyleRoundedRect];
    ZWTextField.layer.borderWidth = .5;
    ZWTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    [ZWTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [ZWTextField setPlaceholder:@"请输入你的所在地"];
    [ZWTextField setFont:[UIFont systemFontOfSize:15]];
  //  [ZWTextField setText:[[UserInfo sharedManager] base]];
    if ([whereFromString isEqualToString:@"0"]) {
        ZWTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-place"];
        
    }else{
        [ZWTextField setText:[[UserInfo sharedManager] base]];
        
    }

    // [ZWTextField setReturnKeyType:UIReturnKeyNext];
    [ZWTextField setReturnKeyType:UIReturnKeyDefault];
    [ZWTextField setDelegate:self];
    //       ZWTextField.textAlignment = UITextAlignmentRight;
    // ZWTextField.backgroundColor=[UIColor redColor];
    [ZWTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    ZWTextField.textColor=[UIColor grayColor];
    [inforView addSubview:ZWTextField];
    
    
    GWTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(2-1), 120, 49/2-4)];
    [GWTextField setBorderStyle:UITextBorderStyleRoundedRect];
    GWTextField.layer.borderWidth = .5;
    GWTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    [GWTextField setKeyboardType:UIKeyboardTypeEmailAddress];

    [GWTextField setFont:[UIFont systemFontOfSize:15]];
   // [GWTextField setText:[[UserInfo sharedManager] comname]];
    if ([whereFromString isEqualToString:@"0"]) {
        GWTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-company"];
        
    }else{
        [GWTextField setText:[[UserInfo sharedManager] comname]];
        
    }

    //       GWTextField.textAlignment = UITextAlignmentRight;
    // [GWTextField setReturnKeyType:UIReturnKeyNext];

    [GWTextField setDelegate:self];
    [GWTextField setPlaceholder:@"请输入您的公司名"];
    [GWTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    GWTextField.textColor=[UIColor grayColor];
    [inforView addSubview:GWTextField];
    
    //分工的内容Label
    FGTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(3-1), 120, 49/2-4)];
    [FGTextField setBorderStyle:UITextBorderStyleRoundedRect];
//    [FGTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [FGTextField setPlaceholder:@"请输入你的职位"];
    [FGTextField setFont:[UIFont systemFontOfSize:15]];
   // [FGTextField setText:[[UserInfo sharedManager] post]];
    
    if ([whereFromString isEqualToString:@"0"]) {
        FGTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-positon"];
        
    }else{
        [FGTextField setText:[[UserInfo sharedManager] post]];
        
    }

    //       FGTextField.textAlignment = UITextAlignmentRight;
    FGTextField.layer.borderWidth = .5;
    FGTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    // [FGTextField setReturnKeyType:UIReturnKeyNext];
    [FGTextField setReturnKeyType:UIReturnKeyDefault];
    [FGTextField setDelegate:self];
    [FGTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    FGTextField.textColor=[UIColor grayColor];
    [inforView addSubview:FGTextField];
    
    //手机号的内容Label
    SJTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(4-1), 120, 49/2-4)];
    SJTextField.layer.borderWidth = .5;
    SJTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    [SJTextField setBorderStyle:UITextBorderStyleRoundedRect];
//    [SJTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //       SJTextField.textAlignment = UITextAlignmentRight;
    [SJTextField setPlaceholder:@"你输入你的邮箱"];
    [SJTextField setFont:[UIFont systemFontOfSize:15]];
   // [SJTextField setText:[[UserInfo sharedManager] useremail]];
    
    if ([whereFromString isEqualToString:@"0"]) {
        SJTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-email"];
        
    }else{
       [SJTextField setText:[[UserInfo sharedManager] useremail]];
        
    }

    //  [SJTextField setReturnKeyType:UIReturnKeyNext];
    [SJTextField setReturnKeyType:UIReturnKeyDefault];
    [SJTextField setDelegate:self];
    [SJTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    SJTextField.textColor=[UIColor grayColor];
    [inforView addSubview:SJTextField];
    
    //Email的内容Label
    WXHTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(6-1), 120, 49/2-4)];
    //    WXHTextField.layer.borderWidth = .5;
    //    WXHTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    [WXHTextField setBorderStyle:UITextBorderStyleNone];
//    [WXHTextField setKeyboardType:UIKeyboardTypeEmailAddress];
  //  [WXHTextField setPlaceholder:@"必选"];
    [WXHTextField setFont:[UIFont systemFontOfSize:15]];
    WXHTextField.textColor=[UIColor grayColor];
   // [WXHTextField setText:[[UserInfo sharedManager] lingyu]];
    
    NSLog(@"--field-%@--",[[NSUserDefaults standardUserDefaults]
                           objectForKey:@"me-first-currency"]);
    NSLog(@"--where--%@",whereFromString);
    NSLog(@"--usertype--%@",[[UserInfo sharedManager] usertype]);
    
    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"0"]) {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-field"]) {
                WXHTextField.text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-field"] isEqualToString:@""]) {
                    WXHTextField.text=@"必选";
                }else{
                    WXHTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-field"];
                }
            }
            
            
        }else
        {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"]) {
                WXHTextField.text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"] isEqualToString:@""]) {
                    WXHTextField.text=@"必选";
                }else{
                    WXHTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-currency"];
                    
                }
            }
            
        }
        
    }else{
        
       // [WXHTextField setText:[[UserInfo sharedManager] lingyu]];
        
        
        if (![[UserInfo sharedManager] lingyu]) {
            [WXHTextField setText:@"必选"];
        }else{
            if ([[[UserInfo sharedManager] lingyu] isEqualToString:@""]) {
                [WXHTextField setText:@"必选"];
            }else {
                [ WXHTextField setText:[[UserInfo sharedManager] lingyu]];
                 
            }
            
        }

    }
    

    WXHTextField.userInteractionEnabled = NO;
    WXHTextField.textAlignment = NSTextAlignmentRight;
    // [WXHTextField setReturnKeyType:UIReturnKeyNext];
    [WXHTextField setReturnKeyType:UIReturnKeyDefault];
    [WXHTextField setDelegate:self];
    [WXHTextField setFont:[UIFont fontWithName:KUIFont size:13]];
    [inforView addSubview:WXHTextField];
    
    //微信号的内容Label
    EmailTextField=[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(7-1),120, 49/2-4)];
    
    //     EmailTextField.layer.borderWidth = .5;
    //     EmailTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    [EmailTextField setBorderStyle:UITextBorderStyleNone];
//    [EmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //[EmailTextField setPlaceholder:@"必选"];
   // EmailTextField.userInteractionEnabled =NO;
    [EmailTextField setFont:[UIFont systemFontOfSize:15]];
    EmailTextField.textColor=[UIColor grayColor];
   // [EmailTextField setText:[[UserInfo sharedManager] jieduan]];
    
    NSLog(@"--money-%@--",[[NSUserDefaults standardUserDefaults]
                           objectForKey:@"me-first-money"]);
    NSLog(@"--where--%@",whereFromString);
    NSLog(@"--usertype--%@",[[UserInfo sharedManager] usertype]);
    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"0"]) {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-stage"]) {
                EmailTextField .text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-stage"] isEqualToString:@""]) {
                    EmailTextField .text=@"必选";
                }else{
                    EmailTextField .text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-stage"];
                }
            }
        }else
        {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-money"]) {
                EmailTextField .text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-money"] isEqualToString:@""]) {
                    EmailTextField .text=@"必选";
                }else{
                    EmailTextField .text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-money"];
                }
            }
            
        }
        
    }else{
        
      //  [EmailTextField setText:[[UserInfo sharedManager] jieduan]];
        
        
        if (![[UserInfo sharedManager] jieduan]) {
            [EmailTextField setText:@"必选"];
        }else{
            if ([[[UserInfo sharedManager] jieduan]isEqualToString:@""]) {
                [EmailTextField setText:@"必选"];
            }else {
                [ EmailTextField setText:[[UserInfo sharedManager] jieduan]];
            }
            
        }

    }

    EmailTextField.textAlignment = NSTextAlignmentRight;
    // [EmailTextField setReturnKeyType:UIReturnKeyNext];
    [EmailTextField setReturnKeyType:UIReturnKeyDefault];
    [EmailTextField setDelegate:self];
    [EmailTextField  setFont:[UIFont fontWithName:KUIFont size:13]];
     EmailTextField.userInteractionEnabled = NO;
    [inforView addSubview:EmailTextField];
    
    //履历的内容textView
    xiatextView =[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(8-1),120, 49/2-4)];
    //    xiatextView.layer.borderWidth = .5;
    //    xiatextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [ xiatextView setBorderStyle:UITextBorderStyleNone];
    [xiatextView setKeyboardType:UIKeyboardTypeEmailAddress];
   // [ xiatextView setPlaceholder:@"必选"];
    xiatextView.userInteractionEnabled =NO;
    [xiatextView setFont:[UIFont systemFontOfSize:15]];
    xiatextView.textColor=[UIColor grayColor];
  //  [ xiatextView setText:[[UserInfo sharedManager] guimo]];
    
    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"0"]) {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-scale"]) {
                xiatextView .text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-scale"] isEqualToString:@""]) {
                    xiatextView .text=@"必选";
                }else{
                    xiatextView .text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-scale"];
                }
            }
            
            
        }else
        {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-turn"]) {
                xiatextView .text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-turn"] isEqualToString:@""]) {
                    xiatextView .text=@"必选";
                }else{
                    xiatextView .text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-turn"];
                }
            }
            
        }
        
    }else{
        
       // [ xiatextView setText:[[UserInfo sharedManager] guimo]];
        
        if (![[UserInfo sharedManager] guimo]) {
            [xiatextView setText:@"必选"];
        }else{
            if ([[[UserInfo sharedManager] guimo] isEqualToString:@""]) {
                [xiatextView setText:@"必选"];
            }else {
                [ xiatextView setText:[[UserInfo sharedManager] guimo]];
            }
            
        }

    }

    // [WXHTextField setReturnKeyType:UIReturnKeyNext];
    xiatextView.textAlignment = NSTextAlignmentRight;
    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    [xiatextView setDelegate:self];
    [xiatextView setFont:[UIFont fontWithName:KUIFont size:13]];
    [inforView addSubview: xiatextView];
    
    rongziField =[[UITextField alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(imageView.frame)+22+45*(9-1),120, 49/2-4)];
    //     rongziField.layer.borderWidth = .5;
    //     rongziField.layer.borderColor = [[UIColor grayColor] CGColor];
    [ rongziField setBorderStyle:UITextBorderStyleNone];
    [ rongziField setKeyboardType:UIKeyboardTypeEmailAddress];
  //  [ rongziField setPlaceholder:@"必选"];
    [ rongziField setFont:[UIFont systemFontOfSize:15]];
    rongziField.userInteractionEnabled = NO;
     rongziField.textColor=[UIColor grayColor];
   // [ rongziField setText:[[UserInfo sharedManager] rongzi]];
    
    NSLog(@"--zoom-%@--",[[NSUserDefaults standardUserDefaults]
                           objectForKey:@"me-first-zoom"]);
    NSLog(@"--where--%@",whereFromString);
    NSLog(@"--usertype--%@",[[UserInfo sharedManager] usertype]);

    
    if ([whereFromString isEqualToString:@"0"]) {
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"0"]) {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-state"]) {
               rongziField.text=@"必选";
               
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-state"] isEqualToString:@""]) {
                    rongziField.text=@"必选";
                }else{
                    rongziField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-zero-state"];
                }
            }
            
            
        }else
        {
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-zoom"]) {
                rongziField .text=@"必选";
            }else{
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-zoom"] isEqualToString:@""]) {
                    rongziField .text=@"必选";
                }else{
                    rongziField .text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-first-zoom"];
                }
            }
            
        }
        
    }else{
        
        if (![[UserInfo sharedManager] rongzi]) {
            [rongziField setText:@"必选"];
        }else{
            if ([[[UserInfo sharedManager] rongzi] isEqualToString:@""]) {
                [rongziField setText:@"必选"];
            }else {
                [ rongziField setText:[[UserInfo sharedManager] rongzi]];
            }
          
        }
        
    }

    rongziField.textAlignment = NSTextAlignmentRight;
    // [WXHTextField setReturnKeyType:UIReturnKeyNext];
    [ rongziField setReturnKeyType:UIReturnKeyDefault];
    [ rongziField setDelegate:self];
    [ rongziField setFont:[UIFont fontWithName:KUIFont size:13]];
    [inforView addSubview: rongziField];
    
    gongsijj = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+22+45*(11-1),280, 90)];
    [gongsijj setDelegate:self];
    [gongsijj setFont:[UIFont fontWithName:KUIFont size:13]];
    if ([whereFromString isEqualToString:@"0"]) {
         gongsijj.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"me-gongsi"];
    }else{
         gongsijj.text = [[UserInfo sharedManager] gongsijianjie];

    }
    gongsijj.textColor=[UIColor grayColor];
    [inforView addSubview:gongsijj];
}
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
#pragma  -mark - 几个 选项的点击事件
-(void)changes:(UIButton *)mybt
{
    if (mybt.tag==0) {
        NSLog(@"%@",XBTextField.text);
        ChangeSexVC *vc = [[ChangeSexVC alloc]initWithSex:XBTextField.text];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (mybt.tag==1) {
        
        /*
        SubordinateFieldVC *vc = [[SubordinateFieldVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        */
        
       
    

        
        
        //内容保存
         NSUserDefaults *editDefault=[NSUserDefaults standardUserDefaults];
        // [editDefault setObject:headimageView.image forKey:@"me-head"];
         [editDefault setObject:XMTextField.text forKey:@"me-name"];
         [editDefault setObject:XBTextField.text forKey:@"me-sex"];
         [editDefault setObject:ZWTextField.text forKey:@"me-place"];
         [editDefault setObject:GWTextField.text forKey:@"me-company"];
         [editDefault setObject:FGTextField.text forKey:@"me-positon"];
         [editDefault setObject:SJTextField.text forKey:@"me-email"];
         [editDefault setObject:gongsijj.text forKey:@"me-gongsi"];
         [editDefault synchronize];
        
        
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
            
            NSUserDefaults *firstDefault=[NSUserDefaults standardUserDefaults];
            [firstDefault setObject:WXHTextField.text forKey:@"me-first-currency"];
            [firstDefault setObject:EmailTextField .text forKey:@"me-first-money"];
            [firstDefault setObject:xiatextView .text forKey:@"me-first-turn"];
            [firstDefault setObject:rongziField .text forKey:@"me-first-zoom"];
            [firstDefault synchronize];
            
            MeEntreCurrencyViewController *field=[[MeEntreCurrencyViewController alloc]init];
            field.aleadyString=WXHTextField.text;
            [self.navigationController pushViewController:field animated:NO];
            
        }else
        {
             NSUserDefaults *zeroDefault=[NSUserDefaults standardUserDefaults];
             [zeroDefault setObject:WXHTextField.text forKey:@"me-zero-field"];
             [zeroDefault setObject:EmailTextField .text forKey:@"me-zero-stage"];
             [zeroDefault setObject:xiatextView .text forKey:@"me-zero-scale"];
             [zeroDefault setObject:rongziField .text forKey:@"me-zero-state"];
             [zeroDefault synchronize];
            
            
            MeInvestorFieldViewController *field=[[MeInvestorFieldViewController alloc]init];
            field.aleadyString=WXHTextField.text;
            [self.navigationController pushViewController:field animated:NO];
        }

        
        
    }
    if (mybt.tag==2) {
        /*
        StagaVC *vc =[[ StagaVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        */
        
        //内容保存
        NSUserDefaults *editDefault=[NSUserDefaults standardUserDefaults];
      //  [editDefault setObject:headimageView.image  forKey:@"me-head"];
        [editDefault setObject:XMTextField.text forKey:@"me-name"];
        [editDefault setObject:XBTextField.text forKey:@"me-sex"];
        [editDefault setObject:ZWTextField.text forKey:@"me-place"];
        [editDefault setObject:GWTextField.text forKey:@"me-company"];
        [editDefault setObject:FGTextField.text forKey:@"me-positon"];
        [editDefault setObject:SJTextField.text forKey:@"me-email"];
        [editDefault setObject:gongsijj.text forKey:@"me-gongsi"];
        [editDefault synchronize];


        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
            
            NSUserDefaults *firstDefault=[NSUserDefaults standardUserDefaults];
            [firstDefault setObject:WXHTextField.text forKey:@"me-first-currency"];
            [firstDefault setObject:EmailTextField .text forKey:@"me-first-money"];
            [firstDefault setObject:xiatextView .text forKey:@"me-first-turn"];
            [firstDefault setObject:rongziField .text forKey:@"me-first-zoom"];
            [firstDefault synchronize];
            
            MeEntreMoneyViewController *money=[[MeEntreMoneyViewController alloc]init];
            money.aleadyString=EmailTextField .text;
            [self.navigationController pushViewController:money animated:NO];
            
        }else
        {
            NSUserDefaults *zeroDefault=[NSUserDefaults standardUserDefaults];
            [zeroDefault setObject:WXHTextField.text forKey:@"me-zero-field"];
            [zeroDefault setObject:EmailTextField .text forKey:@"me-zero-stage"];
            [zeroDefault setObject:xiatextView .text forKey:@"me-zero-scale"];
            [zeroDefault setObject:rongziField .text forKey:@"me-zero-state"];
            [zeroDefault synchronize];
            
            MeInvestorStageViewController *stage=[[MeInvestorStageViewController alloc]init];
            stage.aleadyString=EmailTextField.text;
            [self.navigationController pushViewController:stage animated:NO];
        }
        

    }
    if (mybt.tag==3) {
        /*
        TeamScaleVC*vc = [[TeamScaleVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
         */
        //内容保存
        NSUserDefaults *editDefault=[NSUserDefaults standardUserDefaults];
       // [editDefault setObject:headimageView.image forKey:@"me-head"];
        [editDefault setObject:XMTextField.text forKey:@"me-name"];
        [editDefault setObject:XBTextField.text forKey:@"me-sex"];
        [editDefault setObject:ZWTextField.text forKey:@"me-place"];
        [editDefault setObject:GWTextField.text forKey:@"me-company"];
        [editDefault setObject:FGTextField.text forKey:@"me-positon"];
        [editDefault setObject:SJTextField.text forKey:@"me-email"];
        [editDefault setObject:gongsijj.text forKey:@"me-gongsi"];
        [editDefault synchronize];

      
        
        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
            
            NSUserDefaults *firstDefault=[NSUserDefaults standardUserDefaults];
            [firstDefault setObject:WXHTextField.text forKey:@"me-first-currency"];
            [firstDefault setObject:EmailTextField .text forKey:@"me-first-money"];
            [firstDefault setObject:xiatextView .text forKey:@"me-first-turn"];
            [firstDefault setObject:rongziField .text forKey:@"me-first-zoom"];
            [firstDefault synchronize];
            
            MeEntreTurnViewController *turn=[[MeEntreTurnViewController alloc]init];
            turn.aleadyString=xiatextView .text;
            [self.navigationController pushViewController:turn animated:NO];
           
        }else
        {
            NSUserDefaults *zeroDefault=[NSUserDefaults standardUserDefaults];
            [zeroDefault setObject:WXHTextField.text forKey:@"me-zero-field"];
            [zeroDefault setObject:EmailTextField .text forKey:@"me-zero-stage"];
            [zeroDefault setObject:xiatextView .text forKey:@"me-zero-scale"];
            [zeroDefault setObject:rongziField .text forKey:@"me-zero-state"];
            [zeroDefault synchronize];
            
            MeInvestorTeamScaleViewController *team=[[MeInvestorTeamScaleViewController alloc]init];
            team.aleadyString=xiatextView .text;
            [self.navigationController pushViewController:team animated:NO];
        }

    }
    if (mybt.tag==4) {
        /*
        RaisefundsVC *vc = [[RaisefundsVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
         */
        //内容保存
        NSUserDefaults *editDefault=[NSUserDefaults standardUserDefaults];
       // [editDefault setObject:headimageView.image  forKey:@"me-head"];
        [editDefault setObject:XMTextField.text forKey:@"me-name"];
        [editDefault setObject:XBTextField.text forKey:@"me-sex"];
        [editDefault setObject:ZWTextField.text forKey:@"me-place"];
        [editDefault setObject:GWTextField.text forKey:@"me-company"];
        [editDefault setObject:FGTextField.text forKey:@"me-positon"];
        [editDefault setObject:SJTextField.text forKey:@"me-email"];
        [editDefault setObject:gongsijj.text forKey:@"me-gongsi"];
        [editDefault synchronize];


    

        if ([[[UserInfo sharedManager] usertype]isEqualToString:@"1"]) {
            
            NSUserDefaults *firstDefault=[NSUserDefaults standardUserDefaults];
            [firstDefault setObject:WXHTextField.text forKey:@"me-first-currency"];
            [firstDefault setObject:EmailTextField .text forKey:@"me-first-money"];
            [firstDefault setObject:xiatextView .text forKey:@"me-first-turn"];
            [firstDefault setObject:rongziField .text forKey:@"me-first-zoom"];
            [firstDefault synchronize];
            
            MeEntreZoomViewController *zoom=[[MeEntreZoomViewController alloc]init];
            zoom.aleadyString=rongziField.text;
            [self.navigationController pushViewController:zoom animated:NO];
        }else
        {
            NSUserDefaults *zeroDefault=[NSUserDefaults standardUserDefaults];
            [zeroDefault setObject:WXHTextField.text forKey:@"me-zero-field"];
            [zeroDefault setObject:EmailTextField .text forKey:@"me-zero-stage"];
            [zeroDefault setObject:xiatextView .text forKey:@"me-zero-scale"];
            [zeroDefault setObject:rongziField .text forKey:@"me-zero-state"];
            [zeroDefault synchronize];
            
            MeInvestorStateViewController *state=[[MeInvestorStateViewController alloc]init];
            state.aleadyString=rongziField.text;
             [self.navigationController pushViewController:state animated:NO];
        }

    }
    
}
#pragma -mark -ToggleViewDelegate（性别选择按钮)
- (void)selectLeftButton:(ToggleView*)toggleView
{
    //    if (!isNewRemind) {
    //        [UIView animateWithDuration:0.3 animations:^{
    //            [offView setHidden:NO];
    //            [onView setHidden:YES];
    //            [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
    //            [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
    //        }];
    //    }
    //    isNewRemind = YES;
    //    [XBTextField setText:@"女"];
    //    [XBTextField setFont:[UIFont fontWithName:KUIFont size:17]];
    //    //全局变量赋值
}
- (void)selectRightButton:(ToggleView*)toggleView
{
    //    if (isNewRemind) {
    //        [UIView animateWithDuration:0.3 animations:^{
    //            [offView setHidden:YES];
    //            [onView setHidden:NO];
    //            [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
    //            [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
    //        }];
    //    }
    //    isNewRemind = NO;
    //    [XBTextField setText:@"男"];
    //    [XBTextField setFont:[UIFont fontWithName:KUIFont size:17]];
}
#pragma -mark -doClickAction

//点击头像
- (void)headerEditordEvent:(UIButton *)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"选择照片", nil];
    [actionSheet showInView:self.view];
}
- (void)wanchengEvent:(UIButton *)sender{
    //2014.08.19 chenlihua 当不点击完成时，头像已经保存了。
    [[NetManager sharedManager] SetUserPhotoWithUsername:[[UserInfo sharedManager] username]
                                             userpicture:[[NSUserDefaults standardUserDefaults] objectForKey:@"imgPth"]
                                                  hudDic:nil
                                                 success:^(id responseDic) {
                                                     
                                                     NSLog(@"respoisneDic = %@",responseDic);
                                                     
                                                     [[UserInfo sharedManager] setUserpicture:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]];
                                                     
                                                     
                                                 } fail:^(id errorString) {
                                                     
                                                     [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                     
                                                 }];
    
    
    NSLog(@"wancheng");
    NSLog(@"-姓名--%@",XMTextField.text);
    
   }
#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    
    switch (buttonIndex) {
        case 0:
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerDelegate
//2014.05.19 chenlihua 把头像图片原图上传
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *images = nil;
    images = [info objectForKey:UIImagePickerControllerEditedImage];
    [headimageView setImage:images];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //存储图像存储到home目录文件
        NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        
        NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
        
        NSData* imageDate =  UIImageJPEGRepresentation(images, .5);
        
        
        
        NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
        [imageDate writeToFile:imgPth atomically:YES];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NetManager sharedManager] SetUserPhotoWithUsername:[[UserInfo sharedManager] username]
                                                     userpicture:imgPth
                                                          hudDic:nil
                                                         success:^(id responseDic) {
                                                             
                                                             NSLog(@"respoisneDic = %@",responseDic);
                                                             
                                                             
                                                           //  [[UserInfo sharedManager] setUserpicture:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]];
                                                           
                                                             NSUserDefaults *photo=[NSUserDefaults standardUserDefaults];
                                                             [photo setObject:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]forKey:@"me-photo"];
                                                             [photo synchronize];
                                                             
                                                         } fail:^(id errorString) {
                                                             
                                                             [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                             
                                                         }];
        });
    });
    
}

#pragma -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
    //2014.07.22 chenlihua 解决输入完成之后，键盘无法返回
    if ([textField isEqual:XMTextField]) {
        //  [ZWTextField becomeFirstResponder];
        [XMTextField resignFirstResponder];
        return YES;
    }else if ([textField isEqual:XBTextField]) {
        // [ZWTextField becomeFirstResponder];
        [XBTextField resignFirstResponder];
        return YES;
    }
    if ([textField isEqual:ZWTextField]){
        //  [GWTextField becomeFirstResponder];
        [ZWTextField resignFirstResponder];
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        
        return YES;
    }else if ([textField isEqual:GWTextField]){
        // [FGTextField becomeFirstResponder];
        [GWTextField resignFirstResponder];
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        
        return YES;
    }else if ([textField isEqual:FGTextField]){
        // [SJTextField becomeFirstResponder];
        [FGTextField resignFirstResponder];
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        
        return YES;
    }else if ([textField isEqual:SJTextField]){
        // [WXHTextField becomeFirstResponder];
        [SJTextField resignFirstResponder];
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        
        return YES;
    }else if ([textField isEqual:WXHTextField]){
        // [EmailTextField becomeFirstResponder];
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        
        [WXHTextField resignFirstResponder];
        return YES;
    }else if ([textField isEqual:EmailTextField]){
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        [EmailTextField resignFirstResponder];
        return YES;
    }
    else if ([textField isEqual:rongziField]){
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        [rongziField resignFirstResponder];
        return YES;
    }
    else if ([textField isEqual:xiatextView]){
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         }];
        [gongsijj resignFirstResponder];
        return YES;
    }
    return NO;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:FGTextField]||[textField isEqual:SJTextField]||[textField isEqual:WXHTextField]||[textField isEqual:EmailTextField]||[textField isEqual:LLTextField]||[textField isEqual:xiatextView]) {
        
        
        
       [UIView animateWithDuration:0.3f
                         animations:^{
                            self.contentView.frame = CGRectMake(0, -80, 320, self.contentViewHeight);
                             
                             
                         }];
        
        
    }
    
    return YES;
}
#pragma -mark -UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0, -130, 320, self.contentViewHeight);
                         
                     }];
    
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([textView isEqual:gongsijj]) {
        ;
    }else{
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.contentView.frame = CGRectMake(0,64, 320, self.contentViewHeight);
                            
                         }];
        
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        if ([textView isEqual:gongsijj]) {
            
            [UIView animateWithDuration:0.1f
                             animations:^{
                                 self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                                
                             }];
            
        }
        return NO;
    }
    return YES;
}
#pragma -mark -functions
//完成按钮中，暂时取消了。
- (void)saveNSUserDefaults {
    
    NSString *xmString=XMTextField.text;
    NSString *xbString=XBTextField.text;
    NSString *zwString=ZWTextField.text;
    NSString *gwString=GWTextField.text;
    NSString *fgString=FGTextField.text;
    NSString *sjString=SJTextField.text;
    NSString *wxhString=WXHTextField.text;
    NSString *emailString=EmailTextField.text;
    NSString *llString=xiatextView.text;
    
    [(MineInFoemationViewController *)self.delegate
     reloadWithText:xmString
     Text:xbString
     Text:zwString
     Text:gwString
     Text:fgString
     Text:sjString
     Text:wxhString
     Text:emailString
     Text:llString];
    [self.navigationController popViewControllerAnimated:YES];
}
//完成按钮中，暂时取消的。
-(void)changeToLogin
{
    [Utils changeViewControllerWithTabbarIndex:4];
}
#pragma -mark -UIScrollerView Delegate
//2014.08.23 chenlihau 滑动的时候键盘会消失，解决上下滑动困难的问题。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                         [XMTextField resignFirstResponder];
                         [XBTextField resignFirstResponder];
                         [ZWTextField resignFirstResponder];
                         [GWTextField resignFirstResponder];
                         [FGTextField resignFirstResponder];
                         [SJTextField resignFirstResponder];
                         [WXHTextField resignFirstResponder];
                         [EmailTextField resignFirstResponder];
                         [LLTextField resignFirstResponder];
                         [xiatextView resignFirstResponder];
                         [rongziField restorationIdentifier];
                         [gongsijj resignFirstResponder];
                     }];
    
    
    
}



#pragma -mark -点击别处的时候，键盘会回去
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"1111");
    [XMTextField resignFirstResponder];
    [XBTextField resignFirstResponder];
    [ZWTextField resignFirstResponder];
    [GWTextField resignFirstResponder];
    [FGTextField resignFirstResponder];
    [SJTextField resignFirstResponder];
    [WXHTextField resignFirstResponder];
    [EmailTextField resignFirstResponder];
    [LLTextField resignFirstResponder];
    [xiatextView resignFirstResponder];
    [rongziField restorationIdentifier];
    
}
#pragma -mark -自定义相机
/*
- (void)configureNotification:(BOOL)toAdd {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTakePicture object:nil];
    if (toAdd) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackNotificationForFilter:) name:kNotificationTakePicture object:nil];
    }
}

- (void)callbackNotificationForFilter:(NSNotification*)noti {
    UIViewController *cameraCon = noti.object;
    if (!cameraCon) {
        return;
    }
    UIImage *finalImage = [noti.userInfo objectForKey:kImage];
    if (!finalImage) {
        return;
    }
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = finalImage;
    
    if (cameraCon.navigationController) {
        [cameraCon.navigationController pushViewController:con animated:YES];
    } else {
        [cameraCon presentViewController:con animated:YES completion:nil];
    }
}
#pragma mark - SCNavigationController delegate

-(void)sendSureMessage:(NSNotification *)notification
{
    
    UIImage *image = [notification.userInfo objectForKey:@"POST"];
    
    [self enSureBtnPressedSendMessage:image];
    image = nil;
}

- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = image;
    [navigationController pushViewController:con animated:YES];
    
}
-(void)enSureBtnPressedSendMessage:(UIImage *)image
{
    //2014.09.02 chenlihua 将此代码注视，将上面的代码打开
    [headimageView setImage:image];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //存储图像存储到home目录文件
        NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        
        NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
        
        NSData* imageDate =  UIImageJPEGRepresentation(image, .5);
        
        
        
        NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
        [imageDate writeToFile:imgPth atomically:YES];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //2014.08.19 chenlihua 当不点击完成时，头像已经保存了。
            NSUserDefaults *imgPthDefault=[NSUserDefaults standardUserDefaults];
            [imgPthDefault setObject:imgPth forKey:@"imgPth"];
            [imgPthDefault synchronize];
            
        });
    });
    
}
 */
#pragma -mark -functions
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
- (void)backButtonAction:(UIButton*)sender
{
    TMeansManageVC *tMeans=[[TMeansManageVC alloc]init];
    [self.navigationController pushViewController:tMeans animated:NO];
}

@end
