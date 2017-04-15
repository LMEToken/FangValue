//
//  FinancierProjectListViewController.h
//  FangChuang
//
//  Created by omni on 14-4-1.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"
#import "CacheImageView.h"
#import "JSONKit.h"
#import "Reachability.h"
@interface FinancierProjectListViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    PullingRefreshTableView *dataTableView;
    int currentPage;
    UILabel *DWlable;
    UILabel *HYlable;
    UILabel *RZElable;
    
    NSMutableArray *dataArray;
    NSDictionary *dataDic;
}


@end
