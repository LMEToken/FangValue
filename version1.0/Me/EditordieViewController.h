//
//  EditordieViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "CacheImageView.h"
#import "ToggleView.h"
//2014.09.12 chenlihua 自定义相机
#import "SCNavigationController.h"
#import "ChangeSexVC.h"
#import "FangChuangInsiderViewController.h"
#import "TeamScaleVC.h"
#import "StagaVC.h"
#import "SubordinateFieldVC.h"
#import "RaisefundsVC.h"

@interface EditordieViewController : ParentViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UITextViewDelegate,UINavigationControllerDelegate,ToggleViewDelegate,SCNavigationControllerDelegate>

{
  //  CacheImageView *headimageView;
    //2014.06.13 chenlihua 修改头像缓存方式
    UIImageView *headimageView;
    
    UITextField *XMTextField;
    UITextField *XBTextField;
    UITextField *ZWTextField;
    UITextField *GWTextField;
    UITextField *FGTextField;
    UITextField *SJTextField;
    UITextField *WXHTextField;
    UITextField *EmailTextField;
    UITextField *LLTextField;
    UITextField *xiatextView;
    UITextField *rongziField;
    UITextView *gongsijj;
    
    NSString *textStr1;
    NSString *textStr2;

    NSString *textStr3;
    NSString *textStr4;
    NSString *textStr5;
    NSString *textStr6;
    NSString *textStr7;
    NSString *textStr8;
    NSString *textStr9;
    
    ToggleView* toggleViewBaseChange;
    UIImageView *onView;
    UIImageView *offView;
    BOOL isNewRemind;
    
    
    UIScrollView *inforView;
    
   
}
@property(nonatomic,strong)   UITextField *XBTextField;

@property(assign , nonatomic) id delegate;
- (id)initWithText:(NSString *)text1 Text:(NSString *)text2 Text:(NSString *)text3 Text:(NSString *)text4 Text:(NSString *)text5 Text:(NSString *)text6 Text:(NSString *)text7 Text:(NSString *)text8 Text:(NSString *)text9;

@property(nonatomic,strong) NSString *whereFromString;

@end
