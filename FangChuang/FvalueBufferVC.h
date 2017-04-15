//
//  FvalueBufferVC.h
//  FangChuang
//
//  Created by weiping on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

//2014.05.21 chenlihua 解决方创信息保存在本地。
#import "Reachability.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

//2014.06.16 chenlihua JSONKit
#import "JSONKit.h"


#import "AsyncSocket+Single.h"

#import "AsyncSocket.h"
#import "socketNet.h"

#import "Utils.h"
#import "UserInfo.h"
#import "NetManager.h"
#import "UIView+ProgressView.h"
#import "NetManager.h"


#import "SDBManager.h"
#import "SUserDB.h"
#import "SUser.h"
#import "SQLite.h"

#import "Reachability.h"
#import "sqlite3.h"
  #import "NetTest.h"
@interface FvalueBufferVC : UIViewController
{
    SUserDB * _userDB;
    
    NSMutableArray * _userData;
    
    NSTimer *timerSocket;
    
    UIImageView *homeview;
    
    NSMutableArray *turnButtonArray;
    NSMutableArray *chooseArray;

}
@end
