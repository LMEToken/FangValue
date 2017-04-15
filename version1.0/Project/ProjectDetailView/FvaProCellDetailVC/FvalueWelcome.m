//
//  FvalueWelcome.m
//  test
//
//  Created by weiping on 14-11-15.
//  Copyright (c) 2014年 weiping. All rights reserved.
//

#import "FvalueWelcome.h"

@implementation FvalueWelcome

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addScrollView];
        [self addPageControl];
        // Initialization code
    }
    return self;
}
#pragma -mark -functions
-(void)addScrollView {
    imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [imageScrollView setBackgroundColor:[UIColor clearColor]];;
    [imageScrollView setContentSize:CGSizeMake(320*3, 200)];
    [imageScrollView setBounces:NO];
    [imageScrollView setDelegate:self];;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:imageScrollView];
    
    int a = 0;
    int i = 0;
    for ( i = 0; i < 3; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 100)];
//        imageView.image = [UIImage imageNamed:[self.imagelist objectAtIndex:i]];
//        imageView.tag = 110 + i;
//        imageView.userInteractionEnabled=YES;
//        [imageScrollView addSubview:imageView];
//        a +=200;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 100)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"加%d.png",(i+1)]];
        imageView.tag = 110 + i;
        imageView.userInteractionEnabled=YES;
        [imageScrollView addSubview:imageView];
        a +=200;
    }
}

#pragma -mark -UIPageViewControllerDelegate
-(void) addPageControl {
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 100-40, 320/2-140, 40)];
    //页数（几个圆圈）
    pageControl.numberOfPages = 3;
    pageControl.tag = 101;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
