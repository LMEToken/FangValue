//
//  FvalueIndexVC.h
//  FangChuang
//
//  Created by weiping on 14-10-17.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"
#import "ButtonColumnView.h"
#import "FaFinancierWelcomeItemCell.h"
#import "NetManager.h"
#import "UIImageView+WebCache.h"
#import "SDBManager.h"
#import "SUserDB.h"
#import "SUser.h"
#import <sqlite3.h>
#import "SQLite.h"
#import "ChatWithFriendViewController.h"
#import "XiangMuJinZhanViewController.h"
#import "FangChuangRenWuViewController.h"
#import "RiChengBiaoViewController.h"
#import "Reachability.h"
#import "SearchResultViewController.h"
#import "XuanZeLianXiRenViewController.h"
#import "AppDelegate.h"
#import "NotifyVC.h"
#import "TGRImageViewController.h"
//#import "ZBarSDK.h"
@interface FvalueIndexVC : ParentViewController<ButtonColumnViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //选择聊天方向的按钮
    ButtonColumnView *topView;
    PullingRefreshTableView *myTableView;
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    //各自的红点
    UILabel *unLabel0;
    UILabel *unLabel00;
    UILabel *unLabel1;
    UILabel *unLabel2;
    UILabel *unLabel3;
    
  //一个cell的数据对象
     NSDictionary *dataDic;
    
    //不同的值 tableviewview的数据源将不一样
    NSInteger currentIndex;
    
    //数据查询数据的页数
    NSInteger  currentPage;
    
 

    
      SUserDB * _userDB;
    
    //4个类型的数据源
        NSMutableArray *dataArray[4] ;
    
    NSMutableArray *dgidarr;
    
  
    NSInteger  findstate;
    
    NSInteger choessvc;
   

}
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic,strong)NSMutableArray *arrUnSendCollection;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
@end
