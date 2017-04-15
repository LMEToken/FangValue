//
//  FCSearchBar.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//2014.07.10 chenlihua 方创主页面用

//搜索界面
#import "FCSearchBar.h"


@implementation FCSearchBar

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 320, 40)];
    
    if (self) {
        _delegate = delegate;
        
        //整个搜索的背景白色
       // UIImage* backImg = [UIImage imageNamed:@"74fangchuangguwen_sousuo_bg"];
        UIImageView* backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [backImgV setBackgroundColor:[UIColor clearColor]];
//        [backImgV setImage:backImg];
        [self addSubview:backImgV];

        //添加收缩框背景(椭圆的)
        // 608 * 58
        UIImage* souImg = [UIImage imageNamed:@"74fangchuangguwen_sousuo_kuang"];
        UIImageView* souImgV = [[UIImageView alloc] initWithFrame:CGRectInset(backImgV.frame, (40 - 58 / 2) / 2, (320 - 608 / 2) / 2)];
        [souImgV setImage:souImg];
        [self addSubview:souImgV];

        //添加搜索按钮(放大镜)
        //25 * 25
        UIImage* souBtnImg = [UIImage imageNamed:@"74fangchuangguwen_sousuo_icon"];
        UIButton* souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       // [souBtn setFrame:CGRectMake(CGRectGetMinX(souImgV.frame) + 5, CGRectGetMidY(souImgV.frame) - 25 / 4., 25 / 2., 25 / 2.)];
        //2014.09.10 chenlihua alan
        [souBtn setFrame:CGRectMake(CGRectGetMinX(souImgV.frame) + 130, CGRectGetMidY(souImgV.frame) - 25 / 4., 25 / 2., 25 / 2.)];
        [souBtn setBackgroundImage:souBtnImg forState:UIControlStateNormal];
        [souBtn addTarget:self action:@selector(searchStart:) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:souBtn];

        //搜索内容填写处
        fcSearchBar = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(souBtn.frame) + 5, CGRectGetMinY(souBtn.frame) - 2.5 / 2., CGRectGetWidth(souImgV.frame) -  CGRectGetMaxX(souBtn.frame) - 10, 25 / 2. + 2.5)];
        [fcSearchBar setDelegate:self];
        [fcSearchBar setFont:[UIFont systemFontOfSize:14]];
        [fcSearchBar setReturnKeyType:UIReturnKeySearch];
        [fcSearchBar setBorderStyle:UITextBorderStyleNone];
        [fcSearchBar setPlaceholder:@"搜索"];
        fcSearchBar.backgroundColor=[UIColor clearColor];
        [self addSubview:fcSearchBar];
        
        //2014.09.10 chenlihua 搜索按钮里加上语音
        //25 * 25
        UIImage* yuyinImg = [UIImage imageNamed:@"fangchuangSouSuoYuYin"];
        fcYuYinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fcYuYinButton setFrame:CGRectMake(CGRectGetMidY(souImgV.frame)+260, CGRectGetMidY(souImgV.frame) - 25 / 4.,22, 37/2.5)];
        [fcYuYinButton setBackgroundImage:yuyinImg forState:UIControlStateNormal];
        fcYuYinButton.backgroundColor=[UIColor clearColor];
        [fcYuYinButton addTarget:self action:@selector(doClickYuYin:) forControlEvents:UIControlEventTouchUpInside];
        [fcYuYinButton setBackgroundImage:yuyinImg forState:UIControlStateNormal];
       // [self addSubview:fcYuYinButton];

        
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
 
    return self;
}

#pragma  -mark -doClickAction
-(void)doClickYuYin:(UIButton *)btn
{
    ;
}
//点击放大镜按钮
- (void)searchStart:(UIButton*)button
{
    printf(__FUNCTION__);
    
    //2014.09.04 chenlihua 当输入内容为空的时候，会弹出提示
    if ([fcSearchBar.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"输入内空不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        //使键盘下滑平缓
        [UIView animateWithDuration:1.0 animations:^{
            [fcSearchBar resignFirstResponder];
        }];

        return;
        
    }

    
    if (_delegate && [_delegate respondsToSelector:@selector(FCSearchBarDidSearch: text:)]) {
        [_delegate FCSearchBarDidSearch:self text:fcSearchBar.text];
    }
    [fcSearchBar resignFirstResponder];
    [fcSearchBar setText:@""];
}
#pragma  -mark  -UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //2014.09.04 chenlihua 当输入内容为空的时候，会弹出提示
    if ([fcSearchBar.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"输入内空不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];

        //使键盘下滑平缓
        [UIView animateWithDuration:1.0 animations:^{
            [textField resignFirstResponder];
        }];
        
        
        return NO;
        
    }

    
    if (_delegate && [_delegate respondsToSelector:@selector(FCSearchBarDidSearch: text:)]) {
        [_delegate FCSearchBarDidSearch:self text:fcSearchBar.text];
        
        
            }
    
    [textField resignFirstResponder];
    [textField setText:@""];
    return YES;
}
#pragma -mark -functions
// 键盘弹起
- (void)keyboardWillShow:(NSNotification*)noti
{
    CGRect _keyboardRect = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSLog(@"_key = %@",NSStringFromCGRect(_keyboardRect));
    
    [UIView animateWithDuration:.35 animations:^{
        if (keyButton) {
            
            [keyButton setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), screenHeight)];
        }
        else
        {
            keyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [keyButton setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), screenHeight)];
            [keyButton addTarget:self action:@selector(keyDiss:) forControlEvents:UIControlEventTouchUpInside];
            [[self superview] addSubview:keyButton];
        }
    }];
}
//键盘消息
- (void)keyDiss:(UIButton*)button
{
    //质控
    [fcSearchBar resignFirstResponder];
    [fcSearchBar setText:@""];
}


// 键盘收起
- (void)keyboardWillHide:(NSNotification*)noti
{
    CGRect _keyboardRect = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"_key = %@",NSStringFromCGRect(_keyboardRect));

    [UIView animateWithDuration:.35 animations:^{
    }
                     completion:^(BOOL finished) {
                         
                         if (keyButton) {
                             [keyButton removeFromSuperview];
                             keyButton = nil;
                         }
                         
                     }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
