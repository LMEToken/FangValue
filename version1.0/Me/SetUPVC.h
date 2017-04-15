//
//  SetUPVC.h
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetUPCell.h"
#import "FangChuangInsiderViewController.h"
#import "STAlertView.h"
#import "FavalueChangeVC.h"
#import "ChatWithFriendViewController.h"
@interface SetUPVC : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) STAlertView *stAlertView;
@property  (nonatomic,strong) UITableView *SetTablview;
@end
