//
//  QiYeTuanDuiViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"

@interface QiYeTuanDuiViewController : ParentViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PullingRefreshTableView *haoYoutableView;
    int currentPage;
    NSArray *array;
    NSString *_proid;
    NSMutableArray *dataArray;
}
@property(nonatomic,copy)NSString *proid;
@end
