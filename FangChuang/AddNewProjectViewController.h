//
//  AddNewProjectViewController.h
//  FangChuang
//
//  Created by omni on 14-4-1.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ButtonView.h"
#import "CacheImageView.h"
#import "ModuleView.h"

@interface AddNewProjectViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,ButtonViewDelegate>
{
    UIView* headView;
    UIView* footView;
    UITableView* myTableView;
    CacheImageView* logoImageView;
    ModuleView* firstView;
    ModuleView* secondView;
    ModuleView* threeView;
    UILabel* sectionLabel;
    
    NSDictionary *dataDic;
    UIScrollView* imageScrollView;
    UIPageControl* imagePageControl;
    
}
@property (nonatomic,retain) NSString *proid;
@property (nonatomic , retain) NSArray* datas;


@end
