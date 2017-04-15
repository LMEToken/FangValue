//
//  EditordieViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//我的资料编辑页面
#import "EditordieViewControllerF.h"
#import <QuartzCore/QuartzCore.h>
#import "MineInFoemationViewController.h"
#import "CacheImageView.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "FMeansManageVC.h"
#import "FvaMyVC.h"

@interface EditordieViewControllerF ()

@end

@implementation EditordieViewControllerF

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"我的资料"];
    
    //右侧完成按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(wanchengEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rightButton isAutoFrame:NO];
    
    //UIScrollView
    UIScrollView *inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [inforView setBackgroundColor:[UIColor clearColor]];
    [inforView setShowsVerticalScrollIndicator:YES];
    [inforView setContentSize:CGSizeMake(320, 530)];
    [inforView setDelegate:self];
    [self.contentView addSubview:inforView];
    
    //上半部分背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 305/2)];
    [imageView setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [inforView addSubview:imageView];
    
    //头像Label
    UILabel *headlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 25)];
    [headlab setBackgroundColor:[UIColor clearColor]];
    [headlab setTextColor:[UIColor grayColor]];
    [headlab setText:@"头像:"];
    [inforView addSubview:headlab];
    
    //头像图片
    /*
     headimageView=[[CacheImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
     [headimageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
     [headimageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
     */
    //2014.06.13 cehnlihua 修改图片缓存方式
    headimageView=[[UIImageView alloc]initWithFrame:CGRectMake(320-55-15, 8, 50, 50
                                                               )];
    [headimageView setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    
    
    //2014.05.13 chenlihua 暂时去掉圆角，好与微信做对比。
    [headimageView.layer setCornerRadius:10.0f];
    [headimageView.layer setMasksToBounds:YES];
    [inforView addSubview:headimageView];
    
    //头像点击按钮
    UIButton *headBUT=[UIButton buttonWithType:UIButtonTypeCustom];
    [headBUT setFrame:CGRectMake(200, 8, 120, 50)];
    [headBUT setBackgroundColor:[UIColor clearColor]];
    [headBUT addTarget:self action:@selector(headerEditordEvent:) forControlEvents:UIControlEventTouchUpInside];
    [inforView addSubview:headBUT];
    
    NSArray *basicArray=[NSArray arrayWithObjects:@"姓名:",@"性别:", nil];
    for (int i=1; i<3; i++) {
        //下划线
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5+45*i, 300, 1)];
        [imageView setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [inforView addSubview:imageView];
        
        //姓名，性别:Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor grayColor]];
        [lab setText:[basicArray objectAtIndex:(i-1)]];
        [inforView addSubview:lab];
        
        //姓名，性别内容的背景图片
//        UIImageView *imageViewtext=[[UIImageView alloc]initWithFrame:CGRectMake(310-204.5, 27.5+45*i, i==2 ? 100:409/2, 49/2)];
//        [imageViewtext setImage:[UIImage imageNamed:@"61_kuang_1"]];
//        [inforView addSubview:imageViewtext];
    }
    
    XMTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, 29.5+45*1, 409/2, 49/2-4)];
    [XMTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [XMTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [XMTextField setPlaceholder:@"请输入您的姓名"];
    [XMTextField setFont:[UIFont systemFontOfSize:15]];
    [XMTextField setText:[[UserInfo sharedManager] user_name]];
    XMTextField.backgroundColor=[UIColor clearColor];
    [XMTextField setDelegate:self];
    [inforView addSubview:XMTextField];
    
    XBTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, 27.5+45*2, 100, 49/2)];
    
