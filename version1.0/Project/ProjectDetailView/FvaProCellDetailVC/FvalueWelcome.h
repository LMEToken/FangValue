//
//  FvalueWelcome.h
//  test
//
//  Created by weiping on 14-11-15.
//  Copyright (c) 2014年 weiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FvalueWelcome : UIView<UIScrollViewDelegate,UIPageViewControllerDelegate>//UIPageViewControllerDataSource
{
    UIScrollView *imageScrollView;
    UIPageControl *pageControl;
}
@property(nonatomic,strong) NSArray *imagelist;
-(void)changeimage;
@end
