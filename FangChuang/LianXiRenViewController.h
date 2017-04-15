//
//  LianXiRenViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"
//#import "AsyncSocket.h"

@interface LianXiRenViewController : ParentViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    PullingRefreshTableView *haoYoutableView;
    int currentPage;
    NSArray *array;
}
@end
