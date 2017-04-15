//
//  SahngYeJiHuaBianJiViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ButtonView.h"
#import "CacheImageView.h"
#import "ModuleView.h"

@interface SahngYeJiHuaBianJiViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,ButtonViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UIView* headView;
    UIView* footView;
    UITableView* myTableView;
    CacheImageView* logoImageView;
    ModuleView* firstView;
    ModuleView* secondView;
    ModuleView* threedView;
    UILabel* sectionLabel;
}
@property (nonatomic,retain) NSDictionary *myDic;
@end
