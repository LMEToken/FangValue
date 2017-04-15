//
//  QunLiaoViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
//#import "AsyncSocket.h"

#import "Utils.h"
#import "FvalueIndexVC.h"

#import "FvaluePeopleData.h"
@interface QunLiaoViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
      MBProgressHUD *HUD;

    UITableView* myTableView;
    UIImageView* bcImgV;
    UILabel* titleLb;
    UIButton* arrowBtn;
    UIButton* btn;
    NSArray *savearr;
    NSMutableArray *dataArray[4];
    NSMutableArray *dgidarr;
    
    UIButton *clickbt1;

    BOOL hideen;
    NSInteger date;
    UIAlertView *promptAlert;
     SUserDB * _userDB;
}
@property (nonatomic,strong) NSString *qunzhuname;
@property(nonatomic , retain) NSMutableArray* datas;
@property(nonatomic , retain) NSString* digId;

@property(nonatomic,retain) NSString *qunChatName;

//2014.07.01 chenlihua 解决从群聊界面返回到聊天界面没有聊天消息的问题。
//@property(nonatomic,retain) AsyncSocket *qunLiaoSocket;

@end
