//
//  NotifyVC.h
//  FangChuang
//
//  Created by weiping on 14-11-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FaFinancierWelcomeItemCell.h"
@interface NotifyVC : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong) UITableView *Notiftytableview;

@end
