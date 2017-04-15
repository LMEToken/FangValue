//
//  RiChengBiaoViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "CalendarView.h"
#import "CalendarUtils.h"
#import "CalendarStyle.h"
@interface RiChengBiaoViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,CalendarViewDelegate>
{
    CalendarView *calendarView;
}
@property(nonatomic,assign)NSString *proid;

@property(nonatomic,retain) NSString *flag;
@end
