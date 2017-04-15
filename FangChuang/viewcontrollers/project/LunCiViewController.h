//
//  LunCiViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "APickerView.h"
#import "RTLabel.h"

@interface LunCiViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,APickerViewDelegate>
{
    UILabel *turnLabel;
    UITableView *myTableView;
    
    APickerView *myPickerView;
    NSArray *turnArray;
    NSDictionary *dataDic;
}
@property (nonatomic,copy) NSString* proid;
@end
