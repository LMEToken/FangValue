//
//  FCSearchBar.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCSearchBar;
@protocol FCSearchBarDelegate <NSObject>

@required
- (void)FCSearchBarDidSearch:(FCSearchBar*)fcSearchBar text:(NSString*)text;

@end
@interface FCSearchBar : UIView<UITextFieldDelegate>
{
    UITextField* fcSearchBar;
    UIButton* keyButton; //监听键盘按钮
    
    //2014.09.10 chenlihua 加上语音按钮
    UIButton *fcYuYinButton;
    
}
@property(assign,nonatomic)id<FCSearchBarDelegate> delegate;
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
