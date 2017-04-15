//
//  FangChuangGuWenViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FCSearchBar.h"
#import "FangChuangInsiderViewController.h"
//2014.06.23 chenlihua socket
#import "AsyncSocket.h"
@interface FangChuangGuWenViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,FCSearchBarDelegate,AsyncSocketDelegate>
{
    
    UITableView* myTableView;
    NSMutableArray *dataArray;
    NSDictionary *dataDic;
    
    //2014.06.23 chenlihua socket
    //2014.07.01 chenlihua 使p001的账号从聊天记录跳转回方创部分的时候，会跳到t001的方创部分。
   // AsyncSocket *socketUpdate;
    
    //2014.07.10 chenlihua sockete 有没有连接
    NSTimer *timerSocket;
    
    //2014.08.05 chenlihua 定时器实现主页面的实时刷新。以在主页面获取最新消息数。
    NSTimer *timer;
     


}
//2014.06.23 chenlihua 所有的未读消息数
@property(nonatomic,retain) NSString *unReadAll;
//2014.07.01 chenlihua 使p001的账号从聊天记录跳转回方创部分的时候，会跳到t001的方创部分。
@property(nonatomic,retain) AsyncSocket *socketUpdate;
@end
