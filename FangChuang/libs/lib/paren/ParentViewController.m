//
//  ParentViewController.m
//  community
//
//  Created by 潘鸿吉 on 13-8-13.
//  Copyright (c) 2013年 BlueMobi BlueMobi. All rights reserved.
//

#import "ParentViewController.h"

//#define tabbarCount 4
//#define tabbarHeight 40
//#define tabbarTag 99
//#define tabbarButtonTag 100
//
//#define navigationHeight 53
//#define backButtonTag 110
//#define rightButtonTag 111





@interface ParentViewController ()

@end

@implementation ParentViewController

@synthesize titleLabel;
@synthesize navigationView;
@synthesize contentView;
@synthesize tabbarView;
@synthesize statusBarBackgroundView;
@synthesize contentViewHeight;


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

//    TABBARHEIGHT = 40;
//	// Do any additional setup after loading the view.
     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
     [self.navigationController setNavigationBarHidden:YES];
     [[UIApplication sharedApplication] setStatusBarHidden:NO];
     [self addview];
 

}
-(void)addbackview
{
    
   [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UIImageView *showimage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    showimage.image = [UIImage imageNamed:@"4buffer.jpg"];
    self.backview = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.backview addSubview:showimage];
    [self.view addSubview:self.backview];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeview) userInfo:nil repeats:NO];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"fristcome"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)removeview
{
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
      [self.backview setHidden:YES];

}
-(void)addview
{
    statusBarHeight = 0;
    
    if ([[Utils systemVersion] floatValue] >= 7 && deviceHasStateBar) {
        //  statusBarHeight = 20;
        //将电量所在的状态条隐藏
        statusBarHeight = 20;
        
        statusBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
        //  [statusBarBackgroundView setBackgroundColor:[UIColor clearColor]];
        //   [statusBarBackgroundView setBackgroundColor:[UIColor redColor]];
        [statusBarBackgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"4_0002_Header"]]];
        [self.view addSubview:statusBarBackgroundView];
        
        
        //屏蔽tableview自滑动
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self initNavigationBar];
    [self initTabbar];
    
    int tabbarheight = 0;
    int navigationbarheight = 0;
    if (tabbarView) {
        tabbarheight = tabbarView.frame.size.height;
    }
    if (navigationView) {
        navigationbarheight = navigationView.frame.size.height;
    }
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight+navigationbarheight, 320, screenHeight-tabbarheight-navigationbarheight)];
    [contentView setUserInteractionEnabled:YES];
    [self.view addSubview:contentView];
    
    [contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing_1"]]];
    
    //    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:contentView.bounds];
    //    [backgroundImageView setImage:[UIImage imageNamed:@"beijing_1"]];
    //    [contentView addSubview:backgroundImageView];
    //    [backgroundImageView release];
    
    [self.view bringSubviewToFront:statusBarBackgroundView];
    [self.view bringSubviewToFront:navigationView];
    [self.view bringSubviewToFront:tabbarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - contentViewHeight
- (float) contentViewHeight
{
    if (contentView) {
        return contentView.frame.size.height;
    }
    return 0;
}

#pragma mark - init navigationBar
- (void) initNavigationBar
{
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, 320, navigationHeight)];
    //[navigationView setBackgroundColor:[UIColor redColor]];
    [navigationView setUserInteractionEnabled:YES];
    [self.view addSubview:navigationView];

    //[navigationView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"shangdaohangtiao_1"]]];
    
    //2014.09.02 chenlihua alan改
    [navigationView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"4_0002_Header"]]];
    
//    UIImage *navigationImage = [UIImage imageNamed:@"shangdaohangtiao_1"];
//    UIImageView *navigationBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(navigationView.frame), CGRectGetHeight(navigationView.frame))];
//    [navigationBgImageView setImage:navigationImage];
//    [navigationView addSubview:navigationBgImageView];
//    [navigationBgImageView release];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, navigationHeight)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
//    [titleLabel setText:@"行业信息"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
   // [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0f]];
    [navigationView addSubview:titleLabel];
   
    
}

- (void) doNavigationAction : (id) sender
{
    NSLog(@"123");
}

- (void) setTitle:(NSString *)title
{
    if (titleLabel) {
        [titleLabel setText:title];
        titleLabel.font=[UIFont fontWithName:KUIFont size:20];
     
    }
}

- (void) setNavigationViewHidden : (BOOL) hidden
{
    if (navigationView) {
        [navigationView setHidden:hidden];
        [contentView setFrame:CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y-navigationHeight, contentView.frame.size.width, contentView.frame.size.height+navigationHeight)];
    }
}

