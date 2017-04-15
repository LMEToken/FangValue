//
//  TMeansManageVC.h
//  FangChuang
//
//  Created by weiping on 14-10-10.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MeansManageCell.h"
#import "FangChuangInsiderViewController.h"
#import "UIImageView+WebCache.h"
#import "EditordieViewController.h"
#import "SubordinateFieldVC.h"

@interface TMeansManageVC : ParentViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIViewControllerTransitioningDelegate>
{
    UIImageView *heradimage;//头像
    UITextView *textview;//公司简介
    UIColor *textcolor;//变换的颜色
    UITextField *sex;//性别
    UITextField *address;//地址
    UITextField *company;//所在地
    UITextField  *position;//公司
    UITextField *email;//邮箱
    
    UITextField *fundtype;//基金币种
    UITextField *likenum;//偏好额度
    UITextField *invest;//投资轮度
    UITextField *field;//关注领域
    
    UIButton *leftbtton;//编辑按钮
    NSInteger indexrow;
    NSInteger indexsesion;
  
    
}
@property(nonatomic,strong)UITableView *SetTablview;
@end