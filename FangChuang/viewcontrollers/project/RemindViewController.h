//
//  RemindViewController.h
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface RemindViewController : ParentViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *remindTable;
    int lastIndex;
    int nowIndex;
    NSArray *textArray;
}
@end