#pragma mark - init Tabbar
/*
- (void) initTabbar
{
    NSLog(@"screenheight = %f , tabheight = %d y =  %f , sta = %d",screenHeight,TABBARHEIGHT,screenHeight- TABBARHEIGHT + statusBarHeight,statusBarHeight);
    
    tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight- TABBARHEIGHT + statusBarHeight, 320, TABBARHEIGHT)];
    [tabbarView setBackgroundColor:[UIColor redColor]];
    [tabbarView setTag:tabbarTag];
    [self.view addSubview:tabbarView];

   
    NSLog(@"tabbarView.y : %f",tabbarView.frame.origin.y);
    for (int i = 0; i < tabbarCount; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(320/tabbarCount), 0, (320/tabbarCount), TABBARHEIGHT)];
        [button setTag:i + tabbarButtonTag];
    
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"fangchuangDown%d",i]] forState:UIControlStateSelected];
        
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"fangChuangNormal%d",i]] forState:UIControlStateNormal];
        
         [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:button];

    }
  
}
*/
- (void) initTabbar
{
    NSLog(@"screenheight = %f , tabheight = %d y =  %f , sta = %d",screenHeight,TABBARHEIGHT,screenHeight- TABBARHEIGHT + statusBarHeight,statusBarHeight);
    
    tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight- TABBARHEIGHT + statusBarHeight, 320, TABBARHEIGHT)];
    [tabbarView setBackgroundColor:[UIColor colorWithRed:232/255.0 green:233/255.0 blue:232/255.0 alpha:1.0]];
    [tabbarView setTag:tabbarTag];
    [self.view addSubview:tabbarView];
    
   
    NSLog(@"tabbarView.y : %f",tabbarView.frame.origin.y);
    for (int i = 0; i < tabbarCount; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(320/tabbarCount), 0, (320/tabbarCount), TABBARHEIGHT)];
        [button setTag:i + tabbarButtonTag];

        //新换的图，速度太慢。暂时注掉
        
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"clhbiao%d",i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"clhbiaodown%d",i]] forState:UIControlStateSelected];
       
        
        
        //原来的
       /*
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"fanChunagDown%d",i]] forState:UIControlStateSelected];
        //fanChunagDown%d
        [button setBackgroundImage:[Utils getImageFromProject:[NSString stringWithFormat:@"fangChuangNormal%d",i]] forState:UIControlStateNormal];
       */
        
        
        [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:button];
        
    }
    
}



- (void) setTabBarIndex : (int) index
{
    
    UIButton *button = (UIButton*)[self.view viewWithTag:index + tabbarButtonTag];
    [button setSelected:YES];
    [button setUserInteractionEnabled:NO];
}

- (void) setTabBarHidden : (BOOL) hidden
{
    if (tabbarView) {
        [tabbarView setHidden:hidden];
        [contentView setFrame:CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height+TABBARHEIGHT)];
        
//        [contentView setBackgroundColor:[UIColor orangeColor]];
    }
    
}

- (void)selectTab:(UIButton *)sender{
    
    if (sender.tag - tabbarButtonTag == 0) {
        @try {
              [JumpControl jumpToHome];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
      
    }
    else if (sender.tag - tabbarButtonTag == 1) {
        [JumpControl jumpProject];
    }
    else  {
        [Utils changeViewControllerWithTabbarIndex:sender.tag - tabbarButtonTag];
    }
    
}

#pragma mark - add navigation button
- (void) addBackButton
{
    UIView *view = [self.view viewWithTag:backButtonTag];
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
    
   //  UIImage *backImage = [UIImage imageNamed:@"01_anniu_3"];
    UIImage *backImage = [UIImage imageNamed:@"project_main_back-new"];
    //2014.08.11 chenlihua 返回按钮的图标
   // UIImage *backImage = [UIImage imageNamed:@"back-button.png"];
  //  UIImage *backImage=[UIImage imageNamed:@"zzxx.png"];
  //  UIImage *backimage=[UIImage imageNamed:@"crystal_back_button.png"];
    //2014.05.13 chenlihua 返回按钮增大触点面积
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //2014.07.27 chenlihua 将返回按钮变为原来的大小，使其不变形。
   // UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(0, -6, 50,50)];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTag:backButtonTag];
    //2014.08.11 chenlihua 点击区域变化，圆形老是变成椭圆。
    [backButton setImageEdgeInsets:UIEdgeInsetsMake((navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2, (navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2)];
    
    
    
//    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backButton];
    
    
    
    //加大返回按钮
    //2014.08.14 chenlihua 
    UIButton *NewBackButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    NewBackButton.frame=CGRectMake(0, 0, 100, 44);
    NewBackButton.backgroundColor=[UIColor clearColor];
    [NewBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:NewBackButton];
    

}

- (void) addLeftButton : (UIButton*) leftButton isAutoFrame : (BOOL) isAutoFrame
{
    UIView *view = [self.view viewWithTag:backButtonTag];
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
    
    if (isAutoFrame) {
        UIImage *image = nil;
        image = [leftButton backgroundImageForState:UIControlStateNormal];
        if (!image) {
            image = [leftButton imageForState:UIControlStateNormal];
        }
        
        [leftButton setFrame:CGRectMake(20, (navigationHeight  - image.size.height/2)/2, image.size.width/2, image.size.height/2)];
    }
    
    [leftButton setTag:backButtonTag];
    [navigationView addSubview:leftButton];
}

- (void) addRightButton : (UIButton*) rightButton isAutoFrame : (BOOL) isAutoFrame
{
    UIView *view = [self.view viewWithTag:rightButtonTag];
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
    
    if (isAutoFrame) {
        UIImage *image = nil;
        image = [rightButton backgroundImageForState:UIControlStateNormal];
        if (!image) {
            image = [rightButton imageForState:UIControlStateNormal];
        }
        
       [rightButton setFrame:CGRectMake((320 - image.size.width/2 - 20), (navigationHeight - image.size.height/2)/2, image.size.width/2, image.size.height/2)];
        rightButton.backgroundColor=[UIColor clearColor];
    }
    
    [rightButton setTag:rightButtonTag];
    [navigationView addSubview:rightButton];
}

#pragma mark - button action
- (void) backButtonAction : (id) sender
{
    NSLog(@"---------返回按钮---parent-------------");
    [self.navigationController popViewControllerAnimated:NO];
}


@end
