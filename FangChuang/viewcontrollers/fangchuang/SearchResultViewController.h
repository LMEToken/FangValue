//
//  SearchResultViewController.h
//  FangChuang
//
//  Created by super man on 14-3-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface SearchResultViewController : ParentViewController<UITableViewDataSource , UITableViewDelegate>
{
    UITableView* myTableView;
}

@property (nonatomic , retain) NSString* key;
@property (nonatomic , retain) NSMutableArray* datas;


@end
