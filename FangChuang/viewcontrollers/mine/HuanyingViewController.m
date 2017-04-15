//
//  HuanyingViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//欢迎页
#import "HuanyingViewController.h"

@interface HuanyingViewController ()
@end

@implementation HuanyingViewController
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
    //[self setNavigationViewHidden:NO];
    [self setTabBarHidden:YES];
    [self setTitle:@"欢迎页"];
    [self addBackButton];
    [self addScrollView];
    [self addPageControl];
}
#pragma -mark -functions
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
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, screenWidth, self.contentViewHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"加%d.png",(i+1)]];
        imageView.tag = 110 + i;
        imageView.userInteractionEnabled=YES;
        [imageScrollView addSubview:imageView];
        a += screenHeight;
    }
}
#pragma -mark -UIPageViewControllerDelegate
-(void) addPageControl {
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.contentViewHeight-40, 320, 40)];
    //页数（几个圆圈）
    pageControl.numberOfPages = 3;
    pageControl.tag = 101;
    pageControl.currentPage = 0;
    [self.contentView addSubview:pageControl];
}
-(void) tap: (UITapGestureRecognizer*)sender{
     NSLog(@"tap %ld image",(long)pageControl.currentPage);
}
#pragma -mark -UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int current = scrollView.contentOffset.x/320;
    NSLog(@"current:%d",current);
    pageControl.currentPage = current;
}

@end