//    [XBTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [XBTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [XBTextField setPlaceholder:@"选择性别"];
    [XBTextField setEnabled:NO];
    [XBTextField setFont:[UIFont systemFontOfSize:15]];
    //    if ([[[UserInfo sharedManager] usergender] isEqualToString:@"f"]) {
    //         [XBTextField setText:@"女"];
    //    }else
    //    {
    //        [XBTextField setText:@"男"];
    //    }
    
    [XBTextField setReturnKeyType:UIReturnKeyNext];
    [XBTextField setDelegate:self];
    // XBTextField.backgroundColor=[UIColor redColor];
    [inforView addSubview:XBTextField];
    
    NSLog(@"---sex--%@",textStr2);
    if ([textStr2 isEqualToString:@"f"]) {
        [XBTextField setText:@"女"];
        isNewRemind = YES;
    }
    else
    {
        isNewRemind = NO;
        [XBTextField setText:@"男"];
    }
    
    //选择按钮
    toggleViewBaseChange = [[ToggleView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10, CGRectGetMinY(XBTextField.frame) + 3, 100, 30) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeChangeImage toggleButtonType:ToggleButtonTypeDefault];
    toggleViewBaseChange.toggleDelegate = self;
    [inforView addSubview:toggleViewBaseChange];
    
    
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
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, 320, 734/2)];
    [imageView1 setImage:[UIImage imageNamed:@"60_kuang_2"]];
    [inforView addSubview:imageView1];
    //,@"微信号:",@"Email:",@"履历:"
    NSArray *moreArray=[NSArray arrayWithObjects:@"所在地:",@"公司:",@"职位:",@"邮箱:", nil];
    for (int k=1 ; k<5; k++) {
        //职位等Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor grayColor]];
        [lab setText:[moreArray objectAtIndex:(k-1)]];
        [inforView addSubview:lab];
        
    }
    for (int j=1; j<5; j++) {
        //下划线
        UIImageView *imageViewk=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10+45*j, 300, 1)];
        [imageViewk setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [inforView addSubview:imageViewk];
        
        //右侧黄色的背景框图片
//        UIImageView *imageViewtext=[[UIImageView alloc]initWithFrame:CGRectMake(310-204.5, CGRectGetMaxY(imageView.frame)+20+45*(j-1), 409/2, 49/2)];
//        [imageViewtext setImage:[UIImage imageNamed:@"61_kuang_1"]];
//        [inforView addSubview:imageViewtext];
    }
    
    //职位的内容Label
    ZWTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(1-1), 409/2, 49/2)];
    [ZWTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [ZWTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [ZWTextField setPlaceholder:@"请输入您的所在地"];
    [ZWTextField setFont:[UIFont systemFontOfSize:15]];
    [ZWTextField setText:[[UserInfo sharedManager] base]];
    //   [ZWTextField setReturnKeyType:UIReturnKeyNext];
    //  [ZWTextField setReturnKeyType:UIReturnKeyDefault];
    [ZWTextField setDelegate:self];
    ZWTextField.backgroundColor=[UIColor clearColor];
    [inforView addSubview:ZWTextField];
    
    //岗位的内容Label
    GWTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(2-1), 409/2, 49/2)];
    [GWTextField setBorderStyle:UITextBorderStyleRoundedRect];
   // [GWTextField setKeyboardType:UIKeyboardTypeEmailAddress];
     GWTextField.userInteractionEnabled = YES;
    GWTextField.backgroundColor=[UIColor clearColor];
    [GWTextField setPlaceholder:@"请输入你的公司名"];
    [GWTextField setFont:[UIFont systemFontOfSize:15]];
    [GWTextField setText:[[UserInfo sharedManager] comname]];
    //    [GWTextField setReturnKeyType:UIReturnKeyNext];
    // [GWTextField setReturnKeyType:UIReturnKeyDefault];
    [GWTextField setDelegate:self];
    [inforView addSubview:GWTextField];
    
    
    
    //分工的内容Label
    FGTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(3-1), 409/2, 49/2-4)];
    [FGTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [FGTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [FGTextField setPlaceholder:@"请输入您的职位"];
    [FGTextField setFont:[UIFont systemFontOfSize:15]];
    FGTextField.backgroundColor=[UIColor clearColor];
    [FGTextField setText:[[UserInfo sharedManager] post]];
    //    [FGTextField setReturnKeyType:UIReturnKeyNext];
    // [FGTextField setReturnKeyType:UIReturnKeyDefault];
    [FGTextField setDelegate:self];
    [inforView addSubview:FGTextField];
    
    //    //手机号的内容Label
    //    SJTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(4-1), 409/2, 49/2-4)];
    //    [SJTextField setBorderStyle:UITextBorderStyleNone];
    //    [SJTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //    [SJTextField setPlaceholder:@"请输入您的手机号码"];
    //    [SJTextField setFont:[UIFont systemFontOfSize:15]];
    //    [SJTextField setText:textStr6];
    //    [SJTextField setReturnKeyType:UIReturnKeyNext];
    //   // [SJTextField setReturnKeyType:UIReturnKeyDefault];
    //    [SJTextField setDelegate:self];
    //    [inforView addSubview:SJTextField];
    //
    
    //    //Email的内容Label
    WXHTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(4-1), 409/2, 49/2-4)];
    [WXHTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [WXHTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [WXHTextField setPlaceholder:@"请输入您的邮箱号码"];
    [WXHTextField setFont:[UIFont systemFontOfSize:15]];
    [WXHTextField setText:[[UserInfo sharedManager] useremail]];
    WXHTextField.backgroundColor=[UIColor clearColor];
    //    [WXHTextField setReturnKeyType:UIReturnKeyNext];
    // [WXHTextField setReturnKeyType:UIReturnKeyDefault];
    [WXHTextField setDelegate:self];
    [inforView addSubview:WXHTextField];
    //
    //    //微信号的内容Label
    //    EmailTextField=[[UITextField alloc]initWithFrame:CGRectMake(310-200.5, CGRectGetMaxY(imageView.frame)+22+45*(6-1), 409/2, 49/2-4)];
    //    [EmailTextField setBorderStyle:UITextBorderStyleNone];
    //    [EmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //    [EmailTextField setPlaceholder:@"请输入您的微信号码"];
    //    [EmailTextField setFont:[UIFont systemFontOfSize:15]];
    //    [EmailTextField setText:textStr8];
    //    [EmailTextField setReturnKeyType:UIReturnKeyNext];
    //   // [EmailTextField setReturnKeyType:UIReturnKeyDefault];
    //    [EmailTextField setDelegate:self];
    //    [inforView addSubview:EmailTextField];
    //
    //    //履历的内容textView
    //    xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(305-200.5, CGRectGetMaxY(EmailTextField.frame)+22, 409/2, 75)] ;
    //    [xiatextView setTextColor:[UIColor blackColor]];
    //    [xiatextView.layer setBorderWidth:1.f];
    //    [xiatextView.layer setBorderColor:[UIColor colorWithRed:241/255.0 green:191/255.0 blue:172/255.0 alpha:1.0].CGColor];
    //    [Utils setDefaultFont:xiatextView size:15];
    //    [xiatextView.layer setCornerRadius:3];
    //    [xiatextView setDelegate:self];
    //    [xiatextView setBackgroundColor:[UIColor clearColor]];
    //    [xiatextView setText:textStr9];
    //    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    //    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
    //    [xiatextView setScrollEnabled:YES];
    //    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    //    [inforView addSubview: xiatextView];
}


#pragma -mark -ToggleViewDelegate（性别选择按钮)
- (void)selectLeftButton:(ToggleView*)toggleView
{
    if (!isNewRemind) {
        [UIView animateWithDuration:0.3 animations:^{
            [offView setHidden:NO];
            [onView setHidden:YES];
            [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
            [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 22, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        }];
    }
    isNewRemind = YES;
    [XBTextField setText:@"女"];
    //全局变量赋值
}
- (void)selectRightButton:(ToggleView*)toggleView
{
    if (isNewRemind) {
        [UIView animateWithDuration:0.3 animations:^{
            [offView setHidden:YES];
            [onView setHidden:NO];
            [onView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
            [offView setFrame:CGRectMake(CGRectGetMaxX(XBTextField.frame) + 10 + 40, CGRectGetMinY(toggleViewBaseChange.frame), 19, 19)];
        }];
    }
    isNewRemind = NO;
    [XBTextField setText:@"男"];
}
#pragma -mark -doClickAction
//点击头像
- (void)headerEditordEvent:(UIButton *)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"选择照片", nil];
    [actionSheet showInView:self.view];
}
//用正则表达式验证邮箱
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
- (void)wanchengEvent:(UIButton *)sender{
    NSLog(@"%@",SJTextField.text);
    
    if (![self isConnectionAvailable]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    if (![self isValidateEmail:WXHTextField.text]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的邮箱地址" delegate:self cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"修改成功",@"success", nil];
    NSString *sex=@"f";
    if ([XBTextField.text isEqualToString:@"男"]) {
        sex = @"m";
    }else
    {
        sex=@"f";
    }
    [[NetManager sharedManager]setUserInfoWithUsername:[[UserInfo sharedManager]username] user_name:XMTextField.text usergender:sex  post:FGTextField.text base:ZWTextField.text comname:GWTextField.text email:WXHTextField.text fmoney:@"" statge:@"" frounds2:@"" pdesc:@"" teamsize:@"" industry:@"" currency:@"" apptoken:[[UserInfo sharedManager]apptoken] hudDic:dic success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        
        
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
        //        [[UserInfo sharedManager] setUserpicture:[Utils checkKey:responseDic key:@"picurl2"]];
        
        [[UserInfo sharedManager] setUsergender:sex];
        
        //新增
        [[UserInfo sharedManager] setComname:GWTextField.text];
        [[UserInfo sharedManager] setBase:ZWTextField.text];
        [[UserInfo sharedManager] setPost:FGTextField.text];
        [[UserInfo sharedManager] setUseremail:WXHTextField.text];
        
        UIAlertView *show = [[UIAlertView alloc]initWithTitle:@"修改成功" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [show show];
        //          [self.view showActivityOnlyLabelWithOneMiao:@"修改成功"];
        //        sleep(2);
        
        /*
        
        FvaMyVC *vc = [[FvaMyVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        */
        /*
        TMeansManageVC *tMeans=[[TMeansManageVC alloc]init];
        [self.navigationController pushViewController:tMeans animated:NO];
         */
        
        FMeansManageVC *fMeans=[[FMeansManageVC alloc]init];
        [self.navigationController pushViewController:fMeans animated:NO];
        
        
    }fail:^(id failed)
     {
         UIAlertView *show = [[UIAlertView alloc]initWithTitle:@"修改失败" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
         [show show];
     }];
    //[self saveNSUserDefaults];
    //    NSLog(@"wancheng");
    
    //    [[NetManager sharedManager]setUserInfoWithUsername:[[UserInfo sharedManager]username]
    //                                             user_name:XMTextField.text
    //                                            usergender:isNewRemind ? @"f" :@"m"
    //                                                  duty:ZWTextField.text
    //                                                  post:GWTextField.text
    //                                                divide:FGTextField.text
    //                                                 phone:SJTextField.text
    //                                                weixin:WXHTextField.text
    //                                                 email:EmailTextField.text
    //                                                record:xiatextView.text
    //                                                hudDic:dic
    //                                               success:^(id responseDic) {
    //                                                   NSLog(@"-----responseDic=%@",responseDic);
    //
    //                                                   [[UserInfo sharedManager] setUser_name:XMTextField.text];
    //                                                   [[UserInfo sharedManager] setUsergender:XBTextField.text];
    //                                                   [[UserInfo sharedManager] setDuty:ZWTextField.text];
    //                                                   [[UserInfo sharedManager] setPost:GWTextField.text];
    //                                                   [[UserInfo sharedManager] setDivide:FGTextField.text];
    //                                                   [[UserInfo sharedManager] setUserphone:SJTextField.text];
    //                                                   [[UserInfo sharedManager] setWeixin:WXHTextField.text];
    //                                                   [[UserInfo sharedManager] setUseremail:EmailTextField.text];
    //                                                   [[UserInfo sharedManager] setRecord:xiatextView.text];
    //
    //                                                   [(MineInFoemationViewController*)(self.delegate) reloadWithText:XMTextField.text
    //                                                                                                              Text:XBTextField.text
    //                                                                                                              Text:ZWTextField.text
    //                                                                                                              Text:GWTextField.text
    //                                                                                                              Text:FGTextField.text
    //                                                                                                              Text:SJTextField.text
    //                                                                                                              Text:WXHTextField.text
    //                                                                                                              Text:EmailTextField.text
    //                                                                                                              Text:xiatextView.text];
    //
    //                                                                                                    [self.navigationController popViewControllerAnimated:YES];
    //                                                   //                                                   [self performSelector:@selector(changeToLogin) withObject:self afterDelay:1];
    //
    //                                               }
    //                                                  fail:^(id errorString) {
    //                                                      [self.view showActivityOnlyLabelWithOneMiao:errorString];
    //                                                  }];
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
//    if([[[UIDevice currentDevice] systemVersion] integerValue] < 6.0)
//    {
//        images = [info objectForKey:UIImagePickerControllerEditedImage];
//    }
//    else
//    {
//        images = [info objectForKey:UIImagePickerControllerOriginalImage];
//    }
    
    //自定长宽缩放
    //裁剪相片，使其占用更小的内存
    
    /*
     CGSize newSize = CGSizeMake(46, 46);
     UIGraphicsBeginImageContext(newSize);
     [images drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
     UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     [headimageView setImage:newImage];
     */
    
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
                                                             
                                                           //   [[UserInfo sharedManager] setUserpicture:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]];
                                                             
                                                        
                                                             
                                                             NSUserDefaults *photo=[NSUserDefaults standardUserDefaults];
                                                             [photo setObject:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]forKey:@"me-photo"];
                                                             [photo synchronize];
                                                             
                                                         } fail:^(id errorString) {
                                                             
                                                             [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                             
                                                         }];
        });
    });
}

