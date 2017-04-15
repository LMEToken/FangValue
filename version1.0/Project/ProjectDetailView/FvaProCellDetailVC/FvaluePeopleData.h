//
//  FvaluePeopleData.h
//  FangChuang
//
//  Created by weiping on 14-11-14.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//



#import "ParentViewController.h"
#import "PresonlabelCell.h"
#import "PresonalDataCell.h"
#import "FangChuangInsiderViewController.h"
#import "ChatWithFriendViewController.h"
@interface FvaluePeopleData : ParentViewController<UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>
{
    NSMutableArray  *tableArray;
    UIImageView *herdimage;
}
@property (nonatomic,strong)  UITableView *PersonTableview;
@property(nonatomic,strong)  NSDictionary *peopledic;
@property (nonatomic,strong) NSString *peopleid;
@end