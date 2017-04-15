//
//  FangChuangNeiBuViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ButtonView.h"
#import "FCSearchBar.h"
#import "CacheImageView.h"
@interface FangChuangNeiBuViewController : ParentViewController<ButtonViewDelegate,UITableViewDataSource,UITableViewDelegate,FCSearchBarDelegate>
{
    
    UITableView* myTableView;
    NSMutableArray *dataArray;
    NSDictionary *dataDic;
}
@end
