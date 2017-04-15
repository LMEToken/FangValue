//
//  ProjectViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"
#import "CacheImageView.h"





#import "JSONKit.h"
@interface ProjectViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
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
