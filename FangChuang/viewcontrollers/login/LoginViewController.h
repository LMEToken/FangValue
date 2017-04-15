//
//  LoginViewController.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
//#import "AsyncSocket.h"
#import "Reachability.h"
#import "sqlite3.h"
@interface LoginViewController : ParentViewController<UITextFieldDelegate>

//@property(nonatomic,retain) AsyncSocket *loginSocket;

@property(nonatomic,retain) NSString *tokenPushString;
@end
