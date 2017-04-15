//
//  XiangMuWenDangViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "APickerView.h"
#import "ReaderViewController.h"


@interface XiangMuWenDangViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,APickerViewDelegate>//ReaderContentViewDelegate
{
    
    UITableView* myTableView;
    APickerView *myPickerView;
    NSArray *docuArray;
    UILabel *docuLabel;
}
@property (nonatomic,retain) NSString *proid;
@end
