//
//  FvaMyVC.h
//  FangChuang
//
//  Created by weiping on 14-9-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FvaMecell.h"
#import "FangChuangInsiderViewController.h"
#import "SetUPVC.h"
#import "CMeansManageVC.h"
#import "FMeansManageVC.h"
#import "TMeansManageVC.h"
#import "AppDelegate.h"
#import "GuanYuViewController.h"
//#import "JSONKit.h"
//#import "FangChuangInsiderViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"

#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"
@interface FvaMyVC : ParentViewController<UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>
{
    NSMutableArray *tableArray;
    UIView *backmyview;
    UIImageView *herdimage;

}
@property  (nonatomic,strong) UITableView *MyTablview;

@end
