//
//  ShangYeJiHuaViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ButtonView.h"
#import "CacheImageView.h"
#import "ModuleView.h"

@interface ShangYeJiHuaViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,ButtonViewDelegate>
{
    UIView* headView;
    UIView* footView;
    UITableView* myTableView;
    CacheImageView* logoImageView;
    ModuleView* firstView;
    ModuleView* secondView;
    ModuleView* threedView;
    UILabel* sectionLabel;
    
    NSDictionary *dataDic;
    UIScrollView* imageScrollView;
    UIPageControl* imagePageControl;
    
}
@property (nonatomic,retain) NSString *proid;
@property (nonatomic , retain) NSArray* datas;

@end
