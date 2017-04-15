//
//  FvaProCompanInVC.h
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FvaProDetailCell.h"
#import "FangChuangInsiderViewController.h"
@interface FvaProCompanInVC : ParentViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)  UITableView *CompanTableview;
@property (nonatomic,strong) NSDictionary *datadic;
@end
