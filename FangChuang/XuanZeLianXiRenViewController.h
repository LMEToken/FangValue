//
//  ContactViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"
#import "CacheImageView.h"
#import "FangChuangInsiderViewController.h"
//2014.07.07 chenlihua socket
#import "QunLiaoMingChengViewController.h"
#import "JSONKit.h"
#import "ChineseToPinyin.h"
@interface XuanZeLianXiRenViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    UITableView *haoYoutableView;
    //int currentPage;
     UIAlertView *promptAlert;
    //NSMutableArray *dataArray;
    NSMutableArray *dataDic;
    NSDictionary *dic;
    NSArray *secLabelArray;
    NSArray *listarray;
    NSMutableArray *arrayDictKey;
    NSMutableDictionary *arrayDict;
    NSInteger findstate;
    
    NSMutableArray *chooseArr;
    NSMutableArray *cancelArr;
    BOOL isHave;
     NSMutableSet* dataSet; // 存放选中的联系人
     NSMutableArray *downArray;
}
//@property (nonatomic,strong) CacheImageView *headView;

//2014.06.12 chenlihua 修改图片缓存的方式
@property (nonatomic,strong) NSString *dtype;
@property (nonatomic,strong) UIImageView *headView;
//2014.07.07 chenlihua socket
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
@end
