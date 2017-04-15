//
//  YiJianMianJiLvViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface YiJianMianJiLvViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* myTableView;
}
@property (nonatomic, retain) NSMutableArray *dataArray;
@end
