//
//  HomeApproveViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-10-23.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeApproveViewController : ParentViewController
<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    UIImageView *headImage;
    
    UIScrollView *backScrollerView;
    
    
    NSString *username;
    NSString *password;
    NSString *verificationcode;
    NSString *mobile;
    NSString *realname;
    NSString *comname;
    NSString *position;
    NSString *email;
    NSString *comurl;
    NSString *registerType;
    
    NSString *fmoney;
    NSString *statge;
    NSString *industry;
    NSString *pdesc;
    NSString *teamsize;
    NSString *proteam;
    NSString *currency;

    NSMutableArray *turnButtonArray;
    NSMutableArray *chooseArray;

}
@property (nonatomic,strong) NSString *flag;
@end
