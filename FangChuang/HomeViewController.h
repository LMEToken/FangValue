//
//  HomeViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FCSearchBar.h"

@interface HomeViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,FCSearchBarDelegate>
{
    
    UITableView* myTableView;
    
}
@end
