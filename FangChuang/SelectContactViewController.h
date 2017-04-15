//
//  SelectContactViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-4-25.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
#import "SUserDB.h"
@interface SelectContactViewController : ParentViewController
<UITableViewDataSource,UITableViewDelegate>
{
    SUserDB * _userDB;
    UITableView* myTableView;
    
    UITableView *downTable;
    NSMutableArray *downArray;
    
    NSMutableSet* dataSet; // 存放选中的联系人
    NSArray* data;//存放联系人
    
   
    
    //2014.05.30 chenlihua 解决添加群部分，上下滑动后，选中的部分会没有的问题。
    NSMutableArray *chooseArr;
    NSMutableArray *cancelArr;
    BOOL isHave;
    NSMutableArray * dataArray[4];
   NSInteger currentIndex;
    
    NSMutableArray *dataDic;
    NSDictionary *dic;
    NSArray *secLabelArray;
    NSArray *listarray;
    NSMutableArray *arrayDictKey;
    NSMutableDictionary *arrayDict;
    NSInteger findstate;
    
    NSInteger choessstate;
    
    
    
}

@property (nonatomic,retain) NSString *didString;
@property (nonatomic,strong)NSArray *guoluarr;
@property (nonatomic,strong) NSString  *quntype;



@end
