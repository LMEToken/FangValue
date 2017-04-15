//
//  GuideViewController.h
//  CraceInn
//  软件引导页
//  Created by Heidi on 13-5-8.
//  Copyright (c) 2013年 Heidi. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "MyPageControl.h"

@interface GuideViewController : UIViewController<UIScrollViewDelegate>
{
    MyPageControl *pageControl;
    UIScrollView *scrollView;
}

@end
