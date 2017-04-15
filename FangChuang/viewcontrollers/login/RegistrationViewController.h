//
//  RegistrationViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "CacheImageView.h"

//2014.09.12 chenlihua 自定义相机
#import "SCNavigationController.h"



@interface RegistrationViewController : ParentViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SCNavigationControllerDelegate>
{
    UIImage *headImageView;
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIButton *but4;
    
    CacheImageView *headImage;
    NSString *userAccout;
    NSString *passWord;
    NSString *code;
    
}

- (id)initavlueNextaccout:(NSString*)useraccout password:(NSString*)password verificationcode:(NSString*)verificationcode;

@property (nonatomic , retain) NSDictionary* data;
@property (nonatomic , retain) NSString* type;
@property (nonatomic , retain) NSString* imagePath;
@end
