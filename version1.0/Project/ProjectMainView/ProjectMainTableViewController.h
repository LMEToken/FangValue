//
//  ProjectMainTableViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ProjectMainTopButtonView.h"
#import "PullingRefreshTableView.h"
#import "FangChuangInsiderViewController.h"
@interface ProjectMainTableViewController : ParentViewController
<ProjectMainTopButtonViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,UIGestureRecognizerDelegate>
{
    ProjectMainTopButtonView *TopButtonView;
    PullingRefreshTableView *myTableView;
    int currentPage;
    NSMutableArray *dataArray;
   
}
@property (nonatomic,strong) NSString *whereFlag;
@property (nonatomic,strong) NSString *searchString;
@end
