//
//  ProjectMainTableCellDetailViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ProjectMainTableViewController.h"
#import "FvaProDetailCell.h"
#import "FvaProDetailHeradCell.h"
#import "FvaProCompanInVC.h"
#import "PersonalDataVC.h"
#import "FvaProCrowdDataVC.h"
#import "ReaderDocument.h"
#import "ReaderViewController.h"
#import "ProjectFinanceTabelViewController.h"
#import "FangChuangInsiderViewController.h"
#import "NetManager.h"
#import "UIImageView+WebCache.h"
#import "FvalueWelcome.h"
#import "ChatWithFriendViewController.h"
@interface FvaProCellDetailVC : ParentViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIPageViewControllerDelegate,UISearchBarDelegate,UIPageViewControllerDelegate,UIScrollViewDelegate,UIPageViewControllerDelegate>
{
    UIScrollView *imageScrollView;
    UIPageControl *pageControl;
    NSInteger imageindex;
    NSInteger changeyes;
    
}
@property (nonatomic,strong) NSDictionary *ptfdic;
@property (nonatomic,strong) UITableView *DetailTableview;
@property (nonatomic,strong) NSString *titlename;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) UIView *allimageview;
@property (nonatomic,strong) FvalueWelcome *welview;
@end
