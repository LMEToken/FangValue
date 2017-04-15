//
//  JinZhanXiangQingViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface JinZhanXiangQingViewController : ParentViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UIScrollView *myScrollView;
    UIImageView *imageView2;
    UITableView *liuYanView;
    //UITextView *neirongTextView;
    UITextView *messageTextView;
    UITextField *titleTextfield;
    NSString *content;
    
    NSDictionary *dataDic;
    NSArray *dataArray;
}
@property (nonatomic, copy) NSString *proid;
@end
