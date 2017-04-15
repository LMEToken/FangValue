//
//  RegistrationViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//第二步注册页面
#import "RegistrationViewController.h"
#import "InformationViewController.h"
#import "TermsOfUseViewController.h"
#import "SignInViewController.h"

//2014.09.12 chenlihua 自定义相机
#import "PostViewController.h"


@interface RegistrationViewController ()

    
@end

@implementation RegistrationViewController
{
    int butTag;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initavlueNextaccout:(NSString *)useraccout password:(NSString *)password verificationcode:(NSString *)verificationcode{

    if (self) {
        userAccout=[[NSString alloc]initWithFormat:@"%@",useraccout];
        passWord=[[NSString alloc]initWithFormat:@"%@",password];
        code=[[NSString alloc]initWithFormat:@"%@",verificationcode];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"注册"];
	
    
    //2014.09.13 chenlihua 自定义相机，头像
    //声明通知中心,获得默认的通知中心
    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    //添加观察者
    [notiCenter addObserver:self selector:@selector(sendSureMessage:) name:@"Click" object:nil];
    
    
    //方创的背景图片
    UIImage *image2=[UIImage imageNamed:@"ic_logo"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(55, 20, 210, 110)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:image2];
   [self.contentView addSubview:imageView];

    
    //头像背景图片
   // UIImage *image=[UIImage imageNamed:@"03_touxiang_1"];
    //2014.07.23 chenlihua 修改头像图标的背景图
    UIImage *image=[UIImage imageNamed:@"chatHeadImage"];
    headImage=[[CacheImageView alloc]initWithFrame:CGRectMake((320-135/2)/2, CGRectGetMaxY(imageView.frame)+10, 114/2, 135/2)];
    [headImage setBackgroundColor:[UIColor clearColor]];
    [headImage setImage:image];
    [self.contentView addSubview:headImage];

    
    //上传名片按钮
    UIButton *headImageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [headImageBut setFrame:CGRectMake(110, CGRectGetMaxY(headImage.frame)+10, 100, 30)];
    [headImageBut setBackgroundColor:[UIColor clearColor]];
    [headImageBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:headImageBut size:15];
    //2014.07.10 chenlihua ”上传名片“改为上传“头像"
    //  [headImageBut setTitle:@"上传名片" forState:UIControlStateNormal];
    [headImageBut setTitle:@"上传头像" forState:UIControlStateNormal];
    headImageBut.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    
    //上传名处下划线
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(headImage.frame)+35, 60, 0.5)];
    [lab setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:lab];
    
    //    [headImageBut setImage:[UIImage imageNamed:@"03_touxiang_1"] forState:UIControlStateNormal];
    [headImageBut addTarget:self action:@selector(headerImageEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:headImageBut];
    
    
    
    
    NSArray *array=[NSArray arrayWithObjects:@"融资方",@"投资方",@"其他", nil];
    for (int i = 0; i<3; i++) {
        
        //字后面的Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(60+80*i, CGRectGetMaxY(headImageBut.frame)+30, 50, 15)];
        [lab setFont:[UIFont systemFontOfSize:15]];
        [lab setTextColor:[UIColor grayColor]];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setText:[array objectAtIndex:i]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [self.contentView addSubview:lab];

        butTag=100 ;
        
        
        //能点击的小圆点按钮
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(40+80*i, CGRectGetMaxY(headImageBut.frame)+30, 15, 15)];
        [but setImage:[UIImage imageNamed:@"03_dian_1"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"03_dian_2"] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(valueName1:) forControlEvents:UIControlEventTouchUpInside];
        [but setTag:i+100];
        [self.contentView addSubview:but];
        
        if (butTag == i + 100) {
            [but setSelected:YES];
            [but setUserInteractionEnabled:NO];
        }
    }
    
    //完成注册背景色
    UIImage *image6=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(headImageBut.frame)+70, 508/2, 66/2)];
    [button setBackgroundImage:image6 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"完成注册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(wanchengEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:button];
    
    //我已阅读使用条款
    UIButton *yuetuBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [yuetuBut setFrame:CGRectMake(150, CGRectGetMaxY(button.frame)+10, 120, 30)];
    [yuetuBut setBackgroundColor:[UIColor clearColor]];
    [yuetuBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:yuetuBut size:15];
    [yuetuBut setTitle:@"我已阅读使用条款" forState:UIControlStateNormal];
    [yuetuBut addTarget:self action:@selector(yuetuButEvent:) forControlEvents:UIControlEventTouchUpInside];
    yuetuBut.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:yuetuBut];
    
    //我已阅读使用条款下划线
    UILabel *lab23=[[UILabel alloc]initWithFrame:CGRectMake(150, CGRectGetMaxY(button.frame)+35, 120, 0.5)];
    [lab23 setBackgroundColor:[UIColor blueColor]];
    [lab23 setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:lab23];

    //阅读使用条款，前面的圈圈
    but4=[[UIButton alloc]init];
    [but4 setBackgroundColor:[UIColor redColor]];
    [but4 setFrame:CGRectMake(130, CGRectGetMaxY(button.frame)+17, 15, 15)];
   [but4 setImage:[UIImage imageNamed:@"03_dian_1"] forState:UIControlStateNormal];
    [but4 setImage:[UIImage imageNamed:@"03_dian_2"] forState:UIControlStateSelected];
    but4.selected=YES;
    [but4 addTarget:self action:@selector(valueName2:) forControlEvents:UIControlEventTouchUpInside];
    but4.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:but4];

    //默认用户类型为融资方
    self.type = @"0";
}

