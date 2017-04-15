//
//  QunLiaoMingChengViewController.h
//  FangChuang
//
//  Created by super man on 14-3-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
#import "UserInfo.h"

#import "SUserDB.h"
@interface QunLiaoMingChengViewController : ParentViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
      MBProgressHUD *HUD;
    UITextField* nameTextField;
    NSMutableArray *dataArray[4];
    NSMutableArray * dgidarr;
     SUserDB * _userDB;
  
}
@property(nonatomic , retain) NSString* digId;
@property(nonatomic , retain) NSString* name;
@property (nonatomic ,retain)NSString *peoplecount;
@property(nonatomic,retain) NSString *groupChatName;
@end
