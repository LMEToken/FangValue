//
//  JinZhanXiangQingViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//项目进展详细页面

#import "JinZhanXiangQingViewController.h"
#define KUIFont  "FZLanTingHeiS-R-GB"
@interface JinZhanXiangQingViewController ()

@end

@implementation JinZhanXiangQingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadData
{
    [[NetManager sharedManager]getBoradInfoWithBoardid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"dataDic=%@",dataDic);
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
//- (void)loadMessageList
//{
//    [[NetManager sharedManager]getMessageListWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
//        NSLog(@"responseDic=%@",responseDic);
//    } fail:^(id errorString) {
//        [self.view showActivityOnlyLabelWithOneMiao:errorString];
//    }];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self setTabBarHidden:YES];
    [self setTitle:@"项目进展"];
	
    [self loadData];
}
#pragma -mark -functions
- (void)initContentView
{
    //UIScrollView
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myScrollView setBackgroundColor:[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]];
    [myScrollView setShowsHorizontalScrollIndicator:YES];
    
    //项目标题的背景框
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 310, 100)];
    [imageView setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [myScrollView addSubview:imageView];

    [self initView];
    
    //内容:Label
    UILabel *neironglab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 80, 50)];
    [neironglab setBackgroundColor:[UIColor clearColor]];
    [neironglab setTextColor:[UIColor orangeColor]];
    [neironglab setText:@"内容:"];
    [myScrollView addSubview:neironglab];

    //    neirongTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 160, 310, 550/2)] ;
    //
    ////    [neirongTextView setFrame:CGRectInset(imageView2.frame, 3, 2)];
    //    [neirongTextView setTextColor:[UIColor grayColor]];
    //    [Utils setDefaultFont:neirongTextView size:12];
    //    [neirongTextView.layer setCornerRadius:10];
    //    [neirongTextView setDelegate:self];
    //    [neirongTextView setBackgroundColor:[UIColor clearColor]];
    //    [neirongTextView setText:@"请输入文本"];
    //    [neirongTextView setReturnKeyType:UIReturnKeyDefault];
    //    [neirongTextView setKeyboardType:UIKeyboardTypeDefault];
    //    [neirongTextView setScrollEnabled:YES];
    //    [neirongTextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    //    [myScrollView addSubview: neirongTextView];
    //    [neirongTextView release];
    NSString *text = [dataDic objectForKey:@"content"];
    CGSize contentSize = [text sizeWithFont:[UIFont fontWithName:@KUIFont size:12] constrainedToSize:CGSizeMake(290, 9999) lineBreakMode:NSLineBreakByCharWrapping];
    
    //内容框
    UIImage* image = [[UIImage imageNamed:@"60_kuang_1"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];
    
    imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 160, 300, contentSize.height+10)];
    [imageView2 setImage:image];
    [myScrollView addSubview:imageView2];
    
    //内容的内容Label
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 165, 290, contentSize.height)];
    [contentLabel setNumberOfLines:0];
    [contentLabel setText:text];
    [contentLabel setFont:[UIFont fontWithName:@KUIFont size:12]];
    [contentLabel setTextColor:GRAY];
    [myScrollView addSubview:contentLabel];

     /*
     zhutc 去掉留言一下
     */
    /*
    UILabel *liuyanlab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView2.frame), 80, 50)];
    [liuyanlab setBackgroundColor:[UIColor clearColor]];
    [liuyanlab setTextColor:[UIColor orangeColor]];
    [liuyanlab setText:@"留言:"];
    [myScrollView addSubview:liuyanlab];
    [liuyanlab release];
    
    //
    //    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView2.frame)+50, 320, 120) style:UITableViewStylePlain];
    //    [tableView setBackgroundColor:[UIColor clearColor]];
    //    [tableView setDataSource:self];
    //    [tableView setDelegate:self];
    //    [myScrollView addSubview:tableView];
    //    [tableView release];
    UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(liuyanlab.frame)-7, 320, 1)];
    [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
    [myScrollView addSubview:xianNextIMG];
    [xianNextIMG release];
    
    [self initLiuYanView];
    
    
    UILabel *tiltelab =[[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(liuYanView.frame)+10, 50, 30)];
    [tiltelab setBackgroundColor:[UIColor clearColor]];
    [tiltelab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:tiltelab size:13];
    [tiltelab setText:@"标题:"];
    [myScrollView addSubview:tiltelab];
    [tiltelab release];
    
    UIImageView *kuangimageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(liuYanView.frame)+12, 260, 30)];
    [kuangimageView setImage:[UIImage imageNamed:@"10_shurukuang_3"]];
    [myScrollView addSubview:kuangimageView];
    [kuangimageView release];
    
    titleTextfield=[[UITextField alloc]initWithFrame:CGRectMake(55, CGRectGetMaxY(liuYanView.frame)+12, 260-10, 30-4)];
    [titleTextfield setBackgroundColor:[UIColor clearColor]];
    [titleTextfield setFont:[UIFont systemFontOfSize:12]];
    [titleTextfield setTextColor:GRAY];
    [titleTextfield setBorderStyle:UITextBorderStyleNone];
    [titleTextfield setKeyboardType:UIKeyboardTypeEmailAddress];
    [titleTextfield setDelegate:self];
    [myScrollView addSubview:titleTextfield];
    [titleTextfield release];
    
    
    UIImageView *kuangImageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)];
    [kuangImageView setImage:[UIImage imageNamed:@"10_shurukuang_4"]];
    [myScrollView addSubview:kuangImageView];
    [kuangImageView release];
    
    messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(kuangimageView.frame)+10, 260, 100)] ;
    [messageTextView setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:messageTextView size:12];
    [messageTextView.layer setCornerRadius:10];
    [messageTextView setDelegate:self];
    [messageTextView setBackgroundColor:[UIColor clearColor]];
    [messageTextView setText:@"请输入文本"];
    [messageTextView setReturnKeyType:UIReturnKeyDefault];
    [messageTextView setKeyboardType:UIKeyboardTypeDefault];
    [messageTextView setScrollEnabled:YES];
    [messageTextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [myScrollView addSubview: messageTextView];
    [messageTextView release];
    
    
    UIImage *image2=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(messageTextView.frame)+30, 508/2, 66/2)];
    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发表" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:button];
    
    
    [myScrollView setContentSize:CGSizeMake(320, 600+contentSize.height)];
    [self.contentView addSubview:myScrollView];
    [myScrollView release];
     */
    [myScrollView setContentSize:CGSizeMake(320, CGRectGetMaxY(imageView2.frame) + 20)];
    [self.contentView addSubview:myScrollView];

    
}
//项目，标题模块初始化
- (void)initView{
    
    NSArray *array=[NSArray arrayWithObjects:@"【项目】",@"【标题】", nil];
    NSArray *array2=[NSArray arrayWithObjects:@"发布人",@"消息ID", nil];
    NSArray *array3=[NSArray arrayWithObjects:@"发布时间",@"重要程度", nil];
    
    for (int i = 0; i < 2; i++) {
        
        //项目：，标题：Label
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(5, 15+25*i, 70, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor orangeColor]];
        [Utils setDefaultFont:lab size:16];
        [lab setText:[array objectAtIndex:i]];
        [myScrollView addSubview:lab];

        //发布人：，消息ID:Label
        UILabel *lab2 =[[UILabel alloc]initWithFrame:CGRectMake(10, 65+15*i, 70, 15)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setTextColor:[UIColor grayColor]];
        [Utils setDefaultFont:lab2 size:12];
        [lab2 setText:[array2 objectAtIndex:i]];
        [myScrollView addSubview:lab2];

        //发布时间:,重要程度：Label
        UILabel *lab3 =[[UILabel alloc]initWithFrame:CGRectMake(145, 65+15*i, 50, 15)];
        [lab3 setBackgroundColor:[UIColor clearColor]];
        [Utils setDefaultFont:lab3 size:12];
        [lab3 setTextColor:[UIColor grayColor]];
        [lab3 setText:[array3 objectAtIndex:i]];
        [myScrollView addSubview:lab3];
    }
    //项目内容
    UILabel *xiangmulab =[[UILabel alloc]initWithFrame:CGRectMake(65, 15+25*0, 150, 20)];
    [xiangmulab setBackgroundColor:[UIColor clearColor]];
    [xiangmulab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiangmulab size:16];
    [xiangmulab setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"proname"]]];
    [myScrollView addSubview:xiangmulab];

    //标题内容
    UILabel *biaotilab =[[UILabel alloc]initWithFrame:CGRectMake(65, 15+25*1, 150, 20)];
    [biaotilab setBackgroundColor:[UIColor clearColor]];
    [biaotilab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:biaotilab size:16];
    [biaotilab setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"title"]]];
    [myScrollView addSubview:biaotilab];

    //发布人内容
    UILabel *faburenlab2 =[[UILabel alloc]initWithFrame:CGRectMake(50, 65+15*0, 100, 15)];
    [faburenlab2 setBackgroundColor:[UIColor clearColor]];
    [faburenlab2 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:faburenlab2 size:12];
    [faburenlab2 setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"boardby"]]];
    [myScrollView addSubview:faburenlab2];

    //消息ID内容
    UILabel *xiaoxilab2 =[[UILabel alloc]initWithFrame:CGRectMake(50, 65+15*1, 100, 15)];
    [xiaoxilab2 setBackgroundColor:[UIColor clearColor]];
    [xiaoxilab2 setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:xiaoxilab2 size:12];
    [xiaoxilab2 setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"id"]]];
    [myScrollView addSubview:xiaoxilab2];

    //发布时间内容
    UILabel *fabushijianlab3 =[[UILabel alloc]initWithFrame:CGRectMake(193, 65+15*0, 120, 15)];
    [fabushijianlab3 setBackgroundColor:[UIColor clearColor]];
    [Utils setDefaultFont:fabushijianlab3 size:12];
    [fabushijianlab3 setTextColor:[UIColor grayColor]];
    [fabushijianlab3 setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"bydate"]]];
    [myScrollView addSubview:fabushijianlab3];

    //重要程度内容
    UILabel *zhongyaolab3 =[[UILabel alloc]initWithFrame:CGRectMake(193, 65+15*1, 100, 15)];
    [zhongyaolab3 setBackgroundColor:[UIColor clearColor]];
    [Utils setDefaultFont:zhongyaolab3 size:12];
    [zhongyaolab3 setTextColor:[UIColor grayColor]];
    [zhongyaolab3 setText:[NSString stringWithFormat:@": %@",[dataDic objectForKey:@"star"]]];
    [myScrollView addSubview:zhongyaolab3];
}
//暂时取消的消息
- (void)initLiuYanView{
    
    liuYanView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView2.frame)+50, 320, 120)];
    [liuYanView setBackgroundColor:[UIColor clearColor]];
    [liuYanView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [liuYanView setDataSource:self];
    [liuYanView setDelegate:self];
    [myScrollView addSubview:liuYanView];

//    NSArray *dataArray=[NSArray arrayWithObjects:
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"key1",@"2222",@"key2",@"3333",@"key3", nil],
//                               nil];
//    
//    
//    NSArray *array=[NSArray arrayWithObjects:@"发表于",@"标题",@"回复内容", nil];
//    
//    CGFloat nextHeight = 0;
//    
//    for (int i = 0; i < dataArray.count; i ++) {
//        
//        NSDictionary* dic = [dataArray objectAtIndex:i];
//        
//    
//        UIImageView *xianIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, nextHeight, 320, 1)];
//        [xianIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
//        [liuYanView addSubview:xianIMG];
//        [xianIMG release];
//
//        
//        
//        
//        for (int j = 0; j < array.count; j++) {
//            
//            UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(5, nextHeight, 50, 20)];
//            [lab setText:[array objectAtIndex:j]];
//            [lab setBackgroundColor:[UIColor clearColor]];
//            [lab setTextColor:[UIColor grayColor]];
//            [lab setTag:j+100];
//            [Utils setDefaultFont:lab size:12];
//            [liuYanView addSubview:lab];
//            [lab release];
//            
//            if (lab.tag==100) {
//                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key1"]]];
//            }else if (lab.tag==101){
//                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key2"]]];
//            }else if(lab.tag==102){
//                [lab setText:[NSString stringWithFormat:@"%@:%@",[array objectAtIndex:j],dic[@"key3"]]];
//            }
//
//            CGSize size = [lab.text sizeWithFont:lab.font constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:lab.lineBreakMode];
//            [lab setFrame:CGRectMake(5, nextHeight, size.width, 20)];
//            nextHeight = CGRectGetMaxY(lab.frame) ;
//            
//            NSLog(@"nextheig =%f",nextHeight);
//            
//        }
//        
//        UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, nextHeight, 320, 1)];
//        [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
//        [liuYanView addSubview:xianNextIMG];
//        [xianNextIMG release];
//        
//    }
//    
//    
//    [liuYanView setFrame:CGRectMake(0, CGRectGetMaxY(imageView2.frame)+50, 320, nextHeight)];
  
}
#pragma -mark -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 320, 20)];
        [dateLabel setText:[NSString stringWithFormat:@"发表于 ：2014-1-15"]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:GRAY];
        [Utils setDefaultFont:dateLabel size:12];
        [cell.contentView addSubview:dateLabel];

        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(dateLabel.frame), 320, 20)];
        [titleLabel setText:[NSString stringWithFormat:@"标题 ：士大夫士大夫三大发送"]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:GRAY];
        [Utils setDefaultFont:titleLabel size:12];
        [cell.contentView addSubview:titleLabel];

        CGSize size = {310,9999};
        content = @"发大水发大水发生的法师打发士大夫撒旦干撒的嘎嘎的世界观军";
        CGSize contentSize = [content sizeWithFont:[UIFont fontWithName:@KUIFont size:12] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLabel.frame), 310, contentSize.height)];
        [contentLabel setText:[NSString stringWithFormat:@"回复内容 ：%@",content]];
        [contentLabel setNumberOfLines:0];
        [contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [contentLabel setFont:[UIFont fontWithName:@KUIFont size:12]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:GRAY];
        [cell.contentView addSubview:contentLabel];

        
        UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(contentLabel.frame)+10, 320, 1)];
        [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
        [cell.contentView addSubview:xianNextIMG];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //return CGRectGetHeight(cell.frame);
    content = @"发大水发大水发生的法师打发士大夫撒旦干撒的嘎嘎的世界观军";
    CGSize contentSize = [content sizeWithFont:[UIFont fontWithName:@KUIFont size:12] constrainedToSize:CGSizeMake(310, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    return 20+20+contentSize.height+15;
}
#pragma  -mark -UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //[neirongTextView setText:@""];
    [messageTextView setText:@""];
    [UIView beginAnimations:@"" context:nil];
    self.contentView.frame=CGRectMake(0, -64, 320, self.contentViewHeight);
    [UIView commitAnimations];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        //[neirongTextView setText:@"请输入文本"];
        [messageTextView setText:@"请输入文本"];
        [UIView beginAnimations:@"" context:nil];
        self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
        [UIView commitAnimations];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma  -mark -TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [titleTextfield resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame=CGRectMake(0, 64, 320, self.contentViewHeight);
    }];
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame=CGRectMake(0, -94, 320, self.contentViewHeight);
    }];}

#pragma  -mark  -doClickAction
- (void)Submit:(UIButton *)sender{
    NSLog(@"发送");
    [[NetManager sharedManager]sendMessageWithProjectid:self.proid title:titleTextfield.text content:messageTextView.text username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"responserDic=%@",responseDic);
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
@end
