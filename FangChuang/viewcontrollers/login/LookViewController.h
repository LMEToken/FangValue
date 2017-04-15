//
//  LookViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//开始启动时的欢迎页。
#import "ParentViewController.h"
#import "HomeLoginViewController.h"
#import "AppDelegate.h"
@interface LookViewController : ParentViewController<UIScrollViewDelegate,UIPageViewControllerDelegate>//UIPageViewControllerDataSource
{
    AppDelegate *app;
    UIScrollView *imageScrollView;
    UIPageControl *pageControl;
    
}

@end
