//
//  ProjectFinanceTabelViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ProjectFinanceTopButtonView.h"
#import "PullingRefreshTableView.h"
#import "FangChuangInsiderViewController.h"
@interface ProjectFinanceTabelViewController : ParentViewController
<ProjectFinanceTopButtonViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    ProjectFinanceTopButtonView *TopButtonView;
    PullingRefreshTableView *myTableView;
    int currentPage;
    
    UILabel *labelFirst;
    UILabel *labelSecond;
    UILabel *labelThree;
    UILabel *labelFour;
    
    NSDictionary *dic;
    NSArray *dataArray;
    
    
}
@property (nonatomic,strong) NSString *projectID;
@end
