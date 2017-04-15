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
#import "FangChuangInsiderViewController.h"
#import "FvaMyVC.h"
@interface EditordieViewControllerF : ParentViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UITextViewDelegate,UINavigationControllerDelegate,ToggleViewDelegate>

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
    UITextView *xiatextView;
    
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

}
@property(assign , nonatomic) id delegate;
- (id)initWithText:(NSString *)text1 Text:(NSString *)text2 Text:(NSString *)text3 Text:(NSString *)text4 Text:(NSString *)text5 Text:(NSString *)text6 Text:(NSString *)text7 Text:(NSString *)text8 Text:(NSString *)text9;
@end
