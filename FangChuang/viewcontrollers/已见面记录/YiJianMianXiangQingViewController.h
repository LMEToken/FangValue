//
//  YiJianMianXiangQingViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface YiJianMianXiangQingViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* myTableView;
    NSDictionary *dataDic;
}

@property (nonatomic , retain)NSArray* titleArray;
@property (nonatomic , retain)NSArray* contentArray;
@property (nonatomic , copy) NSString *meetid;
@end
