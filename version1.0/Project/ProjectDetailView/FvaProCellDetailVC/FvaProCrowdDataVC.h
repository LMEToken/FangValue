//
//  FvaProCrowdDataVC.h
//  FangChuang
//
//  Created by weiping on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FvaProCrowdDataCell.h"
#import "FangChuangInsiderViewController.h"
@interface FvaProCrowdDataVC : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tableArray;
}
@property (nonatomic,strong)  UITableView *CrowdTableview;
@end
