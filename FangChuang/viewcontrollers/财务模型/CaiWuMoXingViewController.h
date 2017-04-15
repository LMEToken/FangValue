//
//  CaiWuMoXingViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "APickerView.h"
@interface CaiWuMoXingViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,APickerViewDelegate>
{
    UITableView* myTableView;
    NSMutableArray* dataArray;
    //NSDictionary *dataDic;
    NSDictionary *rowDic;
    //NSDictionary *colDic;
    UILabel *yearLabel;
    
    APickerView *myPickerView;
    NSArray *yearArray;

}
@property (nonatomic,retain) NSString *proid;
@end
