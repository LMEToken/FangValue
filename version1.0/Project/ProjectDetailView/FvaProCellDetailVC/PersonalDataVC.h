//
//  PersonalDataVC.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PresonlabelCell.h"
#import "PresonalDataCell.h"
#import "FangChuangInsiderViewController.h"
@interface PersonalDataVC : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *tableArray;
}
@property (nonatomic,strong)  UITableView *PersonTableview;
@property(nonatomic,strong)  NSDictionary *peopledic;
@property (nonatomic,strong) NSString *peopleid;

@end
