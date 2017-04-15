//
//  BMGuideViewController.m
//  CraceInn
//  软件引导页
//  Created by Heidi on 13-5-8.
//  Copyright (c) 2013年 Heidi. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"   

@implementation GuideViewController

#pragma mark - Initialize


#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame = CGRectMake(0, 0, screenWidth, [[UIScreen mainScreen] bounds].size.height);
    scrollView = [[UIScrollView alloc]
                                initWithFrame:CGRectMake(0, 0, 320,CGRectGetHeight(frame))];
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
        
    NSInteger count = 2;
    for (int i = 1; i <=count; i ++)
    {
        UIImageView *picture = [[UIImageView alloc] initWithFrame:
                                CGRectMake(0 + (i-1)*320, 0, 320, frame.size.height)];
        if (IS_IPHONE_5) {
            
            picture.image = [UIImage imageNamed:[NSString stringWithFormat:@"iphone5_%d.png",i ]];
        }
        else
           picture.image = [UIImage imageNamed:[NSString stringWithFormat:@"iphone4_%d.png",i ]];
        picture.backgroundColor = [Utils getRGBColor:i*40 g:i*30 b:i*50 a:1.0f];
        picture.userInteractionEnabled = YES;
        [scrollView addSubview:picture];
        scrollView.backgroundColor=[UIColor redColor];
        if (i == count )
        {
            UIButton *btnSkip = [[UIButton alloc] initWithFrame:
                                 CGRectMake(0, 0, 320, frame.size.height)];
            btnSkip.backgroundColor = [UIColor clearColor];
            [btnSkip setTitle:@"开始" forState:UIControlStateNormal];
            [btnSkip addTarget:self action:@selector(tologin) forControlEvents:UIControlEventTouchUpInside];
            [picture addSubview:btnSkip];

        }

    }
    scrollView.contentSize = CGSizeMake(320 * count, 160);
    [self.view addSubview:scrollView];

    
//    pageControl = [[MyPageControl alloc] initWithFrame:CGRectMake(120, frame.size.height - 30, 80, 12)];
//    pageControl.numberOfPages = count;      // total page
//    pageControl.currentPage = 0;        // current page
//    pageControl.hidesForSinglePage = YES;
//    pageControl.highlighted = YES;
//    pageControl.backgroundColor = [UIColor clearColor];
//    [pageControl setImagePageStateNormal:[Utils getImageFromProject:@"1_000133_1"]];
//    [pageControl setImagePageStateHightlighted:[Utils getImageFromProject:@"1_0000_2"]];
//    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:pageControl];
//    [pageControl release];
//    
//    UIImage* goImg = [Utils getImageFromProject:@"1_0000_1"];
//    
//    UIButton* goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [goBtn setBackgroundImage:goImg forState:UIControlStateNormal];
//    [goBtn setFrame:CGRectMake(320 + 160 - goImg.size.width/4.0, CGRectGetHeight(scrollView.frame) - 70, goImg.size.width/2.0, goImg.size.height/2.0)];
//    [goBtn addTarget:self action:@selector(tologin) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:goBtn];
    
}



#pragma mark - Button clicks
- (void)tologin
{
    //默认跳转到首页
    [Utils changeViewControllerWithTabbarIndex:4];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((offset.x - pageWidth / 2) / pageWidth) + 1;
	pageControl.currentPage = page;
    
//    NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
//    
//	for (int i = 0; i < [subView count]; i++) {
//		UIImageView *dot = [subView objectAtIndex:i];
//		dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"page_dot_highlighted"] :
//                     [UIImage imageNamed:@"page_dot"]);
//	}
}

#pragma mark - Button clicked
- (void) pageTurn: (UIPageControl *) aPageControl
{
	int whichPage = aPageControl.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	scrollView.contentOffset = CGPointMake(320.0f * whichPage, 0.0f);
	[UIView commitAnimations];
}

@end
