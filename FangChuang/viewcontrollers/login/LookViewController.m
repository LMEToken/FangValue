//
//  LookViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//欢迎页，首页启动页面
#import "LookViewController.h"
#import "InformationViewController.h"
#import "HomeViewController.h"
//2014.07.29 chenlihua 增加判断手机类型代码
#import "sys/utsname.h"


@interface LookViewController ()

@end

@implementation LookViewController
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationViewHidden:YES];
    [self setTabBarHidden:YES];
   // [[UIApplication sharedApplication]setStatusBarHidden:YES];
   // [self setStatusBarBackgroundView:nil];
	// Do any additional setup after loading the view.
    self.statusBarBackgroundView.backgroundColor=[UIColor clearColor];
    
    [self addScrollView];
    [self addPageControl];
    
    
}
//2014.07.29 chenlihua 增加判断手机类型代码

-(NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"IP4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"IP4";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}


-(void)addScrollView {
    
    imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, self.contentViewHeight)];
    [imageScrollView setBackgroundColor:[UIColor clearColor]];;
    [imageScrollView setContentSize:CGSizeMake(screenWidth*3, self.contentViewHeight)];
    [imageScrollView setBounces:NO];
    [imageScrollView setDelegate:self];;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:imageScrollView];

    int a = 0;
    int i = 0;
    for ( i = 0; i < 3; i++) {
        
        //修改相关代码，使3.5寸手机，4寸手机分别加载不同的欢迎页
        
        NSLog(@"---------手机尺寸------%@--",[self deviceString]);
        
        /*
        if ([[self deviceString] isEqualToString:@"IP4"]) {
            
         UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, screenWidth, self.contentViewHeight)];
         imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"IP%d.png",(i+1)]];
         imageView.tag = 110 + i;
         imageView.userInteractionEnabled=YES;
         [imageScrollView addSubview:imageView];
         
         
         
         a += screenHeight;
         
         
         if (i == 2) {
         
         UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
         [but setFrame:CGRectMake((320-311/2.)/2 + 2* 320, CGRectGetMaxY(imageView.frame) - 80, 311/2., 73/2.)];
         [but setBackgroundColor:[UIColor clearColor]];
         //  [but setBackgroundImage:[UIImage imageNamed:@"08_anniu_1"] forState:UIControlStateNormal];
         [but setBackgroundImage:[UIImage imageNamed:@"马上方创"] forState:UIControlStateNormal];
         [but addTarget:self action:@selector(pushFangchuangViewEvent:) forControlEvents:UIControlEventTouchUpInside];
         [imageScrollView addSubview:but];
         }

         
        }else{
            
         UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, screenWidth, self.contentViewHeight)];
         imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"加%d.png",(i+1)]];
         imageView.tag = 110 + i;
         imageView.userInteractionEnabled=YES;
         [imageScrollView addSubview:imageView];
         
         
         
         a += screenHeight;
         
         
         if (i == 2) {
         
         UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
         [but setFrame:CGRectMake((320-311/2.)/2 + 2* 320, CGRectGetMaxY(imageView.frame) - 80, 311/2., 73/2.)];
         [but setBackgroundColor:[UIColor clearColor]];
         //  [but setBackgroundImage:[UIImage imageNamed:@"08_anniu_1"] forState:UIControlStateNormal];
         [but setBackgroundImage:[UIImage imageNamed:@"马上方创"] forState:UIControlStateNormal];
         [but addTarget:self action:@selector(pushFangchuangViewEvent:) forControlEvents:UIControlEventTouchUpInside];
         [imageScrollView addSubview:but];
         }

         
        }
         */
        
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, screenWidth, self.contentViewHeight)];
        if (self.contentViewHeight==548) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"加%d.png",(i+1)]];
        }else
        {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"IP%d.png",(i+1)]];
            
        }
        imageView.tag = 110 + i;
        imageView.userInteractionEnabled=YES;
        [imageScrollView addSubview:imageView];
        
        
        
        a += screenHeight;
        
        
        if (i == 2) {
            
            UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
            [but setFrame:CGRectMake((320-311/2.)/2 + 2* 320, CGRectGetMaxY(imageView.frame) - 80, 311/2., 73/2.)];
            [but setBackgroundColor:[UIColor clearColor]];
          //  [but setBackgroundImage:[UIImage imageNamed:@"08_anniu_1"] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"马上方创"] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(pushFangchuangViewEvent:) forControlEvents:UIControlEventTouchUpInside];
            [imageScrollView addSubview:but];
        }
        
    }

}

-(void) addPageControl {
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.contentViewHeight-40, 320, 40)];
    pageControl.numberOfPages = 3;//页数（几个圆圈）
    pageControl.tag = 101;
    pageControl.currentPage = 0;
    
    [self.contentView addSubview:pageControl];
    
}

-(void) tap: (UITapGestureRecognizer*)sender{
    
    NSLog(@"tap %ld image",(long)pageControl.currentPage);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int current = scrollView.contentOffset.x/320;
    NSLog(@"current:%d",current);
    pageControl.currentPage = current;
    
}


- (void)pushFangchuangViewEvent:(UIButton *)sender{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

   [self dismissViewControllerAnimated:YES completion:nil];
}


@end
