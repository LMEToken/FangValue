//
//  FvalueIndexVC.h
//  FangChuang
//
//  Created by weiping on 14-10-17.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "PullingRefreshTableView.h"


#import "ChatWithFriendViewController.h"

//#import "FangChuangInsiderViewController.h"
//#import "ZBarSDK.h"
@interface FvaluequnIndexVC : ParentViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{

    
    PullingRefreshTableView *myTableView;
    int currentPage;//页数
    NSInteger currentIndex ;
    
    
    NSMutableArray *dataArray;
    NSDictionary *dataDic;
    //2014.05.21 chenlihua 定时器实现主页面的实时刷新。以在主页面获取最新消息数。
    NSTimer *timer;
    //2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
    NSTimer *timerSecond;
    NSString *pushtoken;
    ButtonColumnView *topView;
    
    UILabel *unLabel0;
    UILabel *unLabel00;
    UILabel *unLabel1;
    UILabel *unLabel2;
    UILabel *unLabel3;
    
    //2014.06.19 chenlihua socket
    // AsyncSocket *socketUpdate;
    
    //2014.07.08 chenlihua 判断有没有网络
    NSTimer *timeNet;
    
    //2014.07.09 chenlihua sockete 有没有连接
    NSTimer *timerSocket;
    
    int tilletext;
    
    
}
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic,strong)NSMutableArray *arrUnSendCollection;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
@end