#pragma -mark -doClickAction
//上传名片
- (void)headerImageEvent:(UIButton *)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"选择照片", nil];
    [actionSheet showInView:self.view];
    
}
//选择角色
- (void)valueName1:(UIButton *)sender{
    
    NSLog(@"tag=== %d",sender.tag);
    UIButton *button = (UIButton *)[self.contentView viewWithTag:butTag];
    [button setSelected:NO];
    [button setUserInteractionEnabled:YES];
    
    [sender setUserInteractionEnabled:NO];
    [sender setSelected:YES];
    
    int intvalue = sender.tag -100;
    NSString *typeStr=[NSString stringWithFormat:@"%d",intvalue];
    
    self.type = typeStr;
    
    NSLog(@"self.type = %@",self.type);
    
    butTag = sender.tag;
    
}
//完成注册
- (void)wanchengEvent:(UIButton *)sender{
    
    NSString* path =  [Utils ImagePath:headImage.image];
    [NSThread sleepForTimeInterval:1.f];
    
    //    //防止重复点击
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(wanchengEvent:) object:nil];
    sender.enabled = NO;
    
    [[NetManager sharedManager]registerWithuseraccout:userAccout
                                             password:passWord
                                          userpicture:path
                                         registertype:self.type
                                     verificationcode:code
                                               hudDic:nil
                                              success:^(id responseDic) {
                                                  sender.enabled = YES;
                                                  
                                              // [self.view showActivityOnlyLabelWithOneMiao:@"注册成功"];
                                               //2014.07.10 chenlihua 修改提示语
                                                  
                                                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                                                  [alert show];
                                                 
                                                [NSThread sleepForTimeInterval:2.f];
                                                  
                                                  //2014.07.02 chenlihua 使密码在登陆的时候保存，保存最后一个人的密码。
                                                  
                                                  //2014.07.10 chenlihua 将此打开，让注册成功后，跳转到登陆的首界面。
                                                  [[NSUserDefaults standardUserDefaults] setObject:userAccout forKey:@"accout"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                  [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:@"password"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                  
                                                //2014.07.10 chenlihua 登陆时跳转到登陆页面
                                                //  [Utils changeViewControllerWithTabbarIndex:5];
                                                  SignInViewController *sign=[[SignInViewController alloc]init];
                                                  [self.navigationController pushViewController:sign animated:NO];
                                                  
                                                  
                                              } fail:^(id errorString) {
                                                  
                                                  sender.enabled = YES;
                                                  sleep(2);
                                                  //2014.07.14 chenlihua 改成同服务器端返回提醒参数
                                                  [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",[errorString description]]];
                                                  
                                                  //2014.07.10 chenlihua 修改提示语
                                                  /*
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"注册失败，请与管理员联系" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"正确", nil];
                                                  [alert show];
                                                  */
                                                  
                                              }];
    
    
}
//阅读使用条款
- (void)yuetuButEvent:(UIButton *)sender{
    TermsOfUseViewController *view=[[TermsOfUseViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
//阅读使用条款
- (void)valueName2:(UIButton *)sender{
    if (but4.selected) {
        [but4 setSelected:NO];
    }else{
        [but4 setSelected:YES];
    }
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    
    switch (buttonIndex) {
        case 0:
        {
            /*
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
             */
            //2014.09.12 用系统自定义的相机
            [self configureNotification:YES];
            
            SCNavigationController *nav = [[SCNavigationController alloc] init];
            nav.scNaigationDelegate = self;
            [nav showCameraWithParentController:self];

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
}
#pragma -mark -自定义相机
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
    
}

- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = image;
    [navigationController pushViewController:con animated:YES];
    
}
-(void)enSureBtnPressedSendMessage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(152, 152);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    headImage.image = newImage;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