//2014.05.13 chenlihua 头像图片压缩得太厉害
//2014.05.19 chenlihua 此段代码暂时注释掉。
/*
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
 
 //自定长宽缩放
 //裁剪相片，使其占用更小的内存
 
 CGSize newSize = CGSizeMake(46, 46);
 UIGraphicsBeginImageContext(newSize);
 [images drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 [headimageView setImage:newImage];
 
 
 [picker dismissViewControllerAnimated:YES completion:nil];
 
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 
 //存储图像存储到home目录文件
 NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
 
 NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
 NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
 
 NSData* imageDate =  UIImageJPEGRepresentation(newImage, .5);
 
 
 
 NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
 [imageDate writeToFile:imgPth atomically:YES];
 
 
 dispatch_async(dispatch_get_main_queue(), ^{
 
 [[NetManager sharedManager] SetUserPhotoWithUsername:[[UserInfo sharedManager] username]
 userpicture:imgPth
 hudDic:nil
 success:^(id responseDic) {
 
 NSLog(@"respoisneDic = %@",responseDic);
 
 [[UserInfo sharedManager] setUserpicture:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]];
 
 
 } fail:^(id errorString) {
 
 [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
 
 }];
 });
 });
 }
 */
/*
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
 CGSize newSize = CGSizeMake(46, 46);
 UIGraphicsBeginImageContext(newSize);
 [images drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 [headimageView setImage:newImage];
 [picker dismissViewControllerAnimated:YES completion:nil];
 
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 
 NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
 
 NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
 NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
 
 NSData* imageDate =  UIImageJPEGRepresentation(newImage, .5);
 
 NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
 [imageDate writeToFile:imgPth atomically:YES];
 
 dispatch_async(dispatch_get_main_queue(), ^{
 
 [[NetManager sharedManager] SetUserPhotoWithUsername:[[UserInfo sharedManager] username]
 userpicture:imgPth
 hudDic:nil
 success:^(id responseDic) {
 
 NSLog(@"respoisneDic = %@",responseDic);
 
 [[UserInfo sharedManager] setUserpicture:[[responseDic objectForKey:@"data"] objectForKey:@"photourl"]];
 
 
 } fail:^(id errorString) {
 
 [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
 
 }];
 });
 });
 }
 */
