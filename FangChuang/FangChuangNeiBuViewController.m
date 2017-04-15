//
//  FangChuangNeiBuViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//方创内部,t的账户调用
//方创栏分为3个栏目。
#import "FangChuangNeiBuViewController.h"
#import "CacheImageView.h"
#import "XuanZeLianXiRenViewController.h"
#import "XiangMuWenDangViewController.h"
#import "FangChuangRenWuViewController.h"
#import "XiangMuJinZhanViewController.h"
#import "JinZhanXiangQingViewController.h"
#import "XiangMuJinZhanViewController.h"
#import "RiChengBiaoViewController.h"
#import "ChatWithFriendViewController.h"
#import "SearchResultViewController.h"
#import "FaFinancierWelcomeItemCell.h"


#import "ButtonColumnView.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"


@interface FangChuangNeiBuViewController ()
{
    int currentIndex;
}
@end

@implementation FangChuangNeiBuViewController
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        self.view = nil;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //2014.05.09 chenlihua 方创内部接口更改
    //第一次调用内部接口
    /*
    [[NetManager sharedManager] indexWithuserid:[[UserInfo sharedManager] username]   //接口后来更改 为 传username
                                          dtype:[NSString stringWithFormat:@"%d",currentIndex]
                                         hudDic:nil
                                        success:^(id responseDic) {
                                            //NSLog(@"response=%@",responseDic);
                                            NSDictionary *dic = [responseDic objectForKey:@"data"];
                                            dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];

                                            [myTableView reloadData];
                                        }
                                           fail:^(id errorString) {
                                               
                                           }];
     */
    
    [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username]  dtype:[NSString stringWithFormat:@"%d",currentIndex] perpage:@"20" pagenum:@"1" hudDic:nil success:^(id responseDic) {

        NSDictionary *dic = [responseDic objectForKey:@"data"];
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
        [myTableView reloadData];
        
    } fail:^(id errorString) {
        ;
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20] ];
	[self.titleLabel setText:@"方创"];
    [self setTabBarIndex:0];

    //右侧添加按钮
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [rtBtn setImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];
    
    //添加切换栏
    ButtonView* topView = [[ButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    [self.contentView addSubview:topView];
        
    //添加搜索栏
    FCSearchBar* searchBar = [[FCSearchBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 5, 0, 0) delegate:self];
    [self.contentView addSubview:searchBar];
    
    //添加列表
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame) + 5, 320, self.contentViewHeight - CGRectGetMaxY(searchBar.frame) -5) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];
    
    currentIndex = 1;
}
#pragma  -mark -doClickAction
- (void)rightButton:(UIButton*)button
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    // 动画时间控制
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //是否代理
    transition.delegate = self;
    // 是否在当前层完成动画
    transition.removedOnCompletion = NO;

    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;

    XuanZeLianXiRenViewController *viewCon = [[XuanZeLianXiRenViewController alloc]init];

    [self.navigationController pushViewController:viewCon animated:NO];
    // 动画事件
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}
#pragma mark - buttonView delegate
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonView *)view
{
    printf("%d",index);

    //方创邮件
    if (index == 3) {
        [self.view showActivityOnlyLabelWithOneMiao:@"敬请期待方创邮功能"];
        return;
    }
    currentIndex = index + 1;

    //2014.05.09 chenlihua 接口暂时更改
    // 前三个
    /*
    [[NetManager sharedManager] indexWithuserid:[[UserInfo sharedManager] username]   //接口后来更改 为 传username
                                          dtype:[NSString stringWithFormat:@"%d",index+1]
                                         hudDic:nil
                                        success:^(id responseDic) {
                                            NSDictionary *dic = [responseDic objectForKey:@"data"];
                                            dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
                                            NSLog(@"---dataArray=%@",dataArray);
                                            [myTableView reloadData];

                                        }
                                           fail:^(id errorString) {
                                               
                                           }];
    */
    
    [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username]  dtype:[NSString stringWithFormat:@"%d",index+1] perpage:@"20" pagenum:@"1" hudDic:nil success:^(id responseDic) {
        NSDictionary *dic = [responseDic objectForKey:@"data"];
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
        NSLog(@"---dataArray=%@",dataArray);
        [myTableView reloadData];

    } fail:^(id errorString) {
        ;
    }];
    
}
#pragma  -mark -FCSearchBar delegate
- (void)FCSearchBarDidSearch:(FCSearchBar *)fcSearchBar text:(NSString *)text
{
    NSLog(@"text = %@",text);
    
    SearchResultViewController* viewController = [[SearchResultViewController alloc] init];
    [viewController setKey:text];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    dataDic = [dataArray objectAtIndex:indexPath.row];
    NSString *type = [dataDic objectForKey:@"dataflag"];
    
    FaFinancierWelcomeItemCell* recell = nil;

    if ([type isEqualToString:@"board"]) {
        FaFinancierWelcomeItemCell* cell = [[FaFinancierWelcomeItemCell alloc] init];
        [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:15]];
        [cell.titleLab setText:@"【项目进展】"];
        
        [cell.subTitleLab setFrame:CGRectMake(CGRectGetWidth(cell.avatar.frame)+22, CGRectGetMaxY(cell.titleLab.frame), 205, 20)];
        [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];
        recell = cell;
        
    }
    if ([type isEqualToString:@"task"]){
        FaFinancierWelcomeItemCell* cell = [[FaFinancierWelcomeItemCell alloc] init];
        [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:15]];
        [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:12]];
        [cell.titleLab setText:@"【方创任务】"];
        [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];
        [cell.contentView addSubview:cell.unReadImageV];

        recell = cell;
    }
    if ([type isEqualToString:@"schedule"])
    {
        FaFinancierWelcomeItemCell* cell = [[FaFinancierWelcomeItemCell alloc] init];
        
        [cell.titleLab setText:@"【我的日程】"];
        [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];

        recell = cell;
    }
    if ([type isEqualToString:@"discussion"]){
        
        static NSString* identifier = @"cellId";
        
        FaFinancierWelcomeItemCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[FaFinancierWelcomeItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        //@"【方创小秘书】"
        [cell.titleLab setText:[dataDic objectForKey:@"name"]];
        
        [cell.subTitleLab setHidden:YES];

        recell = cell;
    }
   // [recell.avatar getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]]];
    //2014.06.12 chenlihua 修改图片缓存方式
    [recell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] ];
    return recell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataDic = [[NSDictionary alloc]initWithDictionary:[dataArray objectAtIndex:indexPath.row]];
    
    NSString *type = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"dataflag"]];
    if ([type isEqualToString:@"board"]) {
        
         XiangMuJinZhanViewController* viewController = [[XiangMuJinZhanViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([type isEqualToString:@"task"]){
        
        FangChuangRenWuViewController * viewController = [[FangChuangRenWuViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    else if ([type isEqualToString:@"order"])
    {
    
        RiChengBiaoViewController *rcVC=[[RiChengBiaoViewController alloc]init];
        [self.navigationController pushViewController:rcVC animated:YES];

    
    }
    else{
        ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
        viewCon.entrance = @"qun";
        viewCon.talkId=[dataDic objectForKey:@"id"];
        viewCon.titleName=[dataDic objectForKey:@"name"];
        viewCon.memberCount = [dataDic objectForKey:@"mcnt"];
                
        NSLog(@"viewCon.title %@",[NSString stringWithFormat:@"%@(%@)",viewCon.titleName,viewCon.memberCount]);
       [self.navigationController pushViewController:viewCon animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
@end
