//
//  FvaProDetailHeradCell.h
//  FangChuang
//
//  Created by weiping on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangChuangInsiderViewController.h"
@interface FvaProDetailHeradCell : UITableViewCell<UIScrollViewDelegate,UIPageViewControllerDelegate,UISearchBarDelegate,UIPageViewControllerDelegate>
@property (nonatomic,strong) UIView *allimageview;
@property (nonatomic,strong) UIImageView *imageone1;
@property (nonatomic,strong) UIImageView *imageone2;
@property (nonatomic,strong) UIImageView *imageone3;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *imageScrollView;
@end
