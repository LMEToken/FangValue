//
//  FMeansManageVC.h
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeansManageCell.h"
#import "FangChuangInsiderViewController.h"
#import "UIImageView+WebCache.h"
#import "EditordieViewControllerF.h"
@interface FMeansManageVC : ParentViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>
{
    UITextField *sex;
    UITextField *address;
    UITextField *company;
    UITextField  *position;
    UITextField *email;
    UIColor *textcolor;
    UIImageView *heradimage;
}
@property(nonatomic,strong)UITableView *SetTablview;
@end
