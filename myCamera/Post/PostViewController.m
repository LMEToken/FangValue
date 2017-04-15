//
//  PostViewController.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-21.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "PostViewController.h"
#import "SCCommon.h"

#import "ChatWithFriendViewController.h"

@interface PostViewController ()
{
    __block UIActivityIndicatorView *actiView;
}
@end

@implementation PostViewController



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
    
    //2014.09.12 chenlihua 设置点击拍照的时候跳转的时候，背景色不会及时显示出来
    self.view.backgroundColor=[UIColor blackColor];
    
   
     
    if (_postImage) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:_postImage];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80);
        imgView.center = self.view.center;
        [self.view addSubview:imgView];
        
        
        
    }
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, self.view.frame.size.height - 40, 80, 40);
    [backBtn setTitle:@"重拍" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    UIButton *enSureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    enSureBtn.frame = CGRectMake(250, self.view.frame.size.height -40, 80, 40);
    [enSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [enSureBtn addTarget:self action:@selector(enSureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enSureBtn];
    
    
   

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)enSureBtnPressed:(id)sender
{
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_postImage,@"POST", nil];
//    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    
    [ [NSNotificationCenter defaultCenter]  postNotificationName:@"Clickimage" object:nil userInfo:dic];
    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [SCCommon saveImageToPhotoAlbum:_postImage];//存至本机
    });
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  }

@end
