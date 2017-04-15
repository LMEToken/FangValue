//
//  FangChuangRenWuViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"

@interface FangChuangRenWuViewController : ParentViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PullingRefreshTableView *haoYoutableView;
    int currentPage;
    NSArray *array;
    NSMutableArray *dataArray;
}
@end
