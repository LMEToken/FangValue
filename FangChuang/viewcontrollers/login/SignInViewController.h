//
//  SignInViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
//#import "AsyncSocket.h"

@interface SignInViewController : ParentViewController<UITextFieldDelegate>
{
    UITextField *nameTextField;
    UITextField *passTextField;
    UITextField *yzTextField;
    
    
}
@property(nonatomic , retain)    NSString* verificationcode; //验证码
//2014.04.24 chenlihua 推送消息的实现
@property(nonatomic,retain) NSString *tokenPushString;

//2014.06.19 chenliha socket
//@property(nonatomic,retain) AsyncSocket *signSocket;

@end