#pragma -mark -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                     }];
    
    [textField resignFirstResponder];
    return YES;
    //2014.07.22 chenlihua 解决输入完成之后，键盘无法返回
    //    if ([textField isEqual:XMTextField]) {
    //        [XBTextField resignFirstResponder];
    //     //   [XBTextField resignFirstResponder];
    //        return YES;
    //    }else if ([textField isEqual:XBTextField]) {
    //        [XBTextField resignFirstResponder];
    //       // [XBTextField resignFirstResponder];
    //        return YES;
    //    }
    //    if ([textField isEqual:ZWTextField]){
    //        [GWTextField resignFirstResponder];
    //      //  [GWTextField resignFirstResponder];
    //        return YES;
    //    }else if ([textField isEqual:GWTextField]){
    //        [FGTextField resignFirstResponder];
    //       // [FGTextField resignFirstResponder];
    //        return YES;
    //    }else if ([textField isEqual:FGTextField]){
    //       [SJTextField resignFirstResponder];
    //       //  [SJTextField resignFirstResponder];
    //        return YES;
    //     }else if ([textField isEqual:SJTextField]){
    //        [WXHTextField resignFirstResponder];
    //       //  [WXHTextField resignFirstResponder];
    //        return YES;
    //    }else if ([textField isEqual:WXHTextField]){
    //        [EmailTextField resignFirstResponder];
    //       // [EmailTextField resignFirstResponder];
    //        return YES;
    //    }else if ([textField isEqual:EmailTextField]){
    //         [UIView animateWithDuration:0.3f
    //                         animations:^{
    //                             self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
    //                         }];
    //        [EmailTextField resignFirstResponder];
    //        return YES;
    //    }
    //    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual: XMTextField]) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 65, 320, self.contentViewHeight);
                         }];
    }
    if ([textField isEqual: ZWTextField]) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, 0, 320, self.contentViewHeight);
                         }];
    }
    
    if ([textField isEqual: GWTextField]) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, -10, 320, self.contentViewHeight);
                         }];
    }
    
    if ([textField isEqual:FGTextField]) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, -10, 320, self.contentViewHeight);
                         }];
    }
    
    if ([textField isEqual:WXHTextField]) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.contentView.frame = CGRectMake(0, -10, 320, self.contentViewHeight);
                         }];
    }
    return YES;
}
#pragma -mark -UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0, -150, 320, self.contentViewHeight);
                     }];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0, 64, 320, self.contentViewHeight);
                     }];
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
